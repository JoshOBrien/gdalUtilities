##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_translate}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdal_translate.html}.
##'
##' @title Interface to GDAL's gdal_translate utility
##' @param src_dataset Character. Path to a GDAL-supported readable
##'     datasource.
##' @param dst_dataset Character. Path to a GDAL-supported output
##'     file.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param ot,strict,of,b,mask,expand,outsize,tr,r,scale,exponent See
##'     the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param unscale,srcwin,projwin,projwin_srs,srs,epo,eco See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param a_srs,a_ullr,a_nodata,mo,co,gcp,q,sds,stats,norat See the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param oo,sd_index,config See the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
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
##' in_raster <- file.path(td, "europe.tif")
##' out_raster <- file.path(td, "europe_small.tif")
##' file.copy(system.file("extdata/europe.tif", package = "gdalUtilities"),
##'           to = td)
##'
##' ## Shrink a tiff by 50% in both x and y dimensions
##' gdal_translate(in_raster, out_raster, outsize = c("50%","50%"))
##'
##' ## Check that it worked
##' if(require(rasterVis)) {
##'     r1 <- raster(in_raster)
##'     r1[is.na(r1)] <- 0
##'     r1 <- as.factor(r1)
##'     rat <- levels(r1)[[1]]
##'     rat[["landcover"]] <- c("water", "land")
##'     levels(r1) <- rat
##'     p1 <- levelplot(r1, margin = FALSE, colorkey = FALSE,
##'                     col.regions = c("lightblue", "brown"))
##'
##'     r2 <- raster(out_raster)
##'     r2[is.na(r2)] <- 0
##'     r2 <- as.factor(r2)
##'     rat <- levels(r2)[[1]]
##'     rat[["landcover"]] <- c("water", "land")
##'     levels(r2) <- rat
##'     p2 <- levelplot(r2, margin = FALSE, colorkey = FALSE,
##'                     col.regions = c("lightblue", "brown"))
##'
##'     plot(p1, split = c(1, 1, 2, 1))
##'     plot(p2, split = c(2, 1, 2, 1), newpage = FALSE)
##'
##' }
##' }
gdal_translate <-
    function(src_dataset, dst_dataset, ..., ot, strict, of, b, mask,
             expand, outsize, tr, r, scale, exponent, unscale, srcwin,
             projwin, projwin_srs, srs, epo, eco, a_srs, a_ullr,
             a_nodata, mo, co, gcp, q, sds, stats, norat, oo,
             sd_index, config,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_dataset", "dst_dataset", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdal_translate")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdal_translate", src_dataset, dst_dataset, opts=opts)
        return(x)
    }

    gdal_utils("translate", src_dataset, dst_dataset, opts)
    invisible(dst_dataset)
}
