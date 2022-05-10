## just in case probem with dependencies
install.packages(c("shiny", "dplyr", "DT",
                   "ggplot2", "ncdf4", "stringr"))
devtools::install_github("Atlantis-Ecosystem-Model/shinyrAtlantis")
library(shinyrAtlantis)
library(stringr)
library(tidyr)
library(dplyr)
library(ncdf4)
library(ggplot2)
## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Global vars   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
#main_directory   <- '~/trunk/example/'
main_directory <- '/home/por07g/Documents/Courses/Atlantis_Summit/trunk/example/'
initial_cond.nc  <-  paste0(main_directory, '/INIT_VMPA_Jan2015.nc')
groups.csv       <- paste0(main_directory, '/SETasGroupsDem.csv')
bgm.file         <- paste0(main_directory, '/VMPA_setas.bgm')
prm.file         <- paste0(main_directory,'/VMPA_setas_biol_fishing_Trunk.prm')
cum.depths       <- c(0, 20, 50, 100, 250, 700, 1200)
salinity.file    <- paste0(main_directory, 'inputs/forcisets/', "SETAS_VMPAsalt.nc")
temperature.file <- paste0(main_directory, 'inputs/forcisets/', "SETAS_VMPAtemp.nc")
exchange.file    <- paste0(main_directory, 'inputs/forcisets/', "SETAS_VMPAhydroA-E.nc")

## Dist
## imple horizontal probability distributions that can then be cut-and-pasted into an Atlantis parameter file (.prm).
obj <- make.sh.dist.object(bgm.file)
sh.dist(obj)

## Parameter file explorer
obj <- make.sh.prm.object(bgm.file, groups.csv, prm.file)
sh.prm(obj)

## Exploring the initial condition files
obj <- make.sh.init.object(bgm.file, initial_cond.nc)
sh.init(obj)

input.object <- make.sh.forcings.object(
  bgm.file         = bgm.file,
  exchange.file    = exchange.file,
  cum.depth        = cum.depths,
  temperature.file = temperature.file,
  salinity.file    = salinity.file
)

sh.forcings(input.object)

## Feeding explorer function
sh.feeding(groups.csv, prm.file, initial_cond.nc)


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~          Initial Conditions      ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Initial condition North SEa model
NSgrp.file = '/home/por07g/Documents/Projects/North-Sea/JPG_North_Sea_Atlantis/New_inital_conditions/functionalGroups.csv'
NSbgm.file = '/home/por07g/Documents/Projects/North-Sea/JPG_North_Sea_Atlantis/New_inital_conditions/NorthSea.bgm'
NScum.depths = c(0, 10, 20, 50, 92, 192, 500)
csv.name = 'North_Sea'
## Create the templates
make.init.csv(NSgrp.file, NSbgm.file, NScum.depths, csv.name)
## when teh templates ready
North_sea_filled_templates   <- paste0(csv.name, '_init_filled.csv')
North_sea_filled_templates.h <- paste0(csv.name, '_horiz_filled.csv')
nc.file <- 'New_init_NorthSea.nc'
make.init.nc(NSbgm.file, NScum.depths, North_sea_filled_templates, North_sea_filled_templates.h, nc.file)
