;+
; PROCEDURE: tvo_mms_load_fgm, trange=trange, probes=probes, drates=drates
;
; PURPOSE:
;       Get MMS measurements from the Fluxgate Magnetometer (FGM).
;
; KEYWORDS:
;       trange: 2-element array of time range. (Fmt: 'YYYY-MM-DD/hh:mm:ss')
;       probes: Which MMS spacecrafts? (Valid values: '1' '2' '3' '4')
;       drates: Instrument data rate (Valid values: 'srvy' 'brst' 'fast' 'slow')
;       B_?: Set to get FGM magnetic field in GSE/GSM/DMPA.
;       keep_raw: Toggle to keep raw (unprocessed) variables.
;       suffix: Save processed variables with suffix.
;       error: 1 = Error during processing, 0 = No error.
;       verbose: Toggle for logging purposes.
;       wipe_cdf: Toggle to wipe source CDF files.
;−
pro tvo_mms_load_fgm, $
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
if ~(defined(B_gse) or defined(B_gsm) or defined(B_dmpa) or defined(R_gse) or defined(R_gsm)) then return

; Query data
tvo_mms_init
foreach drate, drates do foreach probe, probes do begin

    dprint, dlevel=-1, string( $
        probe, drate, time_string(trange[0]), time_string(trange[1]), $
        format='Loading MMS%s %s FGM data from %s to %s.')
    mms_load_fgm, $
        trange=trange, $
        probes=probe, $
        data_rate=drate, $
        suffix='_raw', $
        cdf_filenames=_file_names, $
        tplotnames=tplotnames, $
        spdf=!tvo.spdf, $
        /latest_version, $
        /get_fgm_ephemeris, $
        /no_split_vars, $
        /time_clip
    if ~keyword_set(tplotnames) then begin
        error = 1
        dprint, dlevel=-1, string(probe, drate, format='Failed loading MM%s %s FGM data.')
        return
    endif
    if defined(verbose) then begin
        dprint, dlevel=-1, 'Loaded files:'
        dprint, dlevel=-1, _file_names
    endif
    append_array, file_names, _file_names

    _process_fgm_flags, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error
    _process_fgm_b, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        B_gse=B_gse, $
        B_gsm=B_gsm, $
        B_dmpa=B_dmpa, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error
    _process_fgm_r, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        R_gse=R_gse, $
        R_gsm=R_gsm, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error

    if undefined(keep_raw) then remove_tvar, string(probe, drate, format='mms%s_fgm_*_%s_l2_raw')

endforeach

if defined(wipe_cdf) then remove_files, file_names

end
