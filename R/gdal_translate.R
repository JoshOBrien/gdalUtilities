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
##' @param ot,strict,IF,of,b,mask,expand,outsize,tr,r,scale,exponent
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param unscale,srcwin,projwin,projwin_srs,srs,epo,eco See the GDAL
##'     project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param a_srs,a_coord_epoch,a_ullr,a_nodata,a_scale,a_offset See
##'     the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param colorinterp Along with \code{colorinterp}, arguments named
##'     \code{colorinterp_bn}, where \code{bn} refers the number of a
##'     band are also allowed. See the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param mo,co,nogcp,gcp,q,sds,stats,norat,noxmp,oo,sd_index
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/gdal_translate.html}{gdal_translate
##'     documentation} for details.
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @param config_options A named character vector with GDAL config
##'     options, of the form \code{c(option1=value1, option2=value2)}. (See
##'     \href{https://gdal.org/user/configoptions.html}{here} for a
##'     complete list of supported config options.)
##' @return Silently returns path to \code{dst_dataset}.
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
##' if(require(terra)) {
##'
##'   r1 <- rast(in_raster)
##'   r1[is.na(r1)] <- 0
##'   r1 <- as.factor(r1)
##'   rat <- levels(r1)[[1]]
##'   rat[["landcover"]] <- c("water", "land")
##'   levels(r1) <- rat
##'
##'   r2 <- rast(out_raster)
##'   r2[is.na(r2)] <- 0
##'   r2 <- as.factor(r2)
##'   rat <- levels(r2)[[1]]
##'   rat[["landcover"]] <- c("water", "land")
##'   levels(r2) <- rat
##'
##'   op <- par(mfcol = c(1, 2))
##'   plot(r1, col = c("lightblue", "brown"), legend = FALSE)
##'   plot(r2, col = c("lightblue", "brown"), legend = FALSE)
##'   par(op) ## Reset pre-existing parameters
##' }
##' }
gdal_translate <-
    function(src_dataset, dst_dataset, ..., ot, strict, IF, of, b,
             mask, expand, outsize, tr, r, scale, exponent, unscale,
             srcwin, projwin, projwin_srs, srs, epo, eco, a_srs,
             a_coord_epoch, a_ullr, a_nodata, a_scale, a_offset,
             colorinterp, mo, co, nogcp, gcp, q, sds, stats, noxmp,
             norat, oo, sd_index,
             config_options = character(0), dryrun = FALSE)
{
    ## First, handle any colorinterp_XX arguments
    dots <- list(...)
    CI <- dots[grepl("colorinterp_[[:digit:]]+", names(dots))]
    CI_opt_names <- gsub("colorinterp", "-colorinterp", names(CI))
    CI_opts <- as.vector(rbind(CI_opt_names, unlist(CI)))

    ## Unlike `as.list(match.call())`, forces eval of arguments
    nms <- setdiff(names(match.call())[-1], names(CI))
    args <-  mget(nms)
    args[c("src_dataset", "dst_dataset", "config_options", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdal_translate")
    opts <- process_args(args, formalsTable)

    ## Add back in any colorinterp_XX opts
    opts <- c(opts, CI_opts)

    if(dryrun) {
        x <- CLI_call("gdal_translate", src_dataset, dst_dataset, opts=opts)
        return(x)
    }

    gdal_utils("translate",
               source = src_dataset,
               destination = dst_dataset,
               options = opts,
               config_options = config_options)
    invisible(dst_dataset)
}
