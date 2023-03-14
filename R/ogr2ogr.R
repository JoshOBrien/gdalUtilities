##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{ogr2ogr}.  For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{https://gdal.org/programs/ogr2ogr.html}.
##'
##' @title Interface to GDAL's ogr2ogr utility
##' @param src_datasource_name Character. Path to a GDAL-supported
##'     readable datasource.
##' @param dst_datasource_name Character. Path to a GDAL-supported
##'     output file.
##' @param ... Here, a placeholder argument that forces users to
##'     supply exact names of all subsequent formal arguments.
##' @param layer,f,append,overwrite,update,select,progress,sql,dialect
##'     See the GDAL project's
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation} for details.
##' @param where,skipfailures,spat,spat_srs,geomfield,dsco,lco,nln,nlt
##'     See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param dim,a_srs,t_srs,s_srs,ct,preserve_fid,fid,limit,oo,doo,gt
##'     See the See
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param ds_transaction,clipsrc,clipsrcsql,clipsrclayer,clipsrcwhere
##'     See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param clipdst,clipdstsql,clipdstlayer,clipdstwhere,wrapdateline
##'     See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param datelineoffset,simplify,segmentize,makevalid,addfields See
##'     See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param unsetFid,emptyStrAsNull,relaxedFieldNameMatch,forceNullable
##'     See See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param unsetDefault,fieldTypeToString,unsetFieldWidth,mapFieldType
##'     See \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param fieldmap,splitlistfields,maxsubfields See
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param resolveDomains,explodecollections,zfield,gcp,order,tps See
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param s_coord_epoch,t_coord_epoch,a_coord_epoch See
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param nomd,mo,noNativeData See
##'     \href{https://gdal.org/programs/ogr2ogr.html}{ogr2ogr
##'     documentation}.
##' @param config_options A named character vector with GDAL config
##'     options, of the form \code{c(option1=value1, option2=value2)}. (See
##'     \href{https://gdal.org/user/configoptions.html}{here} for a
##'     complete list of supported config options.)
##' @param dryrun Logical (default \code{FALSE}). If \code{TRUE},
##'     instead of executing the requested call to GDAL, the function
##'     will print the command-line call that would produce the
##'     equivalent output.
##' @name ogr2ogr
##' @rdname ogr2ogr
##' @return Silently returns path to \code{dst_datasource_name}.
##' @export
##' @author Joshua O'Brien
##' @examples
##' \donttest{
##' ## Prepare file paths
##' td <- tempdir()
##' lux <- system.file("external/lux.shp", package = "raster")
##' lux_merc <- file.path(td, "mercator.shp")
##' lux_lcc <- file.path(td, "lcc.shp")
##'
##' ## Reproject to 'WGS 84/World Mercator'
##' ## https://en.wikipedia.org/wiki/Mercator_projection
##' ogr2ogr(lux, lux_merc, t_srs = "EPSG:3395", overwrite = TRUE)
##' ## Reproject to a Canadian 'Lambert conformal conic projection'
##' ## https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection
##' ogr2ogr(lux, lux_lcc, t_srs = "EPSG:3347", overwrite = TRUE)
##'
##' if(requireNamespace("raster", quietly = TRUE)) {
##'     library(raster)
##'     op <- par(mfcol = c(1,2))
##'     plot(shapefile(lux_merc), main = "WGS 84",
##'          border = "darkgrey", col = gray.colors(12))
##'     plot(shapefile(lux_lcc), main = "LCC",
##'          border = "darkgrey", col = gray.colors(12))
##'     par(op)
##' }
##' }
ogr2ogr <-
    function(src_datasource_name, dst_datasource_name, ..., layer, f,
             append, overwrite, update, select, progress, sql,
             dialect, where, skipfailures, spat, spat_srs, geomfield,
             dsco, lco, nln, nlt, dim, a_srs, t_srs, s_srs, ct,
             preserve_fid, fid, limit, oo, doo, gt, ds_transaction,
             clipsrc, clipsrcsql, clipsrclayer, clipsrcwhere, clipdst,
             clipdstsql, clipdstlayer, clipdstwhere, wrapdateline,
             datelineoffset, simplify, segmentize, makevalid,
             fieldTypeToString, unsetFieldWidth, mapFieldType,
             fieldmap, splitlistfields, maxsubfields, resolveDomains,
             explodecollections, zfield, gcp, order, tps,
             s_coord_epoch, t_coord_epoch, a_coord_epoch, addfields,
             unsetFid, emptyStrAsNull, relaxedFieldNameMatch,
             forceNullable, unsetDefault, nomd, mo, noNativeData,
             config_options = character(0), dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource_name",
           "dst_datasource_name",
           "config_options", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("ogr2ogr")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("ogr2ogr", dst_datasource_name,
                      src_datasource_name, opts=opts)
        return(x)
    }

    gdal_utils("vectortranslate",
               source = src_datasource_name,
               destination = dst_datasource_name,
               options = opts,
               config_options = config_options)
    invisible(dst_datasource_name)
}
