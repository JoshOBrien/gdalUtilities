##' Defunct function(s) in the gdalUtilities package
##'
##' These functions have been removed from this package.
##'
##' \code{gRasterize} was removed due to its dependency on the
##' \pkg{raster} package, on which \pkg{gdalUtilities} no longer
##' Depends. The source for \code{gRasterize} may still be found (and
##' sourced, using \code{devtools::source_gist()}) at
##' \url{https://gist.github.com/JoshOBrien/7cf19b8b686e6d6230a78a1a9799883b}.
##' @rdname gdalUtilities-defunct
##' @name gdalUtilities-defunct
##' @param ... Function arguments
##' @docType package
##' @export
##' @aliases gRasterize
##'
gRasterize <- function (...) {
    msg <-
        paste0("\n'gRasterize' has been removed from this package. It is now saved\n",
               "to a GitHub gist from which it may be sourced by doing, for example:\n",
               "devtools::source_gist('https://gist.github.com/JoshOBrien/7cf19b8b686e6d6230a78a1a9799883b')")
    .Defunct(msg=msg)
}
