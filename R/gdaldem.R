##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdaldem}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdaldem.html}.
##'
##' @title Interface to GDAL's gdaldem utility
##' @param input_dem Path to a GDAL-supported readable DEM datasource.
##' @param output_map Character. Path to a GDAL-supported output file.
##' @param mode Character, one of \code{"hillshade"}, \code{"slope"},
##'     \code{"color-relief"}, \code{"TRI"}, \code{"TPI"},
##'     \code{"roughness"}, indicating which of the available
##'     processing modes is to be used.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param of,compute_edges,alg,b,co,q,z,s,az,alt,combined See the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdaldem.html}{gdaldem
##'     documentation} for details.
##' @param multidirectional,p,trigonometric,zero_for_flat See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/gdaldem.html}{gdaldem
##'     documentation} for details.
##' @param color_text_file,alpha,exact_color_entry,nearest_color_entry
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/gdaldem.html}{gdaldem
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @return None. Called instead for its side effect.
##' @export
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' ## Prepare file paths
##' td <- tempdir()
##' in_dem <- system.file("extdata/maunga.tif", package = "gdalUtilities")
##' out_slope  <- file.path(td, "slope.tif")
##' out_shade  <- file.path(td, "shade.tif")
##' out_aspect <- file.path(td, "aspect.tif")
##'
##' ## Apply DEM processing
##' gdaldem("slope", in_dem, out_slope)
##' gdaldem("shade", in_dem, out_shade)
##' gdaldem("aspect", in_dem, out_aspect)
##'
##' ## View results
##' if(require(rasterVis)) {
##'     lp <- function(f) {
##'         levelplot(raster(f), main = substitute(f),
##'                   margin = FALSE, colorkey = FALSE)
##'     }
##'     plot(lp(in_dem),     split = c(1,1,2,2))
##'     plot(lp(out_slope),  split = c(2,1,2,2), newpage = FALSE)
##'     plot(lp(out_shade),  split = c(1,2,2,2), newpage = FALSE)
##'     plot(lp(out_aspect), split = c(2,2,2,2), newpage = FALSE)
##' }
##' }
gdaldem <-
    function(mode, input_dem, output_map, ..., of,
             compute_edges, alg, b, co, q, z, s, az, alt, combined,
             multidirectional, p, trigonometric, zero_for_flat,
             color_text_file = character(0), alpha, exact_color_entry,
             nearest_color_entry,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("mode", "input_dem", "output_map",
           "color_text_file", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdaldem")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdaldem", mode,
                      input_dem, color_text_file, output_map,
                      opts=opts)
        return(x)
    }

    ## (My name for "mode" and "output_map")
    gdal_utils("demprocessing", input_dem, output_map, opts,
               processing = mode, colorfilename = color_text_file)
    invisible(output_map)
}
