## Version 1.2.0

* Removed `gRasterize()` function and, as a result, the
  **gdalUtilities** package's dependency on the **raster** package and
  *its* dependencies. (Thanks to Jakub Nowosad for the suggestion.)
  The source code for `gRasterize()` is still available in the GitHub
  gist at
  https://gist.github.com/JoshOBrien/7cf19b8b686e6d6230a78a1a9799883b
  from where it may be sourced using, e.g., `devtools::source_gist()`.
  
