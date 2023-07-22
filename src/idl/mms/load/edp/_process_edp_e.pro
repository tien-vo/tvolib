pro _process_edp_e, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    E_gse=E_gse, $
    E_gsm=E_gsm, $
    E_dsl=E_dsl, $
    E_para=E_para, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error, $
    wipe_cdf=wipe_cdf

compile_opt idl2, hidden

if defined(E_gse) then append_array, vars, 'E_gse'
if defined(E_gsm) then append_array, vars, 'E_gsm'
if defined(E_dsl) then append_array, vars, 'E_dsl'

; Calculate total error from E_error
E_dsl_name = tvo_mms_name('E_dsl', probe, drate, suffix=in_suffix)
E_error_name = tvo_mms_name('E_error', probe, drate, suffix=in_suffix)
if has_data(E_error_name, trange) then begin
    _E_dsl = tsample(E_dsl_name, trange, times=_t_dsl)
    _E_error = tsample(E_error_name, trange, times=_t_err)
    assert, array_equal(_t_dsl, _t_err)
    _Ex = _E_dsl[*, 0]
    _Ey = _E_dsl[*, 1]
    _Ez = _E_dsl[*, 2]
    _sig_Ex = _E_error[*, 0]
    _sig_Ey = _E_error[*, 1]
    _sig_Ez = _E_error[*, 2]
    _Emag = sqrt(_Ex^2 + _Ey^2 + _Ez^2)
    _E_error = sqrt((_Ex * _sig_Ex)^2 + (_Ey * _sig_Ey) ^2 + (_Ez * _sig_Ez)^2) / (_Emag > !tvo.edp_sig)
endif

; If E_error is not available (brst), then use error from E_para
E_para_name = tvo_mms_name('E_para', probe, drate, suffix=in_suffix)
if has_data(E_para_name, trange) then begin
    _E_para = tsample(E_para_name, trange, times=_t_para)
    _E_para_error = movavg(abs(_E_para[*, 0]), 3)
    _E_para = _E_para[*, -1]
    if undefined(_E_error) then _E_error = _E_para_error
    if defined(E_para) then begin
        E_para_out = tvo_mms_name('E_para', probe, drate, suffix=out_suffix)
        get_data, E_para_name, dlimits=dlimits, limits=limits
        store_data, E_para_out, $
            data={x: _t_para, y: [[_E_para], [_E_para_error]]}, $
            dlimits=dlimits, $
            limits=limits
        options, E_para_out, $
            labflag=-1, $
            colors=[0, 1], $
            labels=['E!D||!N', 'Error'], $
            ytitle=string(probe, format='MMS%s E!D||!N EDP'), $
            ysubtitle='(' + dlimits.CDF.VATT.UNITS + ')', $
            databar={yval: 0, color: 0}
    endif
endif

; If cannot find error from both E_error and E_para, then just set to nan
if undefined(_E_error) then _E_error = !tvo.nan

; Rotate GSE to GSM
gse_name = tvo_mms_name('E_gse', probe, drate, suffix=in_suffix)
gsm_name = tvo_mms_name('E_gsm', probe, drate, suffix=in_suffix)
if array_contains(vars, 'E_gsm') and has_data(gse_name, trange) then begin
    if drate eq 'fast' then _drate = 'srvy' else _drate = drate
    tvo_mms_load_mec, trange=trange, probes=probe, drates=_drate, error=_error, wipe_cdf=wipe_cdf, /Q_gsm, /Q_gse
    if ~_error then mms_qcotrans, gse_name, gsm_name, in_coord='gse', out_coord='gsm'
    remove_tvar, [tvo_mms_name('Q_gse', probe, _drate), tvo_mms_name('Q_gsm', probe, _drate)]
endif

; Process other variables
foreach var, vars do begin

    in_name = tvo_mms_name(var, probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name(var, probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif
    get_data, in_name, data=data, dlimits=dlimits, limits=limits
    coord = strupcase(dlimits.data_att.COORD_SYS)
    t = data.x
    Nt = n_elements(t)

    if defined(_t_err) then assert, array_equal(t, _t_err) else if defined(_t_para) then assert, array_equal(t, _t_para)

    new_data = {x: t, y: dblarr(Nt, 5)}
    new_data.y[*, 0:2] = data.y[*, 0:2]
    new_data.y[*, 3] = _E_error
    new_data.y[*, 4] = -_E_error
    store_data, out_name, data=new_data, dlimits=dlimits, limits=limits
    options, out_name, $
        labflag=-1, $
        colors=[2, 4, 6, 1, 1], $
        labels=[['Ex ', 'Ey ', 'Ez '] + coord, 'Error'], $
        ytitle='MMS' + probe + ' E EDP', $
        ysubtitle='(mV/m)'

    if defined(_E_para) then begin
        new_data = {x: t, y: dblarr(Nt, 6)}
        new_data.y[*, 0:2] = data.y[*, 0:2]
        new_data.y[*, 3] = _E_para
        new_data.y[*, 4] = _E_error
        new_data.y[*, 5] = -_E_error
        store_data, out_name + '_with_Epara', data=new_data, dlimits=dlimits, limits=limits
        options, out_name + '_with_Epara', $
            labflag=-1, $
            colors=[2, 4, 6, 0, 1, 1], $
            labels=[['Ex ', 'Ey ', 'Ez '] + coord, 'E!D||!N', 'Error'], $
            ytitle='MMS' + probe + ' E EDP', $
            ysubtitle='(mV/m)'
    endif

endforeach

end
