;+
; INTERNAL PROCEDURE: _mec_names
;
; PURPOSE:
;       Add variables from the Magnetic Ephemerides Coordinates (MEC) to a dictionary of names.
;-
pro _add_mec_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

; Ancillary
names_dict.Kp = string(probe, suffix, format='mms%s_mec_kp%s')
names_dict.Dst = string(probe, suffix, format='mms%s_mec_dst%s')
names_dict.dipole_tilt = string(probe, suffix, format='mms%s_mec_dipole_tilt%s')
names_dict.earth_eclipse_flag = string(probe, suffix, format='mms%s_mec_earth_eclipse_flag%s')
names_dict.moon_eclipse_flag = string(probe, suffix, format='mms%s_mec_moon_eclipse_flag%s')
names_dict.eclipse_flag = string(probe, suffix, format='mms%s_mec_eclipse_flag%s')

; Cotrans
names_dict.Q_bcs = string(probe, suffix, format='mms%s_mec_quat_eci_to_bcs%s')
names_dict.Q_dbcs = string(probe, suffix, format='mms%s_mec_quat_eci_to_dbcs%s')
names_dict.Q_dmpa = string(probe, suffix, format='mms%s_mec_quat_eci_to_dmpa%s')
names_dict.Q_dsl = string(probe, suffix, format='mms%s_mec_quat_eci_to_dsl%s')
names_dict.Q_gse = string(probe, suffix, format='mms%s_mec_quat_eci_to_gse%s')
names_dict.Q_gsm = string(probe, suffix, format='mms%s_mec_quat_eci_to_gsm%s')

end
