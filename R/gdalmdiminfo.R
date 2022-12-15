##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalmdiminfo}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdalmdiminfo.html}.
##'
##' @title Interface to GDAL's gdalmdiminfo utility
##' @param datasetname Path to a GDAL-supported readable datasource.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param oo,arrayoption,detailed,nopretty,array,limit,stats,IF the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdalmdiminfo.html}{gdalmdiminfo
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @param quiet Logical (default \code{FALSE}). If \code{TRUE},
##'     suppress printing of output to the console.
##' @return Silently returns a character vector containing the
##'     information in JSON format returned by the gdalmdiminfo
##'     utility.
##' @export
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' ff <- system.file("nc/cropped.nc", package = "sf")
##' gdalmdiminfo(ff)
##' }
gdalmdiminfo <-
    function(datasetname, ..., oo, arrayoption, detailed, nopretty,
             array, limit, stats, IF, dryrun = FALSE, quiet = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("datasetname", "dryrun", "quiet")] <- NULL
    formalsTable <- getFormalsTable("gdalmdiminfo")
    opts <- process_args(args, formalsTable)
    opts <- c("", opts) ## To ensure we never pass in a NULL

    if(dryrun) {
        x <- CLI_call("gdalmdiminfo", datasetname, opts = opts)
        return(x)
    }

    info <- gdal_utils("mdiminfo", datasetname, options = opts,
                       quiet = quiet)
    invisible(info)
}
