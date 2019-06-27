##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/nearblack.html}.
##'
##' @title R interface to GDAL's nearblack utility
##' @param infile Character. Path to a GDAL-supported readable
##'     datasource.
##' @param o Optionally, a character string giving the path to a
##'     GDAL-supported output file. If not supplied, defaults to
##'     code{infile=}, indicating that the input file should be
##'     modified in place.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param of,co,white,color,near,nb,setalpha,setmask,q See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/nearblack.html}{nearblack
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @return Silently returns path to \code{datasetname}.
##' @export
##' @author Joshua O'Brien
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
