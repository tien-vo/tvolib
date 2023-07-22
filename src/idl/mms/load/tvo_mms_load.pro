;+
; PROCEDURE: tvo_mms_load [, trange, probes, drate]
;
; PURPOSE:
;       Wrapper for querying MMS data 
;
; KEYWORDS:
;       trange: 2-element array of time range. (Fmt: 'YYYY-MM-DD/hh:mm:ss')
;       probes: Which MMS spacecrafts? (Valid values: '1' '2' '3' '4')
;       drates: Instrument data rate (Valid values: 'srvy' 'brst')
;       keep_raw: Toggle to keep raw (unprocessed) variables.
;       suffix: Save processed variables with suffix.
;       error: 1 = Error during processing, 0 = No error.
;       verbose: Toggle for logging purposes.
;       wipe_cdf: Toggle to wipe source CDF files.
;-
pro tvo_mms_load, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    Kp=Kp, $
    Dst=Dst, $
    dipole_tilt=dipole_tilt, $
    eclipse_flag=eclipse_flag, $
    Q_dbcs=Q_dbcs, $
    Q_dmpa=Q_dmpa, $
    Q_dsl=Q_dsl, $
    Q_gse=Q_gse, $
    Q_gsm=Q_gsm, $
    B_gse=B_gse, $
    B_gsm=B_gsm, $
    B_dmpa=B_dmpa, $
    R_gse=R_gse, $
    R_gsm=R_gsm, $
    E_gse=E_gse, $
    E_gsm=E_gsm, $
    E_dsl=E_dsl, $
    E_para=E_para, $
    N_ion_fpi=N_ion_fpi, $
    V_ion_dbcs_fpi=V_ion_dbcs_fpi, $
    V_ion_gse_fpi=V_ion_gse_fpi, $
    V_ion_gsm_fpi=V_ion_gsm_fpi, $
    P_ion_fpi=P_ion_fpi, $
    EF_ion_fpi=EF_ion_fpi, $
    N_elc_fpi=N_elc_fpi, $
    V_elc_dbcs_fpi=V_elc_dbcs_fpi, $
    V_elc_gse_fpi=V_elc_gse_fpi, $
    V_elc_gsm_fpi=V_elc_gsm_fpi, $
    P_elc_fpi=P_elc_fpi, $
    EF_elc_fpi=EF_elc_fpi, $
    NF_ion_feeps=NF_ion_feeps, $
    NF_elc_feeps=NF_elc_feeps, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

compile_opt idl2

if ((size(probes))[0] eq 0) and (probes[0] eq 'all') then probes = ['1', '2', '3', '4']

tvo_mms_load_mec, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    Kp=Kp, $
    Dst=Dst, $
    dipole_tilt=dipole_tilt, $
    eclipse_flag=eclipse_flag, $
    Q_dbcs=Q_dbcs, $
    Q_dmpa=Q_dmpa, $
    Q_dsl=Q_dsl, $
    Q_gse=Q_gse, $
    Q_gsm=Q_gsm, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=mec_error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

tvo_mms_load_fgm, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    B_gse=B_gse, $
    B_gsm=B_gsm, $
    B_dmpa=B_dmpa, $
    R_gse=R_gse, $
    R_gsm=R_gsm, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=fgm_error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

tvo_mms_load_edp, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    E_gse=E_gse, $
    E_gsm=E_gsm, $
    E_dsl=E_dsl, $
    E_para=E_para, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=edp_error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

tvo_mms_load_fpi_moms, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    N_ion_fpi=N_ion_fpi, $
    V_ion_dbcs_fpi=V_ion_dbcs_fpi, $
    V_ion_gse_fpi=V_ion_gse_fpi, $
    V_ion_gsm_fpi=V_ion_gsm_fpi, $
    P_ion_fpi=P_ion_fpi, $
    EF_ion_fpi=EF_ion_fpi, $
    N_elc_fpi=N_elc_fpi, $
    V_elc_dbcs_fpi=V_elc_dbcs_fpi, $
    V_elc_gse_fpi=V_elc_gse_fpi, $
    V_elc_gsm_fpi=V_elc_gsm_fpi, $
    P_elc_fpi=P_elc_fpi, $
    EF_elc_fpi=EF_elc_fpi, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=fpi_moms_error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

tvo_mms_load_feeps, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    NF_ion_feeps=NF_ion_feeps, $
    NF_elc_feeps=NF_elc_feeps, $
    spin_duration=spin_duration, $
    avg_window=avg_window, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=feeps_error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

error = mec_error or fgm_error or edp_error or fpi_moms_error or feeps_error

end
