##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalwarp}.
##'
##' @title Bare interface to gdalwarp command-line app
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ## Prepare file paths
##' td <- tempdir()
##' in_tif <- file.path(td, "tahoe.tif")
##' gcp_tif <- file.path(td, "tahoe_gcp.tif")
##' out_tif <- file.path(td, "tahoe_warped.tif")
##'
##' ## Set up some ground control points, then warp
##' file.copy(system.file("extdata/tahoe.tif", package = "starsUtils"),
##'           in_tif)
##' gcp <- matrix(c(100, 300, -119.93226, 39.28977, ## A
##'                 0, 300, -119.93281, 39.28977,   ## B
##'                 100, 400, -119.93226, 39.28922, ## C
##'                 0, 400, -119.93281, 39.28922,   ## ll
##'                 400, 0, -119.93067, 39.29136,   ## ur
##'                 400, 400, -119.93062, 39.28922, ## lr
##'                 0, 0,-119.93281, 39.29141),     ## ul
##'               ncol=4, byrow=TRUE)
##' ## Add ground control points. (For some reason, this drops CRS, so
##' ## it needs to be explicitly given via `a_srs` argument.)
##' gdal_translate(in_tif, gcp_tif, gcp = gcp, a_srs="EPSG:4326")
##' gdalwarp(gcp_tif, out_tif, r="bilinear")
##'
##' ## Check that it worked
##' if(require(gridExtra) & require(raster) & require(rasterVis)) {
##'     r1 <- raster(in_tif)
##'     p1 <- levelplot(r1, margin=FALSE, colorkey=FALSE)
##'     r2 <- raster(out_tif)
##'     p2 <- levelplot(r2, margin=FALSE, colorkey=FALSE)
##'     grid.arrange(p1, p2, ncol=2)
##' }
##' }
gdalwarp <-
    function(srcfile, dstfile, ..., s_srs, t_srs, to, order, tps, rpc,
             geoloc, et, refine_gcps, te, te_srs, tr, tap, ts, ovr,
             wo, ot, wt, r, srcnodata, dstnodata, dstalpha, wm, multi,
             q, of, co, cutline, cl, cwhere, csql, cblend,
             crop_to_cutline, overwrite, nomd, cvmd, setci, oo, doo,
             config)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("srcfile", "dstfile")] <- NULL
    formalsTable <- getFormalsTable("gdalwarp")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    gdal_utils("warp", srcfile, dstfile, opts)
    invisible(dstfile)
}
