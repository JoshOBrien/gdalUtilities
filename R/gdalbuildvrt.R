##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalbuildvrt}.
##'
##' @title R interface to GDAL gdalbuildvrt utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' layer1 <-
##'     system.file("external/tahoe_lidar_bareearth.tif", package="gdalUtils")
##' layer2 <-
##'     system.file("external/tahoe_lidar_highesthit.tif", package="gdalUtils")
##' output.vrt <- "boo.vrt"
##' gdalbuildvrt(gdalfile=c(layer1,layer2),output.vrt=output.vrt)
##' gdalinfo(output.vrt)
##' }
gdalbuildvrt <-
    function(gdalfile, output.vrt, tileindex, resolution, te, tr,
             tap, separate, b, sd, allow_projection_difference, q,
             addalpha, hidenodata, srcnodata, vrtnodata, a_srs, r,
             input_file_list, overwrite)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("gdalfile", "output.vrt")] <- NULL
    formalsTable <- getFormalsTable("gdalbuildvrt")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    gdal_utils("buildvrt", gdalfile, output.vrt, opts)
    invisible(output.vrt)
}

