pro _process_fgm_b, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    B_gse=B_gse, $
    B_gsm=B_gsm, $
    B_dmpa=B_dmpa, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

if defined(B_gse) then append_array, vars, 'B_gse'
if defined(B_gsm) then append_array, vars, 'B_gsm'
if defined(B_dmpa) then append_array, vars, 'B_dmpa'

if defined(vars) then foreach var, vars do begin

    in_name = tvo_mms_name(var, probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name(var, probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif
    tplot_rename, in_name, out_name
    get_data, out_name, dlimits=dlimits
    options, out_name, $
        labflag=-1, $
        colors=[2, 4, 6, 0], $
        labels=[['Bx ', 'By ', 'Bz '] + strupcase(dlimits.data_att.COORD_SYS), '|B|'], $
        ytitle=string(probe, format='MMS%s B FGM'), $
        ysubtitle='(' + dlimits.CDF.VATT.UNITS + ')', $
        databar={yval: 0, color: 0}

endforeach

end
