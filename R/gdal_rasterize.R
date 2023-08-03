##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_rasterize}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdal_rasterize.html}.
##'
##' @title Interface to GDAL's gdal_rasterize utility
##' @param src_datasource Character. Path to a GDAL-supported readable
##'     datasource.
##' @param dst_filename Character. Path to a GDAL-supported output
##'     file.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param b,i,at,burn,a,threeD,add,l,where,sql,dialect,of See the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdal_rasterize.html}{gdal_rasterize
##'     documentation} for details.
##' @param a_srs,to,co,a_nodata,init,te,tr,tap,ts,ot,optim,q See the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdal_rasterize.html}{gdal_rasterize
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @param config_options A named character vector with GDAL config
##'     options, of the form \code{c(option1=value1, option2=value2)}. (See
##'     \href{https://gdal.org/user/configoptions.html}{here} for a
##'     complete list of supported config options.)
##' @return Silently returns path to \code{dst_filename}.
##' @export
##' @importFrom sf gdal_utils
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' if(require(terra)) {
##'     ## Prepare file paths of example shapefile and template raster file
##'     vect_file <- system.file("ex/lux.shp", package = "terra")
##'     td <- tempdir()
##'     rast_file <- file.path(td, "lux_rast.tif")
##'
##'     ## Construct and save an appropriately sized 'empty' raster
##'     LUX <- vect(vect_file)
##'     lonlatratio <- 1 / cospi(mean(geom(LUX)[, "y"]) / 180)
##'     rr <- rast(ext(LUX),
##'                resolution = c(lonlatratio * 0.01, 0.01),
##'                crs = crs(LUX), vals = NA)
##'
##'     ## Note: this next line warns that raster is empty
##'     writeRaster(rr, filename = rast_file, overwrite = TRUE)
##'
##'     ## Rasterize polygon using empty raster and check that it worked
##'     gdal_rasterize(vect_file, rast_file, a = "ID_2")
##'     plot(rast(rast_file))
##' }
##' }
gdal_rasterize <-
    function(src_datasource, dst_filename, ..., b, i, at, burn, a,
             threeD, add, l, where, sql, dialect, of, a_srs, to, co,
             a_nodata, init, te, tr, tap, ts, ot, optim, q,
             config_options = character(0), dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource", "dst_filename", "config_options", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdal_rasterize")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdal_rasterize", src_datasource, dst_filename, opts=opts)
        return(x)
    }

    gdal_utils("rasterize",
               source = src_datasource,
               destination = dst_filename,
               options = opts,
               config_options = config_options)
    invisible(dst_filename)
}
