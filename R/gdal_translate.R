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
##' file.copy(system.file("extdata/europe.tif", package = "starsUtils"), ".")
##' gdal_translate("europe.tif", "europe_small.tif", outsize=c("50%","50%"))
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
