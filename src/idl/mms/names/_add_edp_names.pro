;+
; INTERNAL PROCEDURE: _edp_names
;
; PURPOSE:
;       Add variables from the Electric field Double Probes (EDP) to a dictionary of names.
;-
pro _add_edp_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

_drate = fast_srvy_drates(drate)

; Flags
names_dict.edp_quality = string(probe, _drate, level, suffix, format='mms%s_edp_quality_%s_%s%s')
names_dict.edp_bitmask = string(probe, _drate, level, suffix, format='mms%s_edp_bitmask_%s_%s%s')

; Electric field
names_dict.E_gse = string(probe, _drate, level, suffix, format='mms%s_edp_dce_gse_%s_%s%s')
names_dict.E_gsm = string(probe, _drate, level, suffix, format='mms%s_edp_dce_gsm_%s_%s%s')
names_dict.E_dsl = string(probe, _drate, level, suffix, format='mms%s_edp_dce_dsl_%s_%s%s')
names_dict.E_para = string(probe, _drate, level, suffix, format='mms%s_edp_dce_par_epar_%s_%s%s')
names_dict.E_error = string(probe, _drate, level, suffix, format='mms%s_edp_dce_err_%s_%s%s')

end
