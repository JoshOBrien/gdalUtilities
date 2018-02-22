##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_rasterize}.
##'
##' @title R interface to GDAL rasterize utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ## Prepare example shapefile and template raster file
##' td <- tempdir()
##' rast_file <- file.path(td, "rasterize_eg/SPDF.tif")
##' vect_file <- file.path(td, "rasterize_eg/SPDF.shp")
##' file.copy(system.file("extdata/rasterize_eg", package="gdalUtilities"),
##'           td, recursive = TRUE)
##'
##' ## Rasterize polygon and check that it worked
##' gdal_rasterize(vect_file, rast_file, a = "ID_2")
##' if(require(raster)) {
##'     plot(raster(rast_file))
##' }
##' }
gdal_rasterize <-
    function(src_datasource, dst_filename, ..., b, i, at, burn, a,
             threeD, l, where, sql, dialect, of, a_srs, co, a_nodata,
             init, te, tr, tap, ts, ot, q) {
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource", "dst_filename")] <- NULL
    formalsTable <- getFormalsTable("gdal_rasterize")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    gdal_utils("rasterize", src_datasource, dst_filename, opts)
    invisible(dst_filename)
}
