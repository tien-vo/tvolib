pro tvo_mms_init, verbose=verbose, debug=debug, symbol=symbol, local=local, spdf=spdf, auth=auth

; ---- Defaults
if undefined(verbose) then verbose = 0
if undefined(spdf) then spdf = 0
if undefined(auth) then auth = 'public'
!quiet = ~verbose

; ---- Spedas initialization
; Debug
if defined(debug) then dprint, setdebug=debug
; Data directory
if defined(local) then if is_string(local) then data_dir = local else data_dir = './cdf/'
; Log into LASP SDC
_ = mms_login_lasp(login_info=file_which(string(auth, format='mms_%s_auth.sav')))
mms_init, local_data_dir=data_dir
mms_set_verbose, verbose

; ---- Plots
; User-defined symbol
if defined(symbol) then circ_sym, symbol
; Fix colors
tvlct, red, green, blue, /get
red[6]      = 225
green[4]    = 135
red[5]      = 255
green[5]    = 200
tvlct, red, green, blue
!p.charsize     = 1.5

; ---- Constant structure
_constants = { $
    spdf: spdf, $
    nan: !values.d_nan, $
    ; Earth radius [km]
    R_earth: 6378.1d, $
    ; Electron charge [C]
    e: 1.602176634d-19, $
    ; Electron mass [kg]
    me: 9.1093837015d-31, $
    ; Proton mass [kg]
    mp: 1.67262192369d-27, $
    ; Vacuum magnetic permeability [kg m A-2 s-2]
    mu0: 1.25663706212d-6, $
    ; FGM magnetic field uncertainty [nT]
    fgm_sig: 0.1d, $
    ; EDP electric field uncertainty [mV/m]
    edp_sig: 0.5d, $
    ; FPI density uncertainty [1/cc]
    fpi_dens_sig: 0.05d, $
    ; FPI velocity uncertainty [km/s]
    fpi_vel_sig: 10d, $
}
defsysv, '!tvo', _constants, 1

end
