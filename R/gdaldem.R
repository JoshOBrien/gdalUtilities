##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdaldem}.
##'
##' @title Bare interface to gdaldem command-line app
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' td <- tempdir()
##' in_dem <- file.path(td, "maunga.tif")
##' out_slope <- file.path(td, "slope.tif")
##' out_shade <- file.path(td, "shade.tif")
##' out_aspect <- file.path(td, "aspect.tif")
##' file.copy(system.file("extdata/maunga.tif", package="starsUtils"),
##'           to = in_dem)
##' gdaldem("slope", in_dem, out_slope)
##' gdaldem("shade", in_dem, out_shade)
##' gdaldem("aspect", in_dem, out_aspect)
##'
##' ## Plot to view results
##' if(require(gridExtra) & require(rasterVis)) {
##'     lp <- function(f) {
##'         levelplot(raster(f), main = substitute(f),
##'                   margin = FALSE, colorkey = FALSE)
##'     }
##'     grid.arrange(lp(in_dem), lp(out_slope),
##'                  lp(out_shade), lp(out_aspect),
##'                  ncol = 2)
##' }
##' }
gdaldem <-
    function(mode, input_dem, output_map, ..., of,
             compute_edges, alg, b, co, q, z, s, az, alt, combined,
             multidirectional, p, trigonometric, zero_for_flat,
             color_text_file = character(0), alpha, exact_color_entry,
             nearest_color_entry)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("mode", "input_dem", "output_map", "color_text_file")] <- NULL
    formalsTable <- getFormalsTable("gdaldem")
    opts <- process_args(args, formalsTable)
    ## (My name for "mode" and "output_map")
    gdal_utils("demprocessing", input_dem, output_map, opts,
               processing = mode, colorfile = color_text_file)
    invisible(output_map)
}

