##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_translate}.
##'
##' @title Bare interface to gdal_translate command-line app
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ## Shrink a tiff by 50% in both x and y dimensions
##' td <- tempdir()
##' in_raster <- file.path(td, "europe.tif")
##' out_raster <- file.path(td, "europe_small.tif")
##' file.copy(system.file("extdata/europe.tif", package = "starsUtils"), td)
##' gdal_translate(in_raster, out_raster, outsize = c("50%","50%"))
##'
##' ## Check that it worked
##' if(require(gridExtra) & require(raster) & require(rasterVis)) {
##'     r1 <- raster(in_raster)
##'     r1[is.na(r1)] <- 0
##'     r1 <- as.factor(r1)
##'     rat <- levels(r1)[[1]]
##'     rat[["landcover"]] <- c("water", "land")
##'     levels(r1) <- rat
##'     p1 <- levelplot(r1, margin=FALSE, colorkey=FALSE,
##'                     col.regions = c("lightblue", "brown"))
##'
##'     r2 <- raster(out_raster)
##'     r2[is.na(r2)] <- 0
##'     r2 <- as.factor(r2)
##'     rat <- levels(r2)[[1]]
##'     rat[["landcover"]] <- c("water", "land")
##'     levels(r2) <- rat
##'     p2 <- levelplot(r2, margin=FALSE, colorkey=FALSE,
##'                     col.regions = c("lightblue", "brown"))
##'
##'     grid.arrange(p1, p2, ncol=2)
##' }
##' }
gdal_translate <-
    function(src_dataset, dst_dataset, ..., ot, strict, of, b, mask,
             expand, outsize, tr, r, scale, exponent, unscale, srcwin,
             projwin, projwin_srs, srs, epo, eco, a_srs, a_ullr,
             a_nodata, mo, co, gcp, q, sds, stats, norat, oo,
             sd_index, config)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_dataset", "dst_dataset")] <- NULL
    formalsTable <- getFormalsTable("gdal_translate")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    gdal_utils("translate", src_dataset, dst_dataset, opts)
    invisible(dst_dataset)
}
