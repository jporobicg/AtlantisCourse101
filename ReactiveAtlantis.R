library(ReactiveAtlantis)
## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Global vars   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
main_directory   <- '~/trunk/example/'
output_directory <- paste0(main_directory, 'outputFolder/output')
initial_cond.nc  <-  paste0(main_directory, '/INIT_VMPA_Jan2015.nc')
groups.csv       <- '/SETasGroupsDem.csv'
bgm.file         <- '/VMPA_setas.bgm'
prm.file         <- '/VMPA_setas_biol_fishing_Trunk.prm'
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
## ~  Food weeb    ~ ##
## ~~~~~~~~~~~~~~~~~ ##
diet.file <- paste0(output_directory, simulation01, '/outputSETASDietCheck.txt'
food.web(diet.file, groups.csv)

## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Recruitment   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
yoy.file       <- paste0(output_directory, simulation01, '/outputSETASYOY.txt')
nc.out.current <- paste0(output_directory, simulation01, '/outputSETAS.nc')
recruitment.cal(ini.nc.file, out.nc.file, yoy.file, groups.csv, prm.file)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~             Growth Primary producers         ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
growth.pp(ini.nc.file, groups.csv, prm.file, out.nc.file)

## ~~~~~~~~~~~~~~~~~~ ##
## ~     Predation  ~ ##
## ~~~~~~~~~~~~~~~~~~ ##
biomass   <- paste0(output_directory, simulation01, '/outputSETASBiomIndx.txt')
diet.file <- paste0(output_directory, simulation01, '/outputSETASDietCheck.txt')
bio.age   <- paste0(output_directory, simulation01, '/outputSETASAgeBiomIndx.txt')

predation(biom,grp.csv, diet.file, age.biomass=bio.age)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~             Predator-prey Interaction          ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
feeding.mat(prm.file, grp.file, nc.initial, bgm.file, cum.depths)

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
