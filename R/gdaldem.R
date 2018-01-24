##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdaldem}.
##'
##' @title Bare interface to gdaldem command-line app
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' file.copy(system.file("extdata/maunga.tif", package="starsUtils"), ".")
##' gdaldem("slope", "maunga.tif", "slope.tif")
##' gdaldem("shade", "maunga.tif", "shade.tif")
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
    opts <- c(character(0), process_args(args, formalsTable))
    ## (My name for "mode" and "output_map")
    gdal_utils("demprocessing", input_dem, output_map, opts,
               processing = mode, colorfile = color_text_file)
    invisible(output_map)
}

