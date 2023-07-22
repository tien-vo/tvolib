;+
; INTERNAL PROCEDURE: _fpi_names
;
; PURPOSE:
;       Add variables from the Fast Plasma Instrument (FPI) to a dictionary of names.
;-
pro _add_fpi_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

_drate = fast_srvy_drates(drate)

; Flags
names_dict.fpi_ion_flags = string(probe, _drate, suffix, format='mms%s_dis_errorflags_%s%s')
names_dict.fpi_ion_moms_flags = string(probe, _drate, suffix, format='mms%s_dis_errorflags_%s%s_moms')

names_dict.fpi_elc_flags = string(probe, _drate, suffix, format='mms%s_des_errorflags_%s%s')
names_dict.fpi_elc_moms_flags = string(probe, _drate, suffix, format='mms%s_des_errorflags_%s%s_moms')

; Energy channels
names_dict.fpi_ion_energy = string(probe, _drate, suffix, format='mms%s_dis_energy_%s%s')
names_dict.fpi_elc_energy = string(probe, _drate, suffix, format='mms%s_des_energy_%s%s')

; Energy flux
names_dict.EF_ion_fpi = string(probe, _drate, suffix, format='mms%s_dis_energyspectr_omni_%s%s')
names_dict.EF_elc_fpi = string(probe, _drate, suffix, format='mms%s_des_energyspectr_omni_%s%s')
names_dict.EF_ion_bg_fpi = string(probe, _drate, suffix, format='mms%s_dis_spectr_bg_%s%s')

; Density
names_dict.N_ion_bg_fpi = string(probe, _drate, suffix, format='mms%s_dis_numberdensity_bg_%s%s')
names_dict.N_ion_err_fpi = string(probe, _drate, suffix, format='mms%s_dis_numberdensity_err_%s%s')
names_dict.N_ion_fpi = string(probe, _drate, suffix, format='mms%s_dis_numberdensity_%s%s')
names_dict.Np_ion_fpi = string(probe, _drate, suffix, format='mms%s_dis_numberdensity_part_%s%s')

names_dict.N_elc_err_fpi = string(probe, _drate, suffix, format='mms%s_des_numberdensity_err_%s%s')
names_dict.N_elc_fpi = string(probe, _drate, suffix, format='mms%s_des_numberdensity_%s%s')
names_dict.Np_elc_fpi = string(probe, _drate, suffix, format='mms%s_des_numberdensity_part_%s%s')

; Velocity
names_dict.V_ion_err_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_err_%s%s')
names_dict.V_ion_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_dbcs_%s%s')
names_dict.V_ion_gse_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_gse_%s%s')
names_dict.V_ion_gsm_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_gsm_%s%s')
names_dict.Vp_ion_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_part_dbcs_%s%s')
names_dict.Vp_ion_gse_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_part_gse_%s%s')
names_dict.Vp_ion_gsm_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_part_gsm_%s%s')
names_dict.V_ion_dbcs_spin_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_spintone_dbcs_%s%s')
names_dict.V_ion_gse_spin_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_spintone_gse_%s%s')
names_dict.V_ion_gsm_spin_fpi = string(probe, _drate, suffix, format='mms%s_dis_bulkv_spintone_gsm_%s%s')

names_dict.V_elc_err_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_err_%s%s')
names_dict.V_elc_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_dbcs_%s%s')
names_dict.V_elc_gse_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_gse_%s%s')
names_dict.V_elc_gsm_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_gsm_%s%s')
names_dict.Vp_elc_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_part_dbcs_%s%s')
names_dict.Vp_elc_gse_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_part_gse_%s%s')
names_dict.Vp_elc_gsm_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_part_gsm_%s%s')
names_dict.V_elc_dbcs_spin_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_spintone_dbcs_%s%s')
names_dict.V_elc_gse_spin_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_spintone_gse_%s%s')
names_dict.V_elc_gsm_spin_fpi = string(probe, _drate, suffix, format='mms%s_des_bulkv_spintone_gsm_%s%s')

; Pressure
names_dict.P_ionTS_err_fpi = string(probe, _drate, suffix, format='mms%s_dis_prestensor_err_%s%s')
names_dict.P_ionTS_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_dis_prestensor_dbcs_%s%s')
names_dict.Pp_ionTS_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_dis_prestensor_part_dbcs_%s%s')
names_dict.P_ion_fpi = string(probe, _drate, suffix, format='mms%s_dis_pres_%s%s')
names_dict.Pp_ion_fpi = string(probe, _drate, suffix, format='mms%s_dis_pres_part_%s%s')
names_dict.P_ion_bg_fpi = string(probe, _drate, suffix, format='mms%s_dis_pres_bg_%s%s')

names_dict.P_elcTS_err_fpi = string(probe, _drate, suffix, format='mms%s_des_prestensor_err_%s%s')
names_dict.P_elcTS_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_des_prestensor_dbcs_%s%s')
names_dict.Pp_elcTS_dbcs_fpi = string(probe, _drate, suffix, format='mms%s_des_prestensor_part_dbcs_%s%s')
names_dict.P_elc_fpi = string(probe, _drate, suffix, format='mms%s_des_pres_%s%s')
names_dict.Pp_elc_fpi = string(probe, _drate, suffix, format='mms%s_des_pres_part_%s%s')

end
