
##' Rasterize \code{Spatial*} objects using gdal_rasterize.
##'
##' For a 1000-by-1000 raster, this function \code{gRasterize} is more
##' than 6 times faster than \code{raster::rasterize}. For a
##' 2000-by-2000 raster, it is almost 12 times faster (6 seconds
##' vs. 70 seconds on my Windows laptop).
##'
##' I've modeled \code{gRasterize} arguments and behavior on that of
##' \code{\link[raster]{rasterize}}. Like\code{rasterize},it takes a
##' \code{filename=} argument which defaults to \code{""} in which
##' case (unless it's determined internally that
##' \code{!canProcessInMemory(rstr, 3)}) the returned raster is
##' \code{'inMemory'}. Otherwise, if the raster is too large or if a
##' filename is supplied, it's returned \code{fromDisk}.
##'
##' Internally, \code{\link[gdalUtils]{gdal_rasterize}} by default
##' writes to a file, and only optionally returns an R \code{Raster}
##' object (when its \code{output_Raster = TRUE}); to get the raster
##' \code{'inMemory'}, I use \code{\link[raster]{readAll}}
##' (after a check that it's really OK, memory-wise to do so.)
##' @title Fast rasterize for Spatial objects
##' @param SPDF A \code{Spatial*} object to be rasterized.
##' @param r A \code{Raster*} object to be used as the rasterization template.
##' @param field Character. The name of the numeric column in
##' \code{data.frame()} that will be written to the output Raster* object.
##' @param filename Character. Output filename (optional). If none is
##' supplied, the resulting raster will be stored \code{inMemory}
##' (unless it is too large, as determined by a call to
##' \code{canProcessInMemory(y, 3)}
##' @return A \code{RasterLayer} object containing a rasterized
##' version of \code{SPDF}.
##' @importFrom gdalUtils gdal_rasterize
##' @importFrom raster levels
##' @export
##' @author Joshua O'Brien
##' @examples
##' SPDF <- shapefile(system.file("external/lux.shp", package="raster"))
##' ## rr <- raster(extent(SPDF), ncol=100, nrow=100, crs=proj4string(SPDF))
##' llratio <- 1/cos(pi*mean(coordinates(SPDF)[,2])/180)
##' rr <- raster(extent(SPDF),
##'              resolution=c(llratio*0.01, 0.01),
##'              crs=proj4string(SPDF))
##'
##' ## An example using an integer-valued field
##' rInt <- gRasterize(SPDF, rr, field = "ID_2")
##' plot(rInt, col=RColorBrewer::brewer.pal(name = "Paired", 12))
##' plot(SPDF, lwd=3, border="grey30", add=TRUE)
##'
##' ## An example using a character-valued field
##' rFac <- gRasterize(SPDF, rr, field = "NAME_2")
##' rasterVis::levelplot(rFac)
gRasterize <- function (SPDF, r, field, filename = "") {
    INMEM <- canProcessInMemory(r, 3) && filename == ""
    ## character/factor field preparations
    ofield <- SPDF[[field]]
    FACTOR_FIELD <- inherits(ofield, c("character", "factor"))
    if(FACTOR_FIELD) {
        SPDF[[field]] <- as.integer(factor(ofield, levels = unique(ofield)))
    }
    ## Write both layers to files ("*.shp" & "*.tif" respectively)
    tmpDir <- dirname(rasterTmpFile())
    shpDir <- file.path(tmpDir, "shapes")
    shpFile <- file.path(shpDir,  "SPDF.shp")
    if(!dir.exists(shpDir)) {
        on.exit(unlink(shpDir, recursive=TRUE), add=TRUE)
        dir.create(shpDir)
    }
    if (filename == "") {
        rasFile <- file.path(tmpDir, "r.tif")
    } else {
        rasFile <- filename
    }
    shapefile(SPDF, shpFile, overwrite = TRUE)
    ## We want to burn into a raster with background of NAs
    ## r[] <- NA
    ## suppressWarnings(writeRaster(r, filename = rasFile,
    ##                              format="GTiff", datatype='FLT4S',
    ##                              overwrite = TRUE))
    init(r, fun = function(x) NA, filename = rasFile, format = "GTiff",
         datatype = "FLT4S", overwrite = TRUE)
    ## Command-line option processing
    ## (Will eventually be much more extensive, perhaps in its own function.)
    opts <- c("-a", field)
    ## Rasterize polygons, burning into the raster values from selected field
    ## b <- gdal_rasterize(shpFile, rasFile, a = field, output_Raster = TRUE)
    b <- gdal_rasterize(shpFile, rasFile, a = field)
    ## r <- raster(b, layer=1)
    r <- raster(rasFile)
    ## Further  processing for character or factor fields from SPDF
    if(FACTOR_FIELD) {
        r <- ratify(r)
        RAT <- levels(r)[[1]]
        RAT[field] <- unique(ofield)[RAT[[1]]]
        levels(r) <- RAT
    }
    ## Clean up intermediate files:
    unlink(dirname(shpFile), recursive = TRUE)
    if(INMEM) {
        r <- readAll(r)
        unlink(rasFile)
    }
    r
}

