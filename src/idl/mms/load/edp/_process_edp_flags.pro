pro _process_edp_flags, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

quality_in = tvo_mms_name('edp_quality', probe, drate, suffix=in_suffix)
quality_out = tvo_mms_name('edp_quality', probe, drate, suffix=out_suffix)
bitmask_in = tvo_mms_name('edp_bitmask', probe, drate, suffix=in_suffix)
bitmask_out = tvo_mms_name('edp_bitmask', probe, drate, suffix=out_suffix)

if ~has_data([quality_in, bitmask_in], trange, error=err_vars) then begin
    error = 1
    foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
    return
endif

labels = ['OFFL', 'BAD BIAS', 'SAT', 'DENS', 'BIAS CRNT', 'SHAD', 'SPC CRNT', 'N/A', 'ASYM4', 'MNVR']
tplot_rename, bitmask_in, bitmask_out
options, bitmask_out, $
    ytitle='EDP bitmask', $
    ysubtitle='(bit position)', $
    tplot_routine='bitplot', $
    psyms=1, $
    colors='lrbm', $
    labels=labels, $
    yrange=[-1, n_elements(labels)]

; Derive custom quality from bits 5, 6, 7, 8
bits2, fix(total(2^[5, 6, 7, 8])), good_bits
get_data, bitmask_out, data=bitmask
N = n_elements(bitmask.x)
QF = make_array(N, /integer)
for i = 0l, N - 1l do begin
    bit = ishft(bitmask.y[i], -indgen(16)) and 1b
    QF[i] = ~any(logical_and(bit, ~good_bits))
endfor
store_data, quality_out, data={x: bitmask.x, y: QF}
options, quality_out, $
    ytitle='EDP quality', $
    ysubtitle='(0=bad, 1=good)', $
    yrange=[-1, 2]

end
