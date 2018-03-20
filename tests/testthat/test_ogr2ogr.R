## library(gdalUtilities)
## library(testthat)
## library(raster)


##-----------##
## ogr2ogr() ##
##-----------##

## Prepare file paths
td <- tempdir()
in_shp <- system.file("external/lux.shp",
                      package = "raster")
out_merc1 <- file.path(td, "mercator1.shp")
out_merc2 <- file.path(td, "mercator2.shp")
out_utm1 <- file.path(td, "utm1.shp")
out_utm2 <- file.path(td, "utm2.shp")

## Reproject to 'WGS 84/World Mercator'
gdalUtilities::ogr2ogr(in_shp, out_merc1, t_srs = "EPSG:3395")
gdalUtils::ogr2ogr(in_shp, out_merc2, t_srs = "EPSG:3395")
## Reproject to 'Lambert conformal conic projection'
gdalUtilities::ogr2ogr(in_shp, out_utm1, t_srs = "EPSG:42304")
gdalUtils::ogr2ogr(in_shp, out_utm2, t_srs = "EPSG:42304")


## TESTS FOR SUBSTANTIAL EQUALITY
## (Not quite identical, as a few coordinates differ by
## a maximum of ~2e-9 meters)
merc1 <- st_read(out_merc1)
merc2 <- st_read(out_merc2)
merc_diff <- max(abs(as.matrix(st_coordinates(merc1)[,1:2]) -
                     as.matrix(st_coordinates(merc2)[,1:2])))
