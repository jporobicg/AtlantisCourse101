install.packages(c("shiny", "dplyr", "DT",
                   "ggplot2", "ncdf4", "stringr"))
devtools::install_github("Atlantis-Ecosystem-Model/shinyrAtlantis")
library(shinyrAtlantis)

## Dist
library(shinyrAtlantis)
bgm.file <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_12082019_xy.bgm'
obj <- make.sh.dist.object(bgm.file)
sh.dist(obj)


library(shinyrAtlantis)
bgm.file <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_12082019_xy.bgm'
grp.file <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_functional_groups_v5.csv'
prm.file <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_Biology_02092019_pprey05a_ddepend.prm'


obj <- make.sh.prm.object(bgm.file, grp.file, prm.file)
sh.prm(obj)


library(shinyrAtlantis)
library(stringr)
library(tidyr)
library(dplyr)
library(ncdf4)
library(ggplot2)
bgm.file <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_12082019_xy.bgm'
nc.file  <- '/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_InitCond_12082019.nc'
source('/home/por07g/R/shinyrAtlantis/R/shinit.R')
#debug(make.sh.init.object)
obj <- make.sh.init.object(bgm.file, nc.file)
sh.init(obj)

library(shinyrAtlantis)

salinity.file    <- "/OSM/CBR/OA_ALANTIS/work/Model_Run_files/inputs/SS_salt.nc"       # this file is not included in the package
temperature.file <- "/OSM/CBR/OA_ALANTIS/work/Model_Run_files/inputs/SS_temp.nc"       # this file is not included in the package
exchange.file    <- "/OSM/CBR/OA_ALANTIS/work/Model_Run_files/inputs/SS_hydro.nc" # this file is not included in the package
bgm.file <-'/OSM/CBR/OA_ALANTIS/work/Model_Run_files/SalishSea_12082019_xy.bgm'
cum.depth <- c(0, 25, 50, 100, 250, 400, 700)  # cumulative water layer depths

input.object <- make.sh.forcings.object(
  bgm.file         = bgm.file,
  exchange.file    = exchange.file,
  cum.depth        = cum.depth,
  temperature.file = temperature.file,
  salinity.file    = salinity.file
)

sh.forcings(input.object)


sh.feeding(grp.file, prm.file, nc.file)
