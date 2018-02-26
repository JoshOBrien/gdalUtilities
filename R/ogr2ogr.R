
##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{ogr2ogr}.
##'
##' @name ogr2ogr
##' @rdname ogr2ogr
##' @title R interface to ogr2ogr utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ## Prepare file paths
##' td <- tempdir()
##' in_shp <- system.file("external/lux.shp",
##'                       package = "raster")
##' out_merc <- file.path(td, "mercator.shp")
##' out_utm <- file.path(td, "utm.shp")
##'
##' ## Reproject to 'WGS 84/World Mercator'
##' ## https://en.wikipedia.org/wiki/Mercator_projection
##' ogr2ogr(in_shp, out_merc, t_srs = "EPSG:3395")
##' ## Reproject to 'Lambert conformal conic projection'
##' ## https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection
##' ogr2ogr(in_shp, out_utm, t_srs = "EPSG:42304")
##'
##' if(require(raster)) {
##'     par(mfcol = c(1,2))
##'     plot(shapefile(out_merc), main = "WGS 84",
##'          border = "darkgrey", col = gray.colors(12))
##'     plot(shapefile(out_utm), main = "LCC",
##'          border = "darkgrey", col = gray.colors(12))
##' }
##' }
ogr2ogr <-
    function(src_datasource_name, dst_datasource_name, ..., layer, f,
             append, overwrite, update, select, progress, sql,
             dialect, where, skipfailures, spat, spat_srs, geomfield,
             dsco, lco, nln, nlt, dim, a_srs, t_srs, s_srs,
             preserve_fid, fid, oo, doo, gt, ds_transaction, clipsrc,
             clipsrcsql, clipsrclayer, clipsrcwhere, clipdst,
             clipdstsql, clipdstlayer, clipdstwhere, wrapdateline,
             datelineoffset, simplify, segmentize, fieldTypeToString,
             mapFieldType, unsetFieldWidth, splitlistfields,
             maxsubfields, explodecollections, zfield, gcp, order,
             tps, fieldmap, addfields, relaxedFieldNameMatch,
             forceNullable, unsetDefault, unsetFid, nomd, mo)
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

