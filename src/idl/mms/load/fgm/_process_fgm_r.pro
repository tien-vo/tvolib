pro _process_fgm_r, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    R_gse=R_gse, $
    R_gsm=R_gsm, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

if defined(R_gse) then append_array, vars, 'R_gse'
if defined(R_gsm) then append_array, vars, 'R_gsm'
if undefined(vars) then return

foreach var, vars do begin

    in_name = tvo_mms_name(var, probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name(var, probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif
    get_data, in_name, data=data, dlimits=dlimits
    t = data.x
    R = data.y[*, 0:2]
    store_data, out_name, data={x: t, y: R}, dlimits=dlimits
    options, out_name, $
        labflag=-1, $
        colors=[2, 4, 6], $
        labels=[['X ', 'Y ', 'Z '] + strupcase(dlimits.data_att.COORD_SYS)], $
        ytitle=string(probe, format='MMS%s position'), $
        ysubtitle='(' + dlimits.CDF.VATT.UNITS + ')', $
        databar={yval: 0, color: 0}

    store_data, out_name + '_re', data={x: t, y: R / !tvo.R_earth}, dlimits=dlimits
    options, out_name + '_re', $
        labflag=-1, $
        colors=[2, 4, 6], $
        labels=[['X ', 'Y ', 'Z '] + strupcase(dlimits.data_att.COORD_SYS)], $
        ytitle=string(probe, format='MMS%s position'), $
        ysubtitle='(R!DE!N)', $
        databar={yval: 0, color: 0}

endforeach

end
