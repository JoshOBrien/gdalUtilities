## library(gdalUtilities)
## library(testthat)
## library(raster)


##------------------##
## gdal_translate() ##
##------------------##

td <- tempdir()
in_raster <- file.path(td, "europe.tif")
out_raster1 <- file.path(td, "europe_small1.tif")
out_raster2 <- file.path(td, "europe_small2.tif")
file.copy(system.file("extdata/europe.tif", package = "gdalUtilities"),
          to = td)

## Shrink a tiff by 50% in both x and y dimensions
gdalUtilities::gdal_translate(in_raster, out_raster1, outsize = c("50%","50%"))
gdalUtils::gdal_translate(in_raster, out_raster2, outsize = c("50%","50%"))

expect_identical(tools::md5sum(out_raster1)[[1]],
                 tools::md5sum(out_raster2)[[1]])

