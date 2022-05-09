library(ReactiveAtlantis)
## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Global vars   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
main_directory   <- '~/trunk/example/'
output_directory <- paste0(main_directory, 'outputFolder/output')
initial_cond.nc  <-  paste0(main_directory, '/init_NorthSea.nc')
groups.csv       <- '/functionalGroups.csv'
bgm.file         <- '/NorthSea.bgm'
prm.file         <- '/01NorthSea_biol_fishing.prm'
fsh.csv          <- 'your_fisheries_definition_file.csv'
cum.depths       <- c(0, 10, 20, 50, 92, 192, 500)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~          Compare previous run                ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
simulation01   <- '01'
simulation02   <- '00'
nc.out.current <- paste0(output_directory, simulation01, '/outputNorthSea.nc')
nc.out.old     <- paste0(output_directory, simulation02, '/outputNorthSea.nc')
## alone
compare(nc.out.current, nc.out.old=NULL, grp.csv = groups.csv,bgm.file=bgm.file, cum.depths=cum.depths)
## compare with other output
compare(nc.out.current, nc.out.old, grp.csv = groups.csv,bgm.file=bgm.file, cum.depths=cum.depths)

## ~~~~~~~~~~~~~~~~~ ##
## ~  Food weeb    ~ ##
## ~~~~~~~~~~~~~~~~~ ##
diet.file <- paste0(output_directory, simulation01, '/outputNorthSeaDietCheck.txt'
food.web(diet.file, groups.csv)

## ~~~~~~~~~~~~~~~~~~~~~~ ##
## ~      Recruitment   ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~ ##
yoy.file       <- paste0(output_directory, simulation01, '/outputNorthSeaYOY.txt')
nc.out.current <- paste0(output_directory, simulation01, '/outputNorthSea.nc')
recruitment.cal(ini.nc.file, out.nc.file, yoy.file, groups.csv, prm.file)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~             Growth Primary producers         ~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
prm.file      <- '/home/por07g/Documents/2019/North-Sea/JPG_North_Sea_Atlantis/NS_model/00NorthSea_biol_fishing.prm'
out.nc.file   <- paste0('/home/por07g/Documents/2019/North-Sea/JPG_North_Sea_Atlantis/NS_model/NorthSea_Output_Folder/output', sim, '/outputNorthSea.nc')
#debug(growth.pp)
growth.pp(ini.nc.file, groups.csv, prm.file, out.nc.file)

## ~~~~~~~~~~~~~~~~~~ ##
## ~     Predation  ~ ##
## ~~~~~~~~~~~~~~~~~~ ##
biomass   <- paste0(output_directory, simulation01, '/outputNorthSeaBiomIndx.txt')
diet.file <- paste0(output_directory, simulation01, '/outputNorthSeaDietCheck.txt')
bio.age   <- paste0(output_directory, simulation01, '/outputNorthSeaAgeBiomIndx.txt')

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
