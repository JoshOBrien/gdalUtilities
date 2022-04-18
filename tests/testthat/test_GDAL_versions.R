## ## library(gdalUtilities)
## ## library(testthat)
##
## ## Check that both gdalUtils and gdalUtilities are using same GDAL version
## ## (Do note that, even with same GDAL version, output can differ due to
## ## different versions of any of many supporting libraries.)
## GDAL_version_gdalUtilities <- sf:::CPL_gdal_version()
## gdalUtils::gdal_setInstallation()
## GDAL_version_gdalUtils <- unname(getOption("gdalUtils_gdalPath")[[1]]$version)
## expect_identical(GDAL_version_gdalUtilities, GDAL_version_gdalUtils)
