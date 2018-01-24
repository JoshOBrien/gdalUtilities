
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{ogr2ogr}.
##'
##' @title R interface to ogr2ogr utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' library(raster)
##' src_datasource_name <-
##'     system.file("extdata/tahoe_highrez_training.shp", package="starsUtils")
##' dst_datasource_name <- paste(tempfile(), ".shp", sep="")
##'  # reproject the input to mercator
##' ogr2ogr(src_datasource_name, dst_datasource_name, t_srs="EPSG:3395")
##' plot(shapefile(src_datasource_name))
##' plot(shapefile(dst_datasource_name), add=TRUE, border="red")
##' }
ogr2ogr <-
    function(src_datasource_name, dst_datasource_name, layer, f, append,
             overwrite, update, select, progress, sql, dialect, where,
             skipfailures, spat, spat_srs, geomfield, dsco, lco, nln,
             nlt, dim, a_srs, t_srs, s_srs, preserve_fid, fid, oo,
             doo, gt, ds_transaction, clipsrc, clipsrcsql,
             clipsrclayer, clipsrcwhere, clipdst, clipdstsql,
             clipdstlayer, clipdstwhere, wrapdateline, datelineoffset,
             simplify, segmentize, fieldTypeToString, mapFieldType,
             unsetFieldWidth, splitlistfields, maxsubfields,
             explodecollections, zfield, gcp, order, tps, fieldmap,
             addfields, relaxedFieldNameMatch, forceNullable,
             unsetDefault, unsetFid, nomd, mo)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource_name", "dst_datasource_name")] <- NULL
    formalsTable <- getFormalsTable("ogr2ogr")
    opts <- process_args(args, formalsTable)
    ## Neither mandatory argument is prepended with a flag
    gdal_utils("vectortranslate", src_datasource_name,
               dst_datasource_name, opts)
    invisible(dst_datasource_name)
}
