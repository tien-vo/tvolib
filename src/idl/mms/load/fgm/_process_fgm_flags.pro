pro _process_fgm_flags, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

in_name = tvo_mms_name('fgm_flags', probe, drate, suffix=in_suffix)
out_name = tvo_mms_name('fgm_flags', probe, drate, suffix=out_suffix)
if ~has_data(in_name, trange, error=err_vars) then begin
    error = 1
    foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
    return
endif
labels = ['MNVR', 'SHAD', 'NOISE', 'OFFST', 'B1SAT', 'B2SAT', 'B3SAT', 'RANGE', 'O3WARN', 'STWARN']
tplot_rename, in_name, out_name
options, out_name, $
    ytitle='FGM quality flags', $
    ysubtitle='(bit position)', $
    tplot_routine='bitplot', $
    psyms=1, $
    colors='lrbm', $
    labels=labels, $
    yrange=[-1, n_elements(labels)]

end
