## ## library(gdalUtilities)
## ## library(testthat)
## ## library(raster)
##
##
## ##-------------##
## ## nearblack() ##
## ##-------------##
##
## td <- tempdir()
## a_rast <- file.path(td, "a.tif")
## b1_rast <- file.path(td, "b1.tif")
## b2_rast <- file.path(td, "b2.tif")
## file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##           a_rast)
## file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##           b1_rast)
## file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##           b2_rast)
##
## ## These two are not identical, probably because the GDAL binaries
## ## called on my command line (those distributed with my OS4WGeo
## ## installation and reached by calls to gdalUtils) and those shipped
## ## with the sf package (ultimately provided by rwinlib/gdal2) use
## ## different versions of libgeotiff.
## ##
## ## They are, however pixel by pixel identical
## gdalUtilities::nearblack(a_rast, b1_rast, of = "GTiff")
## ## "nearblack -o C:/tmp/RtmpyYmyro/b1.tif -of GTiff C:/tmp/RtmpyYmyro/a.tif"
## gdalUtils::nearblack(a_rast, b2_rast, of = "GTiff", overwrite=TRUE)
## ## "\"C:\\OSGeo4W64\\bin\\nearblack.exe\" -o \"C:\\tmp\\RtmpyYmyro/b2.tif\" -of \"GTiff\" \"C:\\tmp\\RtmpyYmyro/a.tif\""
##
## b3_rast <- file.path(td, "b3.tif")
## b4_rast <- file.path(td, "b4.tif")
## writeRaster(raster(b1_rast), file = b3_rast)
## writeRaster(raster(b2_rast), file = b4_rast)
##
##
## expect_identical(tools::md5sum(b3_rast)[[1]],
##                  tools::md5sum(b4_rast)[[1]])
