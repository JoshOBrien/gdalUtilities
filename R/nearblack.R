##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{http://www.gdal.org/nearblack.html}.
##'
##' @title R interface to GDAL's nearblack utility
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
##' nearblack(a_rast, b_rast, of = "GTiff")
##' nearblack(a_rast, of = "GTiff", near = 100)
##' }
nearblack <-
    function(infile, o = infile, ..., of, co, white, color, near, nb,
             setalpha, setmask, q,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("infile", "dryrun", "o")] <- NULL
    formalsTable <- getFormalsTable("nearblack")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        ## Pass everything through opts to enforce order expected by
        ## command-line utility
        x <- CLI_call("nearblack", opts = c(opts, infile))
        return(x)
    }

    gdal_utils("nearblack", infile, o, options=opts)
    invisible(o)
}


