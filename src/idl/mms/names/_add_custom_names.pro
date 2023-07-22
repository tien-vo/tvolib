pro _add_custom_names, names_dict=names_dict, probe=probe, drate=drate, level=level, suffix=suffix

; Energy flux
names_dict.EF_ion_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_ion_energy_flux_%s%s')
names_dict.EF_elc_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_elc_energy_flux_%s%s')

names_dict.N_ion_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_ion_dens_%s%s')
names_dict.N_elc_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_elc_dens_%s%s')

names_dict.P_ion_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_ion_pres_%s%s')
names_dict.P_elc_fpi_feeps = string(probe, drate, suffix, format='mms%s_combined_elc_pres_%s%s')

end
