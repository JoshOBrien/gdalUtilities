
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalinfo}.
##'
##' @title Bare interface to gdal_contour command-line app
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Josh O'Brien
##' @examples
##' ff <- system.file("extdata/maunga.tif", package="starsUtils")
##' gdalinfo(ff)
gdalinfo <-
    function(datasetname, ..., json, mm, stats, approx_stats, hist,
             nogcp, nomd, norat, noct, checksum, listmdd, mdd, nofl,
             sd, proj4, oo, config)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("datasetname")] <- NULL
    formalsTable <- getFormalsTable("gdalinfo")
    opts <- process_args(args, formalsTable)
    opts <- c("", opts) ## To ensure we never pass in a NULL
    ## Mandatory argument is not prepended with a flag
    gdal_utils("info", datasetname, options=opts)
    invisible(datasetname)
}


