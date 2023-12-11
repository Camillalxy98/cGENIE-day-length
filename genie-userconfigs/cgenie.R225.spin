#
# --- CONFIGURATION UPDATE ---------------------------------------------------------
#
# GOLDSTEIN
go_sodaylen=81000                      #solar day length
go_sidaylen=80790                      #sidereal day length
go_8=384                               #days per year
go_ediffpow1=1
go_ieos=1
go_iediff=1
go_ediff0=0.00001
go_imld=1
go_ctrl_diagmld=.TRUE.
# GOLDSTEINSEAICE
gs_sodaylen=81000                      #solar day length
gs_sidaylen=80790                      #sidereal day length
gs_8=384                               #days per year
gs_scf=1.5310134887695313
# EMBM
ea_sodaylen=81000                      #solar day length
ea_sidaylen=80790                      #sidereal day length
ea_8=384                               #days per year
ea_taux_u='R225.taux_u.dat'
ea_tauy_u='R225.tauy_u.dat'
ea_taux_v='R225.taux_v.dat'
ea_tauy_v='R225.tauy_v.dat'
ea_adv_u='R225.wvelx.dat'
ea_adv_v='R225.wvely.dat'
ea_par_albedo1d_name='R225.albd.dat'
#
# --- CLIMATE ---------------------------------------------------------
# 
# solar constant
ma_genie_solar_constant=1365.0
# set CO2-climate feedback
ea_36=y
#
# --- BIOLOGICAL NEW PRODUCTION ---------------------------------------
#
bg_par_bio_prodopt="NONE"
#
# --- DATA SAVING -----------------------------------------------------
#
bg_par_infile_sig_name='save_timeseries_EVERY000100.dat'
bg_par_infile_slice_name='save_timeslice_EVERY000100.dat'
bg_par_data_save_level=9
bg_ctrl_debug_lvl0=.true.
ma_debug_loop=1
#
# --- FORCINGS --------------------------------------------------------
#
# specify forcings
bg_par_forcing_name="pyyyyz.AGE"
bg_par_atm_force_scale_val_3=280.0E-6
bg_par_atm_force_scale_val_4=-6.5
bg_par_atm_force_scale_val_5=38.4
bg_par_atm_force_scale_val_10=7.0E-7
bg_par_atm_force_scale_val_11=-60
bg_par_atm_force_scale_val_12=0
bg_ctrl_force_ocn_age=.true.
# wind speed
bg_ctrl_force_windspeed=.true.
bg_par_windspeed_file='R225.windspeed.dat'
# geothermal heat flux
bg_ctrl_force_GOLDSTEInTS=.TRUE.
bg_par_Fgeothermal=0.075
#
# --- INITIAL CONDITIONS ----------------------------------------------
#
# ATMOSPHERIC CHEMISTRY
ac_atm_init_3=280.0E-06          # pCO2 [atm]
ac_atm_init_4=-6.5               # pCO2_13C [o/oo]
ac_atm_init_6=0.2095             # pO2 [atm]
ac_atm_init_10=7.0E-07           # pCH4 [atm]
ac_atm_init_11=-60.0             # pCH4_13C [o/oo]
# OCEAN CHEMISTRY
bg_ocn_init_3=2.244E-03          # DIC [mol/kg]
bg_ocn_init_4=0.4                # DIC_13C [o/oo]
bg_ocn_init_8=2.159E-06          # PO4 [mol/kg]
bg_ocn_init_10=1.696E-04         # O2 [mol/kg]
bg_ocn_init_12=2.363E-03         # ALK [mol/kg]
bg_ocn_init_35=10.0E-03          # Ca [mol/kg]
bg_ocn_init_48=0.0               # Color_R
bg_ocn_init_49=0.0               # Color_B
bg_ocn_init_50=5.282E-02         # Mg [mol/kg]
#
#
# --- END -------------------------------------------------------------
#
#
