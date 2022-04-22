# PLASIM-cGENIE
## Overview
1. [genie-main/configs](https://github.com/Camillalxy98/PLASIM-cGENIE/tree/master/genie-main/configs) contains the base-config that runs with the two user-configs in [genie-userconfigs](https://github.com/Camillalxy98/PLASIM-cGENIE/tree/master/genie-userconfigs).
2. [genie-forcings](https://github.com/Camillalxy98/PLASIM-cGENIE/tree/master/genie-forcings) contains the forcing file required in the user-configs.
3. The main genie modules (goldstein, goldsteinseaice, plasim and everything else in main) are copied in whole.
4. Original files have a '_1' after their file names.
## Parameterize day length
### In genie-main
In definition.xml, defined solar and siderial day lengths for goldstein, goldsteinseaice.
```
<param name="sodaylen">
    <value datatype="real">86400.0</value>
    <description>length of solar day in goldstein</description>
</param>
<param name="sidaylen">
    <value datatype="real">86164.0</value>
    <description>length of sidereal day in goldstein</description>
</param>
```
```
<param name="sodaylen">
    <value datatype="real">86400.0</value>
    <description>length of solar day in goldsteinseaice</description>
</param>
<param name="sidaylen">
    <value datatype="real">86164.0</value>
    <description>length of sidereal day in goldsteinseaice</description>
</param>
```
### In genie-goldstein and genie-goldsteinseaice
In initialise_goldstein.F and initialise_seaice.F, sodaylen or sidaylen are defined again to finish parameterization, which then replace hard-coded day length:
```
NAMELIST /ini_gold_nml/conserv_per,ans,yearlen,nyear,sodaylen,sidaylen
```
```
NAMELIST /ini_sic_nml/ans,yearlen,sodaylen,sidaylen,nyear,diffsic,scf,lout
```
```
c AY (05/05/04) : number of seconds per solar day
c     sodaylen = 86400.0
      if (debug_init) print*,'number of seconds per solar day'
      if (debug_init) print*,sodaylen

c AY (05/05/04) : number of seconds per sidereal day
c     sidaylen = 86164.0
      if (debug_init) print*,'number of seconds per sidereal day'
      if (debug_init) print*,sidaylen

      tv = sodaylen*yearlen/(nyear*tsc)
```
In ocean.cmn and seaice.cmn, sodaylen and sidaylen are added:
```
c AY (08/04/04) : seconds per solar day (necessary for GENIE)
      real sodaylen
      common /ocn_sodaylen/sodaylen

c AY (08/04/04) : seconds per sidereal day (necessary for GENIE)
      real sidaylen
      common /ocn_sidaylen/sidaylen
```
Replacement is also done with inm_netcdf.F, netcdf.F and surf_ocn_sic.F in goldstein; gold_seaice.F, inm_netcdf_sic.F, netcdf_sic.F, surflux_goldstein_seaice.F in goldsteinseaice.
## Run different day length
### In your configuration file
Besides the day length parameters you just defined, you also need to change values for year length (go_yearlen & gs_yearlen) and rotation speed factor (pl_rotspd).
PlaSim-cGENIE only supports certain day length (e.g., 12, 15, 18, 22.5).
Don't turn on gearing, i.e., pl_ngear=0.
