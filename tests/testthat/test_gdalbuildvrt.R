## ## library(gdalUtilities)
## ## library(testthat)
## ## library(raster)
##
##
## ##----------------##
## ## gdalbuildvrt() ##
## ##----------------##
##
## ## Prepare file paths
## td <- tempdir()
## out_vrt1 <- file.path(td, "out1.vrt")
## out_vrt2 <- file.path(td, "out2.vrt")
## oulayer1 <-
##     system.file("external/tahoe_lidar_bareearth.tif",
##                 package = "gdalUtils")
## layer2 <-
##     system.file("external/tahoe_lidar_highesthit.tif",
##                 package = "gdalUtils")
##
## ## Build VRT and check that it works
## gdalUtilities::gdalbuildvrt(gdalfile = c(layer1, layer2), output.vrt = out_vrt1)
## gdalUtils::gdalbuildvrt(gdalfile = c(layer1, layer2), output.vrt = out_vrt2)
##
## ## expect_identical(tools::md5sum(out_vrt1)[[1]],
## ##                  tools::md5sum(out_vrt2)[[1]])
## ## "36e0ad49fc73f0ac1b5f4edf19e7599c"
## ## "c8ff03d1473bd257a376f568b7034b93"
##
## ## These turn out not identical, due solely to slightly different
## ## formatting used in writing out the vrt files' <GeoTransform> lines:
## ## <GeoTransform>-1.1993280719323026e+002, 5.4728613270999996e-006, 0.0000000000000000e+000, 3.9291413801394071e+001, 0.0000000000000000e+000,-5.4728613270999996e-006</GeoTransform>
## ## <GeoTransform> -1.1993280719323026e+02,  5.4728613270999996e-06,  0.0000000000000000e+00,  3.9291413801394071e+01,  0.0000000000000000e+00, -5.4728613270999996e-06</GeoTransform>
