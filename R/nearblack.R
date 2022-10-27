##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{nearblack}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/nearblack.html}.
##'
##' @title Interface to GDAL's nearblack utility
##' @param infile Character. Path to a GDAL-supported readable
##'     datasource.
##' @param o Optionally, a character string giving the path to a
##'     GDAL-supported output file. If not supplied, defaults to
##'     code{infile=}, indicating that the input file should be
##'     modified in place.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param of,white,color,near,nb,setalpha,setmask,q,co See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/nearblack.html}{nearblack
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @return Silently returns path to \code{o}.
##' @export
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' td <- tempdir()
##' a_rast <- file.path(td, "a.tif")
##' b_rast <- file.path(td, "b.tif")
##' file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##'           a_rast)
##' file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##'           b_rast)
##' nearblack(a_rast, b_rast, of = "GTiff", near = 150)
##'
##' ## Check that it worked
##' if(requireNamespace("raster", quietly = TRUE)) {
##'   library(raster)
##'   if(require(rasterVis)) {
##'     r1 <- raster(a_rast)
##'     p1 <- levelplot(r1, margin = FALSE, colorkey = FALSE)
##'     r2 <- raster(b_rast)
##'     p2 <- levelplot(r2, margin = FALSE, colorkey = FALSE)
##'     plot(p1, split = c(1, 1, 2, 1))
##'     plot(p2, split = c(2, 1, 2, 1), newpage = FALSE)
##'   }
##' }

##' }
nearblack <-
    function(infile, o = infile, ..., of, white, color, near, nb,
             setalpha, setmask, q, co, dryrun = FALSE)
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
