;+
; PROCEDURE: tvo_mms_load_edp, trange=trange, probes=probes, drates=drates
;
; PURPOSE:
;       Get MMS measurements from the Electric field Double Probes (EDP).
;
; KEYWORDS:
;       trange: 2-element array of time range. (Fmt: 'YYYY-MM-DD/hh:mm:ss')
;       probes: Which MMS spacecrafts? (Valid values: '1' '2' '3' '4')
;       drates: Instrument data rate (Valid values: 'srvy' 'brst' 'fast' 'slow')
;       E_?: Toggle to get EDP electric field in (GSE/GSM/DSL).
;       E_para: Toggle to get EDP parallel electric field.
;       keep_raw: Toggle to keep raw (unprocessed) variables.
;       suffix: Save processed variables with suffix.
;       error: 1 = Error during processing, 0 = No error.
;       verbose: Toggle for logging purposes.
;       wipe_cdf: Toggle to wipe source CDF files.
;−
pro tvo_mms_load_edp, $
    trange=trange, $
    probes=probes, $
    drates=drates, $
    E_gse=E_gse, $
    E_gsm=E_gsm, $
    E_dsl=E_dsl, $
    E_para=E_para, $
    keep_raw=keep_raw, $
    suffix=suffix, $
    error=error, $
    verbose=verbose, $
    wipe_cdf=wipe_cdf

compile_opt idl2

; Defaults
if undefined(suffix) then suffix = ''
error = 0

; Some preliminary error handling
if undefined(trange) or undefined(probes) or undefined(drates) then begin
    dprint, dlevel=-1, 'Undefined trange, probes, or drates'
    error = 1
    return
endif
if ~(defined(E_gse) or defined(E_gsm) or defined(E_dsl) or defined(E_para)) then return

; Query data
tvo_mms_init
foreach drate, drates do foreach probe, probes do begin

    drate = fast_srvy_drates(drate)

    dprint, dlevel=-1, string( $
        probe, drate, time_string(trange[0]), time_string(trange[1]), $
        format='Loading MMS%s %s EDP data from %s to %s.')
    mms_load_edp, $
        trange=trange, $
        probes=probe, $
        data_rate=drate, $
        datatype='dce', $
        suffix='_raw', $
        cdf_filenames=_file_names, $
        tplotnames=tplotnames, $
        spdf=!tvo.spdf, $
        /latest_version, $
        /time_clip
    if ~keyword_set(tplotnames) then begin
        error = 1
        dprint, dlevel=-1, string(probe, drate, format='Failed loading MMS%s %s EDP data.')
        return
    endif
    if defined(verbose) then begin
        dprint, dlevel=-1, 'Loaded files:'
        dprint, dlevel=-1, _file_names
    endif
    append_array, file_names, _file_names

    _process_edp_flags, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error
    _process_edp_e, $
        trange=trange, $
        probe=probe, $
        drate=drate, $
        E_gse=E_gse, $
        E_gsm=E_gsm, $
        E_dsl=E_dsl, $
        E_para=E_para, $
        in_suffix='_raw', $
        out_suffix=suffix, $
        error=error, $
        wipe_cdf=wipe_cdf

    if undefined(keep_raw) then remove_tvar, string(probe, drate, format='mms%s_edp_*_%s_l2_raw')

endforeach

if defined(wipe_cdf) then remove_files, file_names

end
