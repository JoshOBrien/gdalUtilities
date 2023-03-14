
## Make an out of the way place to store data objects
.gdUtilsEnv <- new.env()


## Accessor function for grabbing formals tables from hidden environment
##
## .gdUtilsEnv is stored in the package's namespace. To directly
## inspect it, try, for example:
##     ls(asNamespace("gdalUtilities")[[".gdUtilsEnv"]]))
getFormalsTable <- function(fun) {
    switch(fun,
           gdal_rasterize    = get("args_gdal_rasterize", envir=.gdUtilsEnv),
           gdal_translate    = get("args_gdal_translate", envir=.gdUtilsEnv),
           gdalwarp          = get("args_gdalwarp", envir=.gdUtilsEnv),
           gdaldem           = get("args_gdaldem", envir=.gdUtilsEnv),
           ## gdal_contour      = get("args_gdal_contour", envir=.gdUtilsEnv),
           gdalinfo          = get("args_gdalinfo", envir=.gdUtilsEnv),
           ## gdaltindex        = get("args_gdaltindex", envir=.gdUtilsEnv),
           ogr2ogr           = get("args_ogr2ogr", envir=.gdUtilsEnv),
           nearblack         = get("args_nearblack", envir=.gdUtilsEnv),
           gdal_grid         = get("args_gdal_grid", envir=.gdUtilsEnv),
           gdalbuildvrt      = get("args_gdalbuildvrt", envir=.gdUtilsEnv),
           gdalmdiminfo      = get("args_gdalmdiminfo", envir=.gdUtilsEnv),
           gdalmdimtranslate = get("args_gdalmdimtranslate", envir=.gdUtilsEnv))
}


## Tables of formal arguments to GDAL utilities functions.
.gdUtilsEnv[["args_gdal_rasterize"]] <- read.csv(text = "
arg,            flag,            narg, repeatable
src_datasource, -src_datasource, 1,    FALSE
dst_filename,   -dst_filename,   1,    FALSE
b,              -b,              1,    TRUE
i,              -i,              0,    FALSE
at,             -at,             0,    FALSE
burn,           -burn,           1,    TRUE
a,              -a,              1,    FALSE
threeD,         -3d,             0,    FALSE
add,            -add,            0,    FALSE
l,              -l,              1,    TRUE
where,          -where,          1,    FALSE
sql,            -sql,            1,    FALSE
dialect,        -dialect,        1,    FALSE
of,             -of,             1,    FALSE
a_nodata,       -a_nodata,       1,    FALSE
init,           -init,           Inf,  FALSE
a_srs,          -a_srs,          1,    FALSE
to,             -to,             1,    FALSE
co,             -co,             1,    TRUE
te,             -te,             4,    FALSE
tr,             -tr,             2,    FALSE
tap,            -tap,            0,    FALSE
ts,             -ts,             2,    FALSE
ot,             -ot,             1,    FALSE
optim,          -optim,          1,    FALSE
q,              -q,              0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdal_translate"]] <- read.csv(text = "
arg,           flag,           narg, repeatable
src_dataset,   ,               1,    FALSE
dst_dataset,   ,               1,    FALSE
ot,            -ot,            1,    FALSE
strict,        -strict,        0,    FALSE
IF,            -if,            1,    TRUE
of,            -of,            1,    FALSE
b,             -b,             1,    TRUE
mask,          -mask,          1,    FALSE
expand,        -expand,        1,    FALSE
outsize,       -outsize,       2,    FALSE
tr,            -tr,            2,    FALSE
r,             -r,             1,    FALSE
scale,         -scale,         4,    TRUE
exponent,      -exponent,      1,    TRUE
unscale,       -unscale,       0,    FALSE
srcwin,        -srcwin,        4,    FALSE
projwin,       -projwin,       4,    FALSE
projwin_srs,   -projwin_srs,   1,    FALSE
epo,           -epo,           0,    FALSE
eco,           -eco,           0,    FALSE
a_srs,         -a_srs,         1,    FALSE
a_coord_epoch, -a_coord_epoch, 1,    FALSE
a_ullr,        -a_ullr,        4,    FALSE
a_nodata,      -a_nodata,      1,    FALSE
a_scale,       -a_scale,       1,    FALSE
a_offset,      -a_offset,      1,    FALSE
colorinterp,   -colorinterp,   1,    FALSE
mo,            -mo,            1,    TRUE
co,            -co,            1,    TRUE
nogcp,         -nogcp,         0,    FALSE
gcp,           -gcp,           4,    TRUE
q,             -q,             0,    FALSE
sds,           -sds,           0,    FALSE
stats,         -stats,         0,    FALSE
norat,         -norat,         0,    FALSE
noxmp,         -noxmp,         0,    FALSE
oo,            -oo,            1,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalwarp"]] <- read.csv(text = "
arg,             flag,             narg, repeatable
srcfile,         ,                 1,    TRUE
dstfile,         ,                 1,    FALSE
s_srs,           -s_srs,           1,    FALSE
t_srs,           -t_srs,           1,    FALSE
ct,              -ct,              1,    FALSE
to,              -to,              1,    FALSE
vshift,          -vshift,          0,    FALSE
novshift,        -novshift,        0,    FALSE
s_coord_epoch,   -s_coord_epoch,   1,    FALSE
t_coord_epoch,   -t_coord_epoch,   1,    FALSE
order,           -order,           1,    FALSE
tps,             -tps,             0,    FALSE
rpc,             -rpc,             0,    FALSE
geoloc,          -geoloc,          0,    FALSE
et,              -et,              1,    FALSE
refine_gcps,     -refine_gcps,     2,    FALSE
te,              -te,              4,    FALSE
te_srs,          -te_srs,          1,    FALSE
tr,              -tr,              2,    FALSE
tap,             -tap,             0,    FALSE
ts,              -ts,              2,    FALSE
ovr,             -ovr,             1,    FALSE
wo,              -wo,              1,    TRUE
ot,              -ot,              1,    FALSE
wt,              -wt,              1,    FALSE
r,               -r,               1,    FALSE
srcnodata,       -srcnodata,       1,    FALSE
dstnodata,       -dstnodata,       1,    FALSE
srcalpha,        -srcalpha,        0,    FALSE
nosrcalpha,      -nosrcalpha,      0,    FALSE
dstalpha,        -dstalpha,        0,    FALSE
wm,              -wm,              1,    FALSE
multi,           -multi,           0,    FALSE
q,               -q,               0,    FALSE
IF,              -if,              1,    TRUE
of,              -of,              1,    FALSE
co,              -co,              1,    TRUE
cutline,         -cutline,         1,    FALSE
cl,              -cl,              1,    FALSE
cwhere,          -cwhere,          1,    FALSE
csql,            -csql,            1,    FALSE
cblend,          -cblend,          1,    FALSE
crop_to_cutline, -crop_to_cutline, 0,    FALSE
overwrite,       -overwrite,       0,    FALSE
nomd,            -nomd,            0,    FALSE
cvmd,            -cvmd,            1,    FALSE
setci,           -setci,           0,    FALSE
oo,              -oo,              1,    FALSE
doo,             -doo,             1,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdaldem"]] <- read.csv(text = "
arg,                 flag,                 narg, repeatable
mode,                ,                     1,    TRUE
input_dem,           ,                     1,    FALSE
output_map,          ,                     1,    FALSE
of,                  -of,                  1,    FALSE
compute_edges,       -compute_edges,       0,    FALSE
alg,                 -alg,                 1,    FALSE
b,                   -b,                   Inf,  FALSE
co,                  -co,                  1,    TRUE
q,                   -q,                   0,    FALSE
z,                   -z,                   1,    FALSE
s,                   -s,                   1,    FALSE
az,                  -az,                  1,    FALSE
alt,                 -alt,                 1,    FALSE
combined,            -combined,            1,    FALSE
multidirectional,    -multidirectional,    0,    FALSE
igor,                -igor,                0,    FALSE
p,                   -p,                   0,    FALSE
trigonometric,       -trigonometric,       0,    FALSE
zero_for_flat,       -zero_for_flat,       0,    FALSE
color_text_file,     -color_text_file,     1,    FALSE
alpha,               -alpha,               0,    FALSE
exact_color_entry,   -exact_color_entry,   0,    FALSE
nearest_color_entry, -nearest_color_entry, 0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_ogr2ogr"]] <- read.csv(text = "
arg,                   flag,                  narg, repeatable
src_datasource_name,   ,                      1,    FALSE
dst_datasource_name,   ,                      1,    FALSE
layer,                 ,                      1,    FALSE
f,                     -f,                    1,    FALSE
append,                -append,               0,    FALSE
overwrite,             -overwrite,            0,    FALSE
update,                -update,               0,    FALSE
select,                -select,               1,    FALSE
progress,              -progress,             0,    FALSE
sql,                   -sql,                  1,    FALSE
dialect,               -dialect,              1,    FALSE
where,                 -where,                1,    FALSE
skipfailures,          -skipfailures,         0,    FALSE
spat,                  -spat,                 4,    FALSE
spat_srs,              -spat_srs,             1,    FALSE
geomfield,             -geomfield,            1,    FALSE
dsco,                  -dsco,                 1,    FALSE
lco,                   -lco,                  1,    FALSE
nln,                   -nln,                  1,    FALSE
nlt,                   -nlt,                  1,    FALSE
dim,                   -dim,                  1,    FALSE
a_srs,                 -a_srs,                1,    FALSE
t_srs,                 -t_srs,                1,    FALSE
s_srs,                 -s_srs,                1,    FALSE
ct,                    -ct,                   1,    FALSE
preserve_fid,          -preserve_fid,         0,    FALSE
fid,                   -fid,                  1,    FALSE
limit,                 -limit,                1,    FALSE
oo,                    -oo,                   1,    FALSE
doo,                   -doo,                  1,    FALSE
gt,                    -gt,                   1,    FALSE
ds_transaction,        -ds_transaction,       0,    FALSE
clipsrc,               -clipsrc,              4,    FALSE
clipsrcsql,            -clipsrcsql,           1,    FALSE
clipsrclayer,          -clipsrclayer,         1,    FALSE
clipsrcwhere,          -clipsrcwhere,         1,    FALSE
clipdst,               -clipdst,              4,    FALSE
clipdstsql,            -clipdstsql,           1,    FALSE
clipdstlayer,          -clipdstlayer,         1,    FALSE
clipdstwhere,          -clipdstwhere,         1,    FALSE
wrapdateline,          -wrapdateline,         0,    FALSE
datelineoffset,        -datelineoffset,       0,    FALSE
simplify,              -simplify,             1,    FALSE
segmentize,            -segmentize,           1,    FALSE
makevalid,             -makevalid,            0,    FALSE
addfields,             -addfields,            0,    FALSE
unsetFid,              -unsetFid,             0,    FALSE
emptyStrAsNull,        -emptyStrAsNull,       0,    FALSE
relaxedFieldNameMatch, -relaxedFieldNameMatch,0,    FALSE
forceNullable,         -forceNullable,        0,    FALSE
unsetDefault,          -unsetDefault,         0,    FALSE
fieldTypeToString,     -fieldTypeToString,    1,    FALSE
unsetFieldWidth,       -unsetFieldWidth,      0,    FALSE
mapFieldType,          -mapFieldType,         1,    FALSE
fieldmap,              -fieldmap,             1,    FALSE
splitlistfields,       -splitlistfields,      0,    FALSE
maxsubfields,          -maxsubfields,         1,    FALSE
resolveDomains,        -resolveDomains,       0,    FALSE
explodecollections,    -explodecollections,   0,    FALSE
zfield,                -zfield,               1,    FALSE
gcp,                   -gcp,                  4,    TRUE
order,                 -order,                1,    FALSE
tps,                   -tps,                  0,    FALSE
s_coord_epoch,         -s_coord_epoch,        1,    FALSE
t_coord_epoch,         -t_coord_epoch,        1,    FALSE
a_coord_epoch,         -a_coord_epoch,        1,    FALSE
nomd,                  -nomd,                 0,    FALSE
mo,                    -mo,                   1,    TRUE
noNativeData,          -noNativeData,         0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalinfo"]] <- read.csv(text = "
arg,           flag,          narg, repeatable
datasetname,   ,              1,    FALSE
json,          -json,         0,    FALSE
mm,            -mm,           0,    FALSE
stats,         -stats,        0,    FALSE
approx_stats,  -approx_stats, 0,    FALSE
hist,          -hist,         0,    FALSE
nogcp,         -nogcp,        0,    FALSE
nomd,          -nomd,         0,    FALSE
norat,         -norat,        0,    FALSE
noct,          -noct,         0,    FALSE
nofl,          -nofl,         0,    FALSE
checksum,      -checksum,     0,    FALSE
proj4,         -proj4,        0,    FALSE
listmdd,       -listmdd,      0,    FALSE
mdd,           -mdd,          1,    FALSE
wkt_format,    -wkt_format,   1,    FALSE
sd,            -sd,           1,    FALSE
oo,            -oo,           1,    TRUE,
IF,            -if,           1,    TRUE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_nearblack"]] <- read.csv(text = "
arg,           flag,          narg, repeatable
infile,        ,              1,    FALSE
o,             -o,            1,    FALSE
of,            -of,           1,    FALSE
white,         -white,        0,    FALSE
color,         -color,        1,    TRUE
near,          -near,         1,    FALSE
nb,            -nb,           1,    FALSE
setalpha,      -setalpha,     0,    FALSE
setmask,       -setmask,      0,    FALSE
q,             -q,            0,    FALSE
co,            -co,           1,    TRUE
datasetname,   ,              1,    FALSE",
stringsAsFactors=FALSE, strip.white = TRUE,
colClasses=c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdal_grid"]] <- read.csv(text = "
arg,             flag,           narg,   repeatable
src_datasource,  ,               1,      FALSE
dst_filename,    ,               1,      FALSE
ot,              -ot,            1,      FALSE
of,              -of,            1,      FALSE
txe,             -txe,           1,      FALSE
tye,             -tye,           1,      FALSE
tr,              -tr,            2,      FALSE
outsize,         -outsize,       1,      FALSE
a_srs,           -a_srs,         1,      FALSE
zfield,          -zfield,        1,      FALSE
z_increase,      -z_increase,    1,      FALSE
z_multiply,      -z_multiply,    1,      FALSE
a,               -a,             1,      FALSE
spat,            -spat,          1,      FALSE
clipsrc,         -clipsrc,       1,      FALSE
clipsrcsql,      -clipsrcsql,    1,      FALSE
clipsrclayer,    -clipsrclayer,  1,      FALSE
clipsrcwhere,    -clipsrcwhere,  1,      FALSE
l,               -l,             1,      FALSE
where,           -where,         1,      FALSE
sql,             -sql,           1,      FALSE
co,              -co,            1,      FALSE
q,               -q,             0,      FALSE",
stringsAsFactors=FALSE, strip.white = TRUE,
colClasses=c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalbuildvrt"]] <- read.csv(text = "
arg,                          flag,                         narg, repeatable
output.vrt,                   ,                             1,    FALSE
gdalfile,                     ,                             Inf,  FALSE
tileindex,                    -tileindex,                   0,    FALSE
resolution,                   -resolution,                  1,    FALSE
te,                           -te,                          4,    FALSE
tr,                           -tr,                          2,    FALSE
tap,                          -tap,                         0,    FALSE
separate,                     -separate,                    0,    FALSE
b,                            -b,                           1,    TRUE
sd,                           -sd,                          1,    FALSE
allow_projection_difference,  -allow_projection_difference, 0,    FALSE
q,                            -q,                           0,    FALSE
optim,                        -optim,                       1,    FALSE
addalpha,                     -addalpha,                    0,    FALSE
hidenodata,                   -hidenodata,                  0,    FALSE
srcnodata,                    -srcnodata,                   1,    FALSE
vrtnodata,                    -vrtnodata,                   1,    FALSE
ignore_srcmaskband,           -ignore_srcmaskband,          0,    FALSE
a_srs,                        -a_srs,                       1,    FALSE
r,                            -r,                           1,    FALSE
oo,                           -oo,                          1,    TRUE
input_file_list,              -input_file_list,             1,    FALSE
strict,                       -strict,                      0,    FALSE
non_strict,                   -non_strict,                  0,    FALSE
overwrite,                    -overwrite,                   0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalmdiminfo"]] <- read.csv(text = "
arg,           flag,          narg, repeatable
datasetname,   ,              1,    FALSE
oo,            -oo,           1,    TRUE
arrayoption,   -arrayoption,  1,    TRUE
detailed,      -detailed,     0,    FALSE
nopretty,      -nopretty,     0,    FALSE
array,         -array,        1,    FALSE
limit,         -limit,        1,    FALSE
stats,         -stats,        0,    FALSE
IF,            -if,           1,    TRUE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalmdimtranslate"]] <- read.csv(text = "
arg,           flag,          narg, repeatable
src_filename,  ,              1,    FALSE
dst_filename,  ,              1,    FALSE
co,            -co,           1,    TRUE
IF,            -if,           1,    TRUE
of,            -of,           1,    FALSE
array,         -array,        1,    TRUE
group,         -group,        1,    TRUE
subset,        -subset,       1,    TRUE
scaleaxes,     -scaleaxes,    1,    TRUE
oo,            -oo,           1,    TRUE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))





## Will help if we allow users to supply raw commmand-line calls to
## gdal utility functions, directly to some R function.
tokenizer <- function(x) {
    pat <- "(\"(.*?)\")|('(.)*?')|(\\S+)"
    m <- gregexpr(pat, x)
    regmatches(x,m)[[1]]
}
## s1 <- "hi thereyou! looliepop 'fastener ' ' saysI' \"andi too '\""
## s2 <- "gdal_rasterize -b 1 -b 2 -b 3 -burn 255 -burn 0 -burn 0 -l mask mask.shp work.tif"
## s3 <- "gdal_rasterize -a ROOF_H -where 'class=\"A\"' -l footprints footprints.shp city_dem.tif"
## tokenizer(s1)
## tokenizer(s2)
## tokenizer(s3)


## if(CLI_equivalent) {
##     CLIcall("gdal_translate", src_dataset, dst_dataset, opts=opts)
## }
CLI_call <- function(util, ..., opts) {
    dots <- unlist(list(...))
    x <- paste(c(util, dots, opts), collapse=" ")
    x <- gsub("\\\\|/", .Platform$file.sep, x)
    x
}
