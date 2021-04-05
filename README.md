# GDAL Utility Functions for R

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/)
[![License](https://JoshOBrien.github.io/badges/GPL2+.svg)](https://www.gnu.org/licenses/gpl-2.0.html)
[![](https://www.r-pkg.org/badges/version/gdalUtilities)](https://www.r-pkg.org/pkg/gdalUtilities)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/gdalUtilities)](https://www.r-pkg.org/pkg/gdalUtilities)

The R package [**sf**](https://cran.r-project.org/package=sf) ships
with self-contained GDAL executables, including a bare bones interface
to several of the GDAL-related utility programs collectively known as
the GDAL utilities (the full set of which are documented
[here](https://gdal.org/programs/index.html)). For each of those
utilities, this package provides an R wrapper whose formal arguments
closely mirror those of the GDAL command line interface.

The R functions in this package mirror, as closely possible, the
utilities to which they provide interfaces. Each function has the same
name as its corresponding command-line utility, takes the same
arguments and, given the same inputs and arguments, produces identical
output. All of the GDAL utilities operate on data stored in files and
typically write their output directly to other files. As a result,
processing data stored in any of R's more common spatial formats
(i.e. those supported by the **sp**, **sf**, and **raster** packages)
will require first writing to disk, then processing with the package's
wrapper functions before reading back into R.

## Installation

To install the development version from GitHub, run:
```r
library(devtools)
install_github("JoshOBrien/gdalUtilities")
```

## Usage

Translating a GDAL command-line call into the equivalent R call is, in
most cases, a straightforward excercise. To do so, just follow these
basic rules:

1. **Argument names:** In general, the name of the R argument
   corresponding to a GDAL utility's command line flag is gotten by
   removing the `-` or `--` from the flag. So, for instance, in a call
   to `gdalUtilities::gdal_translate()`, the command line flags
   `-projwin_srs` and `--config` become the formal arguments
   `projwin_srs` and `config`. The single exception is the
   command-line flag `-3d`, an option for `gdal_rasterize`, which is
   represented by the formal argument `threeD` in its R equivalent (R
   arguments not being allowed to start with a digit).

2. **Character and numeric arguments:** Flags that are followed by one
   or more character strings or numbers may be specified by passing
   either a character or numeric vector to the corresponding formal
   argument. So, for example, to shrink the size of the raster
   `"in.tif"` by 50% in each dimension, outputting the result as
   `"out.tif"`, you could do:
   ```r
   gdal_translate("in.tif", "out.tif", outsize = c("50%","50%"))
   ```
 
3. **Logical arguments:** Many flags are logical, specifying options
   that are turned on when they are present, and not when they are
   absent. In the equivalent R functions (as in their corresponding
   GDAL utilities) these options are all off by default, and can be
   turned on by setting them to `TRUE`. In `gdal_rasterize`, for
   instance, one can 'invert' a rasterization, burning in a new value
   on all pixels *not* covered by a vector feature, by adding the flag
   `-i`. With the equivalent R function, the same action would be
   triggered by setting `i=TRUE`.
 
4. **Repeatable arguments:** Several GDAL utilities take one or a few
   flags that are potentially 'repeatable'. `gdal_translate`, for
   example, allows users to add ground control points to a raster
   layer, an operation accomplished by prepending each ground control
   point's coordinates with the flag `-gcp`. R, however, does not
   allow repeated arguments, so repeated instances of a flag need
   instead to be passed in as rows of a matrix. To add four ground
   control points to a raster using `gdal_translate()`, for example,
   you would do something like the following:
   
   ```r
   ## Four column matrix supplying: column, row, x-coord, y-coord
   gcps <- matrix(c(0,  100, 174.761, -36.880,  ## lower-left
                    73,   0, 174.769, -36.871,  ## upper-right
                    73, 100, 174.769, -36.880,  ## lower-right
                     0,   0, 174.761, -36.871), ## upper-left
                  ncol = 4, byrow = TRUE)
   in_tif <- "maunga.tif"
   gcp_tif <- "maunga_gcp.tif"
   gdal_translate(in_tif, gcp_tif, gcp = gcps, a_srs = "EPSG:4326")
   ```

5. **Checking call using `dryrun = TRUE`:** As a quick check that
   one's call to an R function corresponds to the desired command-line
   equivalent, one can set `dryrun = TRUE`.

   ```r
   gdal_translate("in.tif", "out.tif", outsize = c("50%","50%"), dryrun = TRUE)
   ## [1] "gdal_translate in.tif out.tif -outsize 50% 50%"
   
   gdal_translate(in_tif, gcp_tif, gcp = gcps, a_srs = "EPSG:4326", dryrun=TRUE)
   ## gdal_translate maunga.tif maunga_gcp.tif -a_srs EPSG:4326 \
   ## -gcp 0 100 174.761 -36.88 -gcp 73 0 174.769 -36.871 \
   ## -gcp 73 100 174.769 -36.88 -gcp 0 0 174.761 -36.871
   ```


## Comparison to **gdalUtils** package

Jonathan Greenberg's [**gdalUtils**
package](https://cran.r-project.org/package=gdalUtils) has long
provided functionality very much like **gdalUtilities**, with one
important caveat. Unlike the current package, **gdalUtils** requires
that an independent local system installation of GDAL already be in
place. (It works, in essence, by constructing system calls to GDAL,
which it then farms out via calls to the R function `system()`.)
**gdalUtilities**, by constrast, sidesteps any dependence on an
additional external program. It does so by constructing calls to the R
function `sf::gdal_utils()` which provides a raw interface to GDAL
binaries that are bundled together as part of the R package **sf**.


## Supported GDAL utilities

At present, `sf::gdal_utils()` (and thus the **gdalUtilities**
package) provides bindings for only a subset of the GDAL utilities. A
list of the supported utilities, followed by those that are not
supported, are given below:

### GDAL utilities provided by this package
```r
## Supported 'GDAL Utility Programs'
gdal_grid
gdal_rasterize
gdal_translate
gdalbuildvrt
gdaldem
gdalinfo
gdalwarp
nearblack

## Supported 'OGR Utility Programs'
ogr2ogr
```

### GDAL utilities *not* provided by this package
```r
## Unsupported 'GDAL Utility Programs'
gdal_contour
gdaladdo
gdallocationinfo
gdalmanage
gdaltindex
gdaltransform

## Unsupported 'OGR Utility Programs' 
ogrinfo
ogrlineref
ogrtindex
```
