pro _load_mec_cotrans, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    Q_dbcs=Q_dbcs, $
    Q_dmpa=Q_dmpa, $
    Q_dsl=Q_dsl, $
    Q_gse=Q_gse, $
    Q_gsm=Q_gsm, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

if defined(Q_dbcs) then append_array, vars, 'Q_dbcs'
if defined(Q_dmpa) then append_array, vars, 'Q_dmpa'
if defined(Q_dsl) then append_array, vars, 'Q_dsl'
if defined(Q_gse) then append_array, vars, 'Q_gse'
if defined(Q_gsm) then append_array, vars, 'Q_gsm'
if undefined(vars) then return

foreach var, vars do begin
    in_name = tvo_mms_name(var, probe, drate, suffix='_raw')
    out_name = tvo_mms_name(var, probe, drate, suffix=suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, in_name + ' not loaded.'
        return
    endif
    tplot_rename, in_name, out_name
endforeach

end
