
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}.
##'
##' @title Bare interface to gdal_contour command-line app
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' td <- tempdir()
##' a_rast <- file.path(td, "a.tif")
##' b_rast <- file.path(td, "b.tif")
##' file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##'           a_rast)
##' file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##'           b_rast)
##' nearblack(a_rast, b_rast)
##' nearblack(a_rast, near = 100)
##' }
nearblack <-
    function(infile, o = infile, ..., of, co, white, color, near, nb,
             setalpha, setmask, q,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("infile", "o", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("nearblack")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("nearblack", infile, o, opts=opts)
        return(x)
    }

    gdal_utils("nearblack", infile, o, options=opts)
    invisible(o)
}


