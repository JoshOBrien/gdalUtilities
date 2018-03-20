## library(gdalUtilities)
## library(testthat)
## library(raster)


##-------------##
## gdal_grid() ##
##-------------##

## Set up file paths
td <- tempdir()
dem_file <- file.path(td, "dem.csv")
vrt_header_file <- file.path(td, "tmp.vrt")
out_raster1 <- file.path(td, "tmp1.tiff")
out_raster2 <- file.path(td, "tmp2.tiff")

## Create file of points with x-, y-, and z-coordinates
pts <-
    data.frame(Easting = c(86943.4, 87124.3, 86962.4, 87077.6),
               Northing = c(891957, 892075, 892321, 891995),
               Elevation = c(139.13, 135.01, 182.04, 135.01))
write.csv(pts, file = dem_file, row.names = FALSE)

## Prepare a matching VRT file
vrt_header <- c(
    '<OGRVRTDataSource>',
    '  <OGRVRTLayer name="dem">',
    paste0('    <SrcDataSource>',dem_file,'</SrcDataSource>'),
    '    <GeometryType>wkbPoint</GeometryType>',
    '    <GeometryField encoding="PointFromColumns" x="Easting" y="Northing" z="Elevation"/>',
    '  </OGRVRTLayer>',
    '</OGRVRTDataSource>'
)
cat(vrt_header, file = vrt_header_file, sep = "\n")

## Test it out
gdalUtilities::gdal_grid(src_datasource = vrt_header_file,
                         dst_filename = out_raster1,
                         a = "invdist:power=2.0:smoothing=1.0",
                         txe = c(85000, 89000), tye = c(894000, 890000),
                         outsize = c(400, 400),
                         of = "GTiff", ot = "Float64", l = "dem")

gdalUtils::gdal_grid(src_datasource = vrt_header_file,
                     dst_filename = out_raster2,
                     a="invdist:power=2.0:smoothing=1.0",
                     txe = c(85000, 89000), tye = c(894000, 890000),
                     outsize = c(400, 400),
                     of = "GTiff", ot = "Float64", l = "dem",
                     output_Raster = FALSE)

expect_identical(tools::md5sum(out_raster1)[[1]],
                 tools::md5sum(out_raster2)[[1]])
