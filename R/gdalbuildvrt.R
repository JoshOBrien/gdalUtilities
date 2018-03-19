##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalbuildvrt}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{http://www.gdal.org/gdalbuildvrt.html}.
##'
##' @title R interface to GDAL's gdalbuildvrt utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' ## Prepare file paths
##' td <- tempdir()
##' out_vrt <- file.path(td, "out.vrt")
##' layer1 <-
##'     system.file("external/tahoe_lidar_bareearth.tif",
##'                 package = "gdalUtils")
##' layer2 <-
##'     system.file("external/tahoe_lidar_highesthit.tif",
##'                 package = "gdalUtils")
##'
##' ## Build VRT and check that it works
##' gdalbuildvrt(gdalfile = c(layer1, layer2), output.vrt = out_vrt)
##' gdalinfo(out_vrt)
gdalbuildvrt <-
    function(gdalfile, output.vrt, tileindex, resolution, te, tr,
             tap, separate, b, sd, allow_projection_difference, q,
             addalpha, hidenodata, srcnodata, vrtnodata, a_srs, r,
             input_file_list, overwrite,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("gdalfile", "output.vrt", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdalbuildvrt")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        ## Pass everything through opts to enforce order expected by
        ## command-line utility
        x <- CLI_call("gdalbuildvrt", opts = c(opts, output.vrt, gdalfile))
        return(x)
    }

    gdal_utils("buildvrt", gdalfile, output.vrt, opts)
    invisible(output.vrt)
}

