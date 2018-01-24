
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}.
##'
##' @title Bare interface to gdal_contour command-line app
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ff <- system.file("extdata/maunga.tif", package="starsUtils")
##' gdalinfo(ff)
##' }
nearblack <-
    function(infile, o, ..., of, co, white, color, near, nb, setalpha,
             setmask, q)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("infile", "o")] <- NULL
    formalsTable <- getFormalsTable("nearblack")
    opts <- process_args(args, formalsTable)
    ## Mandatory argument is not prepended with a flag
    gdal_utils("nearblack", infile, o, options=opts)
    invisible(datasetname)
}


