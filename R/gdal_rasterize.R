
##' @title Interface to GDAL rasterize utility
##' @param input Path to vector file to be rasterized
##' @param output Path to outputted raster file
##' @param options Character vector containing "tokenized" options
##' @return Called for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' file.copy(system.file("extdata/rasterize_eg", package="gdUtils"),
##'           ".", recursive=TRUE)
##' ## Command-line equivalent:
##' ## gdal_rasterize -a "ID_2" "rasterize_eg/SPDF.shp" "rasterize_SPDF.tif"
##' gdal_rasterize("rasterize_eg/SPDF.shp",
##'                "rasterize_eg/SPDF.tif",
##'                options = c("-a", "ID_2"))
##' plot(raster("rasterize_eg/SPDF.tif"))
##' }
gdal_rasterize <- function(input, output, options) {
    st_gdal_utils("rasterize", input, output, options)
}



##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_rasterize}.
##'
##' @title Bare interface to gdal_rasterize command-line app
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' file.copy(system.file("extdata/rasterize_eg", package="gdUtils"),
##'           ".", recursive=TRUE)
##' gdal_rasterize2("rasterize_eg/SPDF.shp", "rasterize_eg/SPDF.tif", a="ID_2")
##' plot(raster("rasterize_eg/SPDF.tif"))
##' }
gdal_rasterize2 <-
    function(src_datasource, dst_filename, b, i, at, burn, a, threeD,
             l, where, sql, dialect, of, a_srs, co, a_nodata, init,
             te, tr, tap, ts, ot, q) {
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource", "dst_filename")] <- NULL
    formalsTable <- getFormalsTable("gdal_rasterize")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    st_gdal_utils("rasterize", src_datasource, dst_filename, opts)
    invisible(dst_filename)
}
