;+
; PROCEDURE: tvo_mms_load_mec, trange=trange, probes=probes, drates=drates
;
; PURPOSE:
;       Get attitude/ephemerides data from the Magnetic Ephemeris Coordinates (MEC).
;
; KEYWORDS:
;       trange: 2-element array of time range. (Fmt: 'YYYY-MM-DD/hh:mm:ss')
;       probes: Which MMS spacecrafts? (Valid values: '1' '2' '3' '4')
;       drates: Instrument data rate (Valid values: 'srvy' 'brst')
;       datatype: MEC data type (Valid values: 'epht89d' 'epht89q' 'ephs04d')
;       Kp: Toggle to load QinDenton Kp index.
;       Dst: Toggle to load QinDenton Dst index.
;       dipole_tilt: Toggle to load QinDenton dipole tilt angle (about y) in GSM.
;       eclipse_flag: Toggle to load eclipse flags.
;       Q_?: Toggle to load quaternions from ECI to (DBCS/DMPA/DSL/GSE/GSM).
;       keep_raw: Toggle to keep raw (unprocessed) variables.
;       suffix: Save processed variables with suffix.
;       error: 1 = Error during processing, 0 = No error.
;       verbose: Toggle for logging purposes.
;       wipe_cdf: Toggle to wipe source CDF files.
;-
pro tvo_mms_load_mec, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    datatype=datatype, $
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
    error=error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

compile_opt idl2

; Defaults
if undefined(datatype) then datatype = 'epht89d'
if undefined(suffix) then suffix = ''
error = 0

; Some preliminary error handling
if undefined(trange) or undefined(probes) or undefined(drates) then begin
    dprint, dlevel=-1, 'Undefined trange, probes, or drates'
    error = 1
    return
endif
if ~(defined(Kp) or defined(Dst) or defined(dipole_tilt) or defined(eclipse_flag) or $
    defined(Q_dbcs) or defined(Q_dmpa) or defined(Q_dsl) or defined(Q_gse) or defined(Q_gsm)) then return

; Query data
tvo_mms_init
foreach drate, drates do foreach probe, probes do begin

    dprint, dlevel=-1, string( $
        probe, drate, time_string(trange[0]), time_string(trange[1]), $
        format='Loading MMS%s %s MEC data from %s to %s.')
    mms_load_mec, $
        trange=trange, $
        probes=probe, $
        data_rate=drate, $
        datatype=datatype, $
        suffix='_raw', $
        cdf_filenames=_file_names, $
        tplotnames=tplotnames, $
        spdf=!tvo.spdf, $
        /latest_version, $
        /time_clip
    if ~keyword_set(tplotnames) then begin
        error = 1
        dprint, dlevel=-1, string(probe, drate, format='Failed loading MMS%s %s MEC data.')
        return
    endif
    if defined(verbose) then begin
        dprint, dlevel=-1, 'Loaded files:'
        dprint, dlevel=-1, _file_names
    endif
    append_array, file_names, _file_names

    _load_mec_ancillary, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        Kp=Kp, $
        Dst=Dst, $
        dipole_tilt=dipole_tilt, $
        eclipse_flag=eclipse_flag, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error
    _load_mec_cotrans, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        Q_dbcs=Q_dbcs, $
        Q_dmpa=Q_dmpa, $
        Q_dsl=Q_dsl, $
        Q_gse=Q_gse, $
        Q_gsm=Q_gsm, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error

    if undefined(keep_raw) then remove_tvar, string(probe, probe, format='mms%s_mec_*_raw* mms%s_defatt*')

endforeach

if defined(wipe_cdf) then remove_files, file_names

end
