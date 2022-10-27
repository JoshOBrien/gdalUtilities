##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalmdimtranslate}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdalmdimtranslate.html}.
##'
##' @title Interface to GDAL's gdalmdimtranslate utility
##' @param src_filename Character. Path to a GDAL-supported readable
##'     datasource.
##' @param dst_filename Character. Path to a GDAL-supported output
##'     file.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param co,IF,of,array,group,subset,scaleaxes,oo See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/gdalmdimtranslate.html}{gdalmdimtranslate
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @return Silently returns path to \code{dst_filename}.
##' @export
##' @author Joshua O'Brien
##' @examples
##' ff <- system.file("nc/cropped.nc", package = "sf")
##'
gdalmdimtranslate <-
    function(src_filename, dst_filename, ..., co, IF, of, array,
             group, subset, scaleaxes, oo, dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_filename", "dst_filename", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdalmdimtranslate")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdalmdimtranslate", src_filename, dst_filename,
                      opts = opts)
        return(x)
    }

    gdal_utils("mdimtranslate", src_filename, dst_filename,
               options = opts)
    invisible(dst_filename)
}
