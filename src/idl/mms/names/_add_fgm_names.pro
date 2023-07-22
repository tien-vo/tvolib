;+
; INTERNAL PROCEDURE: _fgm_names
;
; PURPOSE:
;       Add variables from the Fluxgate Magnetometer (FGM) to a dictionary of names.
;-
pro _add_fgm_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

; Flags
names_dict.fgm_flags = string(probe, drate, level, suffix, format='mms%s_fgm_flag_%s_%s%s')

; Magnetic field
names_dict.B_gse = string(probe, drate, level, suffix, format='mms%s_fgm_b_gse_%s_%s%s')
names_dict.B_gsm = string(probe, drate, level, suffix, format='mms%s_fgm_b_gsm_%s_%s%s')
names_dict.B_dmpa = string(probe, drate, level, suffix, format='mms%s_fgm_b_dmpa_%s_%s%s')

; Ephemerides
names_dict.R_gse = string(probe, drate, level, suffix, format='mms%s_fgm_r_gse_%s_%s%s')
names_dict.R_gsm = string(probe, drate, level, suffix, format='mms%s_fgm_r_gsm_%s_%s%s')
names_dict.R_gse_re = string(probe, drate, level, suffix, format='mms%s_fgm_r_gse_%s_%s%s_re')
names_dict.R_gsm_re = string(probe, drate, level, suffix, format='mms%s_fgm_r_gsm_%s_%s%s_re')

end
