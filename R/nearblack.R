
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}.
##'
##' @title Bare interface to gdal_contour command-line app
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' file.copy(system.file("extdata/tahoe.tif", package = "starsUtils"),
##'           "./a.tif")
##' file.copy(system.file("extdata/tahoe.tif", package = "starsUtils"),
##'           "./b.tif")
##' nearblack("a.tif", "b.tif")
##' nearblack("a.tif", near=100)
##' }
nearblack <-
    function(infile, o = infile, ..., of, co, white, color, near, nb,
             setalpha, setmask, q)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("infile", "o")] <- NULL
    formalsTable <- getFormalsTable("nearblack")
    opts <- process_args(args, formalsTable)
    ## Mandatory argument is not prepended with a flag
    gdal_utils("nearblack", infile, o, options=opts)
    invisible(o)
}


