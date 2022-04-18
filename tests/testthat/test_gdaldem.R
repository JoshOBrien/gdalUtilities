## ## library(gdalUtilities)
## ## library(testthat)
## ## library(raster)
##
## ##-----------##
## ## gdaldem() ##
## ##-----------##
##
## td <- tempdir()
## in_dem <- system.file("extdata/maunga.tif", package = "gdalUtilities")
## out_slope1  <- file.path(td, "slope1.tif")
## out_shade1  <- file.path(td, "shade1.tif")
## out_aspect1 <- file.path(td, "aspect1.tif")
## out_slope2  <- file.path(td, "slope2.tif")
## out_shade2  <- file.path(td, "shade2.tif")
## out_aspect2 <- file.path(td, "aspect2.tif")
##
## ## Apply DEM processing
## gdalUtilities::gdaldem("slope", in_dem, out_slope1)
## gdalUtilities::gdaldem("shade", in_dem, out_shade1)
## gdalUtilities::gdaldem("aspect", in_dem, out_aspect1)
## gdalUtils::gdaldem("slope", in_dem, out_slope2)
## gdalUtils::gdaldem("shade", in_dem, out_shade2)
## gdalUtils::gdaldem("aspect", in_dem, out_aspect2)
##
## expect_identical(tools::md5sum(out_slope1)[[1]],
##                  tools::md5sum(out_slope2)[[1]])
## expect_identical(tools::md5sum(out_shade1)[[1]],
##                  tools::md5sum(out_shade2)[[1]])
## expect_identical(tools::md5sum(out_aspect1)[[1]],
##                  tools::md5sum(out_aspect2)[[1]])

