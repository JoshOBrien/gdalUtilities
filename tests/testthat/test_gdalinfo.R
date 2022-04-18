## library(gdalUtilities)
## library(testthat)
## library(raster)
##
## ##------------##
## ## gdalinfo() ##
## ##------------##
##
## td <- tempdir()
## ff <- system.file("extdata/maunga.tif", package = "gdalUtilities")
## info1 <- file.path(td, "info1.txt")
## info2 <- file.path(td, "info2.txt")
## cat(capture.output(gdalUtilities::gdalinfo(ff)), file = info1)
## cat(gdalUtils::gdalinfo(ff), file = info2)
##
## expect_identical(tools::md5sum(info1)[[1]],
##                  tools::md5sum(info2)[[1]])
