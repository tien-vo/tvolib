;+
; INTERNAL PROCEDURE: _feeps_names
;
; PURPOSE:
;       Add variables from the Fly's Eye Energetic Particle Sensor (FEEPS) to a dictionary of names.
;-
pro _add_feeps_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

prefix = string(probe, drate, level, format='mms%s_epd_feeps_%s_%s')

; ---- Percentage error
names_dict.feeps_t1_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_1%s')
names_dict.feeps_t2_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_2%s')
names_dict.feeps_t3_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_3%s')
names_dict.feeps_t4_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_4%s')
names_dict.feeps_t5_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_5%s')
names_dict.feeps_t6_error = string(prefix, suffix, format='%s_ion_top_percent_error_sensorid_6%s')
names_dict.feeps_t7_error = string(prefix, suffix, format='%s_ion_top_percent_error_sensorid_7%s')
names_dict.feeps_t8_error = string(prefix, suffix, format='%s_ion_top_percent_error_sensorid_8%s')
names_dict.feeps_t9_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_9%s')
names_dict.feeps_t10_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_10%s')
names_dict.feeps_t11_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_11%s')
names_dict.feeps_t12_error = string(prefix, suffix, format='%s_electron_top_percent_error_sensorid_12%s')
names_dict.feeps_b1_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_1%s')
names_dict.feeps_b2_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_2%s')
names_dict.feeps_b3_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_3%s')
names_dict.feeps_b4_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_4%s')
names_dict.feeps_b5_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_5%s')
names_dict.feeps_b6_error = string(prefix, suffix, format='%s_ion_bottom_percent_error_sensorid_6%s')
names_dict.feeps_b7_error = string(prefix, suffix, format='%s_ion_bottom_percent_error_sensorid_7%s')
names_dict.feeps_b8_error = string(prefix, suffix, format='%s_ion_bottom_percent_error_sensorid_8%s')
names_dict.feeps_b9_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_9%s')
names_dict.feeps_b10_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_10%s')
names_dict.feeps_b11_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_11%s')
names_dict.feeps_b12_error = string(prefix, suffix, format='%s_electron_bottom_percent_error_sensorid_12%s')

; ---- Number flux in each FEEPS eye
names_dict.NF_t1_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_1%s')
names_dict.NF_t2_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_2%s')
names_dict.NF_t3_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_3%s')
names_dict.NF_t4_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_4%s')
names_dict.NF_t5_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_5%s')
names_dict.NF_t6_feeps = string(prefix, suffix, format='%s_ion_top_intensity_sensorid_6%s')
names_dict.NF_t7_feeps = string(prefix, suffix, format='%s_ion_top_intensity_sensorid_7%s')
names_dict.NF_t8_feeps = string(prefix, suffix, format='%s_ion_top_intensity_sensorid_8%s')
names_dict.NF_t9_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_9%s')
names_dict.NF_t10_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_10%s')
names_dict.NF_t11_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_11%s')
names_dict.NF_t12_feeps = string(prefix, suffix, format='%s_electron_top_intensity_sensorid_12%s')
names_dict.NF_b1_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_1%s')
names_dict.NF_b2_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_2%s')
names_dict.NF_b3_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_3%s')
names_dict.NF_b4_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_4%s')
names_dict.NF_b5_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_5%s')
names_dict.NF_b6_feeps = string(prefix, suffix, format='%s_ion_bottom_intensity_sensorid_6%s')
names_dict.NF_b7_feeps = string(prefix, suffix, format='%s_ion_bottom_intensity_sensorid_7%s')
names_dict.NF_b8_feeps = string(prefix, suffix, format='%s_ion_bottom_intensity_sensorid_8%s')
names_dict.NF_b9_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_9%s')
names_dict.NF_b10_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_10%s')
names_dict.NF_b11_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_11%s')
names_dict.NF_b12_feeps = string(prefix, suffix, format='%s_electron_bottom_intensity_sensorid_12%s')

; ---- Omni-directional number flux
names_dict.NF_ion_feeps = string(prefix, suffix, format='%s_ion_intensity_omni%s')
names_dict.NF_elc_feeps = string(prefix, suffix, format='%s_electron_intensity_omni%s')
names_dict.NF_avg_ion_feeps = string(prefix, suffix, format='%s_ion_intensity_omni_avg%s')
names_dict.NF_avg_elc_feeps = string(prefix, suffix, format='%s_electron_intensity_omni_avg%s')

names_dict.N_ion_feeps = string(prefix, suffix, format='%s_ion_dens%s')
names_dict.N_elc_feeps = string(prefix, suffix, format='%s_electron_dens%s')
names_dict.P_ion_feeps = string(prefix, suffix, format='%s_ion_pres%s')
names_dict.P_elc_feeps = string(prefix, suffix, format='%s_electron_pres%s')

end
