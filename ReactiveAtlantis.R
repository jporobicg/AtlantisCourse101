install.packages('devtools')   ## you need to do this step just once
# running
library("devtools")
install_github('Atlantis-Ecosystem-Model/ReactiveAtlantis', force=TRUE, dependencies=TRUE)

library(ReactiveAtlantis)
## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Global vars   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
main_directory   <- '~/trunk/example/'
#main_directory <- '/home/por07g/Documents/Courses/Atlantis_Summit/trunk/example/'
output_directory <- paste0(main_directory, 'outputFolder/output')
initial_cond.nc  <-  paste0(main_directory, '/INIT_VMPA_Jan2015.nc')
groups.csv       <- paste0(main_directory, '/SETasGroupsDem.csv')
bgm.file         <- paste0(main_directory, '/VMPA_setas.bgm')
prm.file         <- paste0(main_directory,'/VMPA_setas_biol_fishing_Trunk.prm')
fsh.csv          <- 'your_fisheries_definition_file.csv'
cum.depths       <- c(0, 20, 50, 100, 250, 700, 1200)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~          Compare previous run                ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
simulation01   <- '01'
simulation02   <- '00'
nc.out.current <- paste0(output_directory, simulation01, '/outputSETAS.nc')
nc.out.old     <- paste0(output_directory, simulation02, '/outputSETAS.nc')
## alone
compare(nc.out.current, nc.out.old=NULL, grp.csv = groups.csv,bgm.file=bgm.file, cum.depths=cum.depths)
## compare with other output
compare(nc.out.current, nc.out.old, grp.csv = groups.csv,bgm.file=bgm.file, cum.depths=cum.depths)

## ~~~~~~~~~~~~~~~~~ ##
## ~  Food web    ~ ##
## ~~~~~~~~~~~~~~~~~ ##
diet.file <- paste0(output_directory, simulation01, '/outputSETASDietCheck.txt')
food.web(diet.file, groups.csv)

## ~~~~~~~~~~~~~~~~~~ ##
## ~     Predation  ~ ##
## ~~~~~~~~~~~~~~~~~~ ##
biomass   <- paste0(output_directory, simulation01, '/outputSETASBiomIndx.txt')
diet.file <- paste0(output_directory, simulation01, '/outputSETASDietCheck.txt')
bio.age   <- paste0(output_directory, simulation01, '/outputSETASAgeBiomIndx.txt')

predation(biomass, groups.csv, diet.file, age.biomass=bio.age)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~             Predator-prey Interaction          ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
feeding.mat(prm.file, groups.csv,  initial_cond.nc, bgm.file, cum.depths)

## Currently under mayor surgery!
## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Recruitment   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
yoy.file       <- paste0(output_directory, simulation01, '/outputSETASYOY.txt')
nc.out.current <- paste0(output_directory, simulation01, '/outputSETAS.nc')
recruitment.cal(initial_cond.nc, nc.out.current, yoy.file, groups.csv, prm.file)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~             Growth Primary producers         ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
growth.pp(initial_cond.nc, groups.csv, prm.file, nc.out.current)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~         Skill Assessment     ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

catch.nc             <- paste0(output_directory, simulation01, 'your_output_CATCH.nc')
ext.catch.total      <- 'external_catch_time_serie.csv'
ext.catch.by.fleet   <- 'external_catch_time_serie_by_fleets.csv'
cum.depths  <- c(0, 20, 50, 150, 250, 400, 650, 1000, 4300) ## This should be the cummulative depth of your model

bgm.file    <- 'your_spatial_configuration_file.bgm'
grp.csv     <- 'your_groups_definition_file.csv'
catch(grp.csv, fsh.csv, catch.nc, ext.catch.total, ext.catch.total)

Crear archivo e las capturas
