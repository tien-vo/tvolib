;+
; FUNCTION: q_name = tvo_mms_name('R', '1', 'srvy')
; PURPOSE:
;       Get a string ID of MMS variable.
; INPUTS (required):
;       q: Which quantity?
;       probe: Which MMS spacecraft? (Valid values: '1' '2' '3' '4')
;       drate: Instrument data rate (Valid values: 'srvy' 'brst' 'fast' 'slow')
; OUTPUT: A string of name for MMS variables.
;−
function tvo_mms_name, quantity, probe, drate, level=level, suffix=suffix

if undefined(level) then level = 'l2'
if undefined(suffix) then suffix = ''

names_dict = dictionary()
_add_mec_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix
_add_fgm_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix
_add_edp_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix
_add_fpi_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix
_add_feeps_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix
_add_custom_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

q_name = names_dict[quantity]
return, q_name

end
