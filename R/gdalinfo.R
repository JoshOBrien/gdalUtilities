##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalinfo}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdalinfo.html}.
##'
##' @title R interface to GDAL's gdalinfo utility
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Joshua O'Brien
##' @examples
##' ff <- system.file("extdata/maunga.tif", package = "gdalUtilities")
##' gdalinfo(ff)
gdalinfo <-
    function(datasetname, ..., json, mm, stats, approx_stats, hist,
             nogcp, nomd, norat, noct, checksum, listmdd, mdd, nofl,
             sd, proj4, oo, config,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("datasetname", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdalinfo")
    opts <- process_args(args, formalsTable)
    opts <- c("", opts) ## To ensure we never pass in a NULL

    if(dryrun) {
        x <- CLI_call("gdalinfo", datasetname, opts=opts)
        return(x)
    }

    gdal_utils("info", datasetname, options=opts)
    invisible(datasetname)
}


