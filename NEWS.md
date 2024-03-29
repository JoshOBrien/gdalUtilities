## Changes since CRAN release of Version 1.2.5

* Remove the test suite, which hasn't been used since Version
  1.2.0. All of the tests involved comparison of results from the
  now-defunct/archived **gdalUtils** package. Also removed the
  no longer needed **testthat** package from Suggests.

## Version 1.2.5

* Removed all uses of **raster** and **rasterVis** packages from
  examples in the function help pages, replacing them with function
  calls from the **terra** package.

## Version 1.2.4

* Added `config_options=` argument to all of the packaged utilities,
  supporting usage of any of the GDAL Utility config options
  documented at
  [https://gdal.org/user/configoptions.html](https://gdal.org/user/configoptions.html). (This
  change was enabled by the recent addition to an argument of the same
  name to `sf::gdal_utils()`.)

## Version 1.2.3

* Removed **rgdal** from Suggests and added explicit dependency on
  raster of version `>= 3.6-1`, at request of Roger Bivand. (**rgdal**
  is soon to be retired, as is described in more detail
  [here](https://r-spatial.org/r/2022/04/12/evolution.html) and
  [here](https://r-spatial.org/r/2022/12/14/evolution2.html).)

## Version 1.2.2

* New functions `gdalmdiminfo()` and `gdalmdimtranslate()` support
  calls to those GDAL utilities.
  
* `gdalinfo()` gains a `quiet=` argument that controls whether or not
  the information it returns is printed to the console. (Formerly,
  printing to the console was always on.)
  
* `gdalinfo()` now (silently) returns a character vector containing
  the report returned by GDAL's gdalinfo utility. (Until now, it
  simply returned the name of the file supplied to its `datasetname=`
  formal argument.)
  
* Added formal arguments corresponding to all new command line options
  added between GDAL versions 3.2.1 and 3.5.2.
  
* Added dependency on package **sf** >= 1.0-9.

## Version 1.2.1

* Removed **gdalUtils** from Suggests, as it was removed from CRAN on
  2022-04-18. (I had used it in this package's test suite, comparing
  its results with those of this package.)
  
* Added **rgdal** to Suggests, to cure a CRAN complaint about its
  needing to be available to run the example in ?gdal_grid. 

## Version 1.2.0

* Removed `gRasterize()` function and, as a result, the
  **gdalUtilities** package's dependency on the **raster** package and
  *its* dependencies. (Thanks to Jakub Nowosad for the suggestion.)
  The source code for `gRasterize()` is still available in the GitHub
  gist at
  https://gist.github.com/JoshOBrien/7cf19b8b686e6d6230a78a1a9799883b
  from where it may be sourced using, e.g., `devtools::source_gist()`.
  
