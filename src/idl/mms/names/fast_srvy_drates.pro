;+
; FUNCTION: fast_srvy_drates, drates
;
; PURPOSE:
;       Converts survey to fast data rate flags for EDP and FPI data.
;
; INPUT:
;       drates: str or list of str
;-
function fast_srvy_drates, drates

compile_opt idl2

_fast_srvy_drates = drates
idx = where(drates eq 'srvy', nidx)
if nidx gt 0 then _fast_srvy_drates[idx] = 'fast'

return, _fast_srvy_drates

end
