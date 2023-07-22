pro _load_mec_ancillary, $
    trange=trange, $
    probe=probe, $
    drate=drate, $
    Kp=Kp, $
    Dst=Dst, $
    dipole_tilt=dipole_tilt, $
    eclipse_flag=eclipse_flag, $
    in_suffix=in_suffix, $
    out_suffix=out_suffix, $
    error=error

compile_opt idl2, hidden

if defined(Kp) then begin
    in_name = tvo_mms_name('Kp', probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name('Kp', probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif else begin
        tplot_rename, in_name, out_name
        options, out_name, $
            ytitle=string(probe, format='MMS%s MEC QinDenton Kp'), $
            ysubtitle=''
    endelse
endif

if defined(Dst) then begin
    in_name = tvo_mms_name('Dst', probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name('Dst', probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif else begin
        tplot_rename, in_name, out_name
        get_data, out_name, dlimits=dlimits
        options, out_name, $
            ytitle=string(probe, format='MMS%s MEC QinDenton Dst'), $
            ysubtitle='(' + dlimits.CDF.VATT.UNITS + ')', $
            databar={yval: 0, color: 0}
    endelse
endif

if defined(dipole_tilt) then begin
    in_name = tvo_mms_name('dipole_tilt', probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name('dipole_tilt', probe, drate, suffix=out_suffix)
    if ~has_data(in_name, trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif else begin
        tplot_rename, in_name, out_name
        get_data, out_name, dlimits=dlimits
        options, out_name, $
            ytitle=string(probe, format='MMS%s MEC dipole tilt'), $
            ysubtitle='(' + dlimits.CDF.VATT.UNITS + ')'
    endelse
endif

if defined(eclipse_flag) then begin
    earth_eclipse = tvo_mms_name('earth_eclipse_flag', probe, drate, suffix=in_suffix)
    moon_eclipse = tvo_mms_name('moon_eclipse_flag', probe, drate, suffix=in_suffix)
    out_name = tvo_mms_name('eclipse_flag', probe, drate, suffix=out_suffix)
    if ~has_data([earth_eclipse, moon_eclipse], trange, error=err_vars) then begin
        error = 1
        foreach var, err_vars do dprint, dlevel=-1, var + ' not loaded.'
        return
    endif else begin
        earth_eclipse = tsample(earth_eclipse, trange, times=t)
        moon_eclipse = tsample(moon_eclipse, trange, times=_t)
        assert, array_equal(t, _t)
        store_data, out_name, $
            data={x: t, y: logical_and(earth_eclipse, moon_eclipse)}, $
            dlimits={ytitle: 'Eclipse flag', yrange: [-1, 2], ystyle: 1}
    endelse
end

end
