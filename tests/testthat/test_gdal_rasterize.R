## ## library(gdalUtilities)
## ## library(testthat)
## ## library(raster)
##
##
## ##------------------##
## ## gdal_rasterize() ##
## ##------------------##
##
## ## Prepare file paths of example shapefile and template raster file
## vect_file <- system.file("external/lux.shp", package = "raster")
## td <- tempdir()
## rast_file1 <- file.path(td, "lux_rast1.tif")
## rast_file2 <- file.path(td, "lux_rast2.tif")
##
## ## Construct and save an appropriately sized 'empty' raster
## SPDF <- shapefile(vect_file)
## lonlatratio <- 1 / cospi(mean(coordinates(SPDF)[,2]) / 180)
## rr <- raster(extent(SPDF),
##              resolution = c(lonlatratio * 0.01, 0.01),
##              crs = proj4string(SPDF))
## writeRaster(rr, filename = rast_file1) ## Warns that raster is empty
## writeRaster(rr, filename = rast_file2) ## Warns that raster is empty
##
## ## Rasterize polygon using empty raster and check that it worked
## gdalUtilities::gdal_rasterize(vect_file, rast_file1, a = "ID_2")
## gdalUtils::gdal_rasterize(vect_file, rast_file2, a = "ID_2")
##
## expect_identical(tools::md5sum(rast_file1)[[1]],
##                  tools::md5sum(rast_file2)[[1]])
