##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdalwarp}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/gdalwarp.html}.
##'
##' @title Interface to GDAL's gdalwarp utility
##' @param srcfile Character. Path to a GDAL-supported readable
##'     datasource.
##' @param dstfile Character. Path to a GDAL-supported output file.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param s_srs,t_srs,ct,to,vshift,novshift See the GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param s_coord_epoch,t_coord_epoch,order,tps,rpc,geoloc,et See the
##'     GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param refine_gcps,te,te_srs,tr,tap,ts,ovr,wo,ot,wt,r,srcnodata
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param dstnodata,srcalpha,nosrcalpha,dstalpha,wm,multi,q,IF,of,co
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param cutline,cl,cwhere,csql,cblend,crop_to_cutline,overwrite See
##'     the GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param nomd,cvmd,setci,oo,doo See the GDAL project's
##'     \href{https://gdal.org/programs/gdalwarp.html}{gdalwarp
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @param config_options A named character vector with GDAL config
##'     options, of the form \code{c(option1=value1,
##'     option2=value2)}. (See
##'     \href{https://gdal.org/user/configoptions.html}{here} for a
##'     complete list of supported config options.)
##' @return Silently returns path to \code{dstfile}.
##' @export
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' ## Prepare file paths
##' td <- tempdir()
##' in_tif <- file.path(td, "tahoe.tif")
##' gcp_tif <- file.path(td, "tahoe_gcp.tif")
##' out_tif <- file.path(td, "tahoe_warped.tif")
##'
##' ## Set up some ground control points, then warp
##' file.copy(system.file("extdata/tahoe.tif", package = "gdalUtilities"),
##'           in_tif)
##' ## Four numbers: column, row, x-coord, y-coord
##' gcp <- matrix(c(100, 300, -119.93226, 39.28977,  ## A
##'                 0,   300, -119.93281, 39.28977,  ## B
##'                 100, 400, -119.93226, 39.28922,  ## C
##'                 0,   400, -119.93281, 39.28922,  ## lower-left
##'                 400,   0, -119.93067, 39.29136,  ## upper-right
##'                 400, 400, -119.93062, 39.28922,  ## lower-right
##'                 0,     0, -119.93281, 39.29141), ## upper-left
##'               ncol = 4, byrow = TRUE)
##'
##' ## Add ground control points. (For some reason, this drops CRS, so
##' ## it needs to be explicitly given via `a_srs` argument.)
##' gdal_translate(in_tif, gcp_tif, gcp = gcp, a_srs = "EPSG:4326")
##' gdalwarp(gcp_tif, out_tif, r = "bilinear")
##'
##' ## Check that it worked
##' if(require(terra)) {
##'     op <- par(mfcol = c(1, 2))
##'     r1 <- plot(rast(in_tif), main = "Original raster")
##'     r2 <- plot(rast(out_tif), main = "Warped raster")
##'     par(op) ## Reset preexisting parameters
##' }
##' }
gdalwarp <-
    function(srcfile, dstfile, ..., s_srs, t_srs, ct, to, vshift,
             novshift, s_coord_epoch, t_coord_epoch, order, tps, rpc,
             geoloc, et, refine_gcps, te, te_srs, tr, tap, ts, ovr,
             wo, ot, wt, r, srcnodata, dstnodata, srcalpha,
             nosrcalpha, dstalpha, wm, multi, q, IF, of, co, cutline,
             cl, cwhere, csql, cblend, crop_to_cutline, overwrite,
             nomd, cvmd, setci, oo, doo,
             config_options = character(0), dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("srcfile", "dstfile", "config_options", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdalwarp")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdalwarp", srcfile, dstfile, opts=opts)
        return(x)
    }

    gdal_utils("warp",
               source = srcfile,
               destination = dstfile,
               options = opts,
               config_options = config_options)
    invisible(dstfile)
}
