# Parameterize day length in cGENIE
## Overview
1. [genie-main/configs](https://github.com/Camillalxy98/cGENIE-day-length/tree/master/genie-main/configs) contains the base-config that runs with the four user-configs in [genie-userconfigs](https://github.com/Camillalxy98/cGENIE-day-length/tree/master/genie-userconfigs).
2. [genie-forcings](https://github.com/Camillalxy98/cGENIE-day-length/tree/master/genie-forcings) contains the forcing file required in the user-configs.
3. Wind and albedo fields required for embm and biogem need to be imported from another atmosphere GCM run with corresponding changes in day length. Fields listed in the four user-configs are included in [genie-embm/data/input](https://github.com/Camillalxy98/cGENIE-day-length/tree/master/genie-embm/data/input) and [genie-biogem/input](https://github.com/Camillalxy98/cGENIE-day-length/tree/master/genie-biogem/input).
4. The main genie modules (goldstein, goldsteinseaice, embm and everything else in main) are copied in whole.
5. Original files have a '_1' after their file names.
## Code modification
### In genie-main
In definition.xml, defined solar and siderial day lengths for goldstein, goldsteinseaice, and embm.
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
```
<param name="sodaylen">
    <value datatype="real">86400.0</value>
    <description>length of solar day in embm</description>
</param>
<param name="sidaylen">
    <value datatype="real">86164.0</value>
    <description>length of sidereal day in embm</description>
</param>
```
### In genie-goldstein, genie-goldsteinseaice and genie-embm
In initialise_goldstein.F, initialise_seaice.F and initialise_embm.F, sodaylen or sidaylen are defined again to finish parameterization, which then replace hard-coded day length (86400.0 or 24.0x60.0x60.0):
```
NAMELIST /ini_gold_nml/conserv_per,ans,yearlen,nyear,sodaylen,sidaylen
```
```
NAMELIST /ini_sic_nml/ans,yearlen,sodaylen,sidaylen,nyear,diffsic,scf,lout
```
```
NAMELIST /ini_embm_nml/sodaylen,sidaylen,yearlen,nyear,ndta,scf
```
```
c CL (01/15/24) : number of seconds per solar day
c     sodaylen = 86400.0
      if (debug_init) print*,'number of seconds per solar day'
      if (debug_init) print*,sodaylen

c CL (01/15/24) : number of seconds per sidereal day
c     sidaylen = 86164.0
      if (debug_init) print*,'number of seconds per sidereal day'
      if (debug_init) print*,sidaylen
```
In ocean.cmn, seaice.cmn and embm.cmn, sodaylen and sidaylen are added:
```
c CL (01/15/24) : seconds per solar day (necessary for GENIE)
      real sodaylen
      common /ocn_sodaylen/sodaylen

c CL (01/15/24) : seconds per sidereal day (necessary for GENIE)
      real sidaylen
      common /ocn_sidaylen/sidaylen
```
```
c CL (01/15/24) : seconds per solar day (necessary for GENIE)
      real sodaylen
      common /sic_sodaylen/sodaylen

c CL (01/15/24) : seconds per sidereal day (necessary for GENIE)
      real sidaylen
      common /sic_sidaylen/sidaylen
```
```
c CL (01/15/24) : seconds per solar day (necessary for GENIE)
      real sodaylen
      common /embm_sodaylen/sodaylen

c CL (01/15/24) : seconds per sidereal day (necessary for GENIE)
      real sidaylen
      common /embm_sidaylen/sidaylen
```
Replacement is also done with inm_netcdf.F, netcdf.F and surf_ocn_sic.F in goldstein; gold_seaice.F, inm_netcdf_sic.F, netcdf_sic.F, surflux_goldstein_seaice.F in goldsteinseaice; inm_netcdf_embm.F, netcdf_embm.F in embm.

Sidereal day length was implicitly coded or used solar day length value when calculating Coriolis related parameters:
```
initialise_goldstein.F: fsc = 4.0*pi/sidaylen; adrag = 1.0/(adrag*sidaylen*fsc)
initialise_seaice.F: fsc = 4.0*pi/sidaylen
```
## Run different day length
### In your configuration file
Besides the day length parameters you just defined, you also need to change values for year length (go_yearlen, gs_yearlen, ea_yearlen).
