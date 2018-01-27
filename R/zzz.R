
## Make an out of the way place to store data objects
.gdUtilsEnv <- new.env()


## Accessor function for grabbing formals tables from hidden environment
getFormalsTable <- function(fun) {
    switch(fun,
           gdal_rasterize = get("args_gdal_rasterize", envir=.gdUtilsEnv),
           gdal_translate = get("args_gdal_translate", envir=.gdUtilsEnv),
           gdalwarp       = get("args_gdalwarp", envir=.gdUtilsEnv),
           gdaldem        = get("args_gdaldem", envir=.gdUtilsEnv),
           gdal_contour   = get("args_gdal_contour", envir=.gdUtilsEnv),
           gdalinfo       = get("args_gdalinfo", envir=.gdUtilsEnv),
           gdaltindex     = get("args_gdaltindex", envir=.gdUtilsEnv),
           ogr2ogr        = get("args_ogr2ogr", envir=.gdUtilsEnv),
           nearblack      = get("args_nearblack", envir=.gdUtilsEnv),
           gdal_grid      = get("args_gdal_grid", envir=.gdUtilsEnv),
           gdalbuildvrt   = get("args_gdalbuildvrt", envir=.gdUtilsEnv))
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
l,              -l,              1,    TRUE
where,          -where,          1,    FALSE
sql,            -sql,            1,    FALSE
dialect,        -dialect,        1,    FALSE
of,             -of,             1,    FALSE
a_srs,          -a_srs,          1,    FALSE
co,             -co,             1,    TRUE
a_nodata,       -a_nodata,       1,    FALSE
init,           -init,           Inf,  FALSE
te,             -te,             4,    FALSE
tr,             -tr,             2,    FALSE
tap,            -tap,            0,    FALSE
ts,             -ts,             2,    FALSE
ot,             -ot,             1,    FALSE
q,              -q,              0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdal_translate"]] <- read.csv(text = "
arg,         flag,         narg, repeatable
src_dataset, ,             1,    FALSE
dst_dataset, ,             1,    FALSE
ot,          -ot,          1,    FALSE
strict,      -strict,      0,    FALSE
of,          -of,          1,    FALSE
b,           -b,           1,    TRUE
mask,        -mask,        1,    FALSE
expand,      -expand,      1,    FALSE
outsize,     -outsize,     2,    FALSE
tr,          -tr,          2,    FALSE
r,           -r,           1,    FALSE
scale,       -scale,       4,    FALSE
exponent,    -exponent,    1,    TRUE
unscale,     -unscale,     0,    FALSE
srcwin,      -srcwin,      4,    FALSE
projwin,     -projwin,     4,    FALSE
projwin_srs, -projwin_srs, 1,    FALSE
srs,         -srs,         1,    FALSE
epo,         -epo,         0,    FALSE
eco,         -eco,         0,    FALSE
a_srs,       -a_srs,       1,    FALSE
a_ullr,      -a_ullr,      4,    FALSE
a_nodata,    -a_nodata,    1,    FALSE
mo,          -mo,          1,    TRUE
co,          -co,          1,    TRUE
gcp,         -gcp,         4,    TRUE
q,           -q,           0,    FALSE
sds,         -sds,         0,    FALSE
stats,       -stats,       0,    FALSE
norat,       -norat,       0,    FALSE
oo,          -oo,          1,    FALSE
sd_index,    -sd_index,    1,    FALSE
config,      --config,     Inf,  FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalwarp"]] <- read.csv(text = "
arg,             flag,             narg, repeatable
srcfile,         ,                 1,    TRUE
dstfile,         ,                 1,    FALSE
s_srs,           -s_srs,           1,    FALSE
t_srs,           -t_srs,           1,    FALSE
to,              -to,              1,    FALSE
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
dstalpha,        -dstalpha,        0,    FALSE
wm,              -wm,              1,    FALSE
multi,           -multi,           0,    FALSE
q,               -q,               0,    FALSE
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
doo,             -doo,             1,    FALSE
config,          --config,         Inf,  TRUE",
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
p,                   -p,                   0,    FALSE
trigonometric,       -trigonometric,       0,    FALSE
zero_for_flat,       -zero_for_flat,       0,    FALSE
color_text_file,     -color_text_file,     1,    FALSE
alpha,               -alpha,               0,    FALSE
exact_color_entry,   -exact_color_entry,   0,    FALSE
nearest_color_entry, -nearest_color_entry, 0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdal_contour"]] <- read.csv(text = "
arg,          flag,     narg, repeatable
src_filename, ,         1,    FALSE
dst_filename, ,         1,    FALSE
b,            -b,       1,    FALSE
a,            -a,       1,    FALSE
threeD,       -3d,      0,    FALSE
inodata,      -inodata, 0,    FALSE
snodata,      -snodata, 1,    FALSE
i,            -i,       1,    FALSE
f,            -f,       1,    FALSE
dsco,         -dsco,    1,    TRUE
lco,          -lco,     1,    TRUE
off,          -off,     1,    FALSE
fl,           -fl,      1,    FALSE
nln,          -nln,     1,    FALSE
config,       --config, 1,    TRUE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdaltindex"]] <- read.csv(text = "
arg,                       flag,                       narg, repeatable
datasetname,               ,                           1,    FALSE
index_file,                -index_file,                1,    FALSE
gdal_file,                 -gdal_file,                 1,    FALSE
f,                         -f,                         1,    FALSE
tileindex,                 -tileindex,                 1,    FALSE
write_absolute_path,       -write_absolute_path,       0,    FALSE
skip_different_projection, -skip_different_projection, 0,    FALSE
t_srs,                     -t_srs,                     1,    FALSE
src_srs_name,              -src_srs_name,              1,    FALSE
src_srs_format,            -src_srs_format,            1,    FALSE
lyr_name,                  -lyr_name,                  1,    FALSE
config,                    --config,                   1,    TRUE",
stringsAsFactors=FALSE, strip.white = TRUE,
colClasses=c("character", "character", "numeric", "logical"))


args_ogr2ogr <- read.csv(text = "
arg,                   flag,                       narg, repeatable
src_datasource_name,   ,                              1,    FALSE
dst_datasource_name,   ,                              1,    FALSE
layer,                 ,                              1,    FALSE
f,                     -f,                            1,    FALSE
append,                -append,                       0,    FALSE
overwrite,             -overwrite,                    0,    FALSE
update,                -update,                       0,    FALSE
select,                -select,                       1,    FALSE
progress,              -progress,                     0,    FALSE
sql,                   -sql,                          1,    FALSE
dialect,               -dialect,                      1,    FALSE
where,                 -where,                        1,    FALSE
skipfailures,          -skipfailures,                 0,    FALSE
spat,                  -spat,                         4,    FALSE
spat_srs,              -spat_srs,                     1,     FALSE
geomfield,             -geomfield,                    1,     FALSE
dsco,                  -dsco,                         1,     FALSE
lco,                   -lco,                          1,     FALSE
nln,                   -nln,                          1,     FALSE
nlt,                   -nlt,                          1,     FALSE
dim,                   -dim,                          1,     FALSE
a_srs,                 -a_srs,                        1,     FALSE
t_srs,                 -t_srs,                        1,     FALSE
s_srs,                 -s_srs,                        1,     FALSE
preserve_fid,          -preserve_fid,                 0,    FALSE
fid,                   -fid,                          1,     FALSE
oo,                    -oo,                           1,     FALSE
doo,                   -doo,                          1,     FALSE
gt,                    -gt,                           1,     FALSE
ds_transaction,        -ds_transaction,               0,    FALSE
clipsrc,               -clipsrc,                      1,     FALSE
clipsrcsql,            -clipsrcsql,                   1,     FALSE
clipsrclayer,          -clipsrclayer,                 1,     FALSE
clipsrcwhere,          -clipsrcwhere,                 1,     FALSE
clipdst,               -clipdst,                      4,    FALSE
clipdstsql,            -clipdstsql,                   1,     FALSE
clipdstlayer,          -clipdstlayer,                 1,     FALSE
clipdstwhere,          -clipdstwhere,                 1,     FALSE
wrapdateline,          -wrapdateline,                 0,    FALSE
datelineoffset,        -datelineoffset,               0,    FALSE
simplify,              -simplify,                     1,     FALSE
segmentize,            -segmentize,                   1,     FALSE
fieldTypeToString,     -fieldTypeToString,            1,     FALSE
mapFieldType,          -mapFieldType,                 1,     FALSE
unsetFieldWidth,       -unsetFieldWidth,              0,    FALSE
splitlistfields,       -splitlistfields,              0,    FALSE
maxsubfields,          -maxsubfields,                 1,     FALSE
explodecollections,    -explodecollections,           0,    FALSE
zfield,                -zfield,                       1,     FALSE
gcp,                   -gcp,                          4,    TRUE
order,                 -order,                        1,     FALSE
tps,                   -tps,                          0,    FALSE
fieldmap,              -fieldmap,                     1,     FALSE
addfields,             -addfields,                    0,    FALSE
relaxedFieldNameMatch, -relaxedFieldNameMatch,        0,    FALSE
forceNullable,         -forceNullable,                0,    FALSE
unsetDefault,          -unsetDefault,                 0,    FALSE
unsetFid,              -unsetFid,                     0,    FALSE
nomd,                  -nomd,                         0,    FALSE
mo,                    -mo,                           0,    FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalinfo"]] <- read.csv(text = "
arg,           flag,         narg, repeatable
datasetname,   ,                1, FALSE
json,          -json,           0, FALSE
mm,            -mm,             0, FALSE
stats,         -stats,          0, FALSE
approx_stats,  -approx_stats,   0, FALSE
hist,          -hist,           0, FALSE
nogcp,         -nogcp,          0, FALSE
nomd,          -nomd,           0, FALSE
norat,         -norat,           0, FALSE
noct,          -noct,           0, FALSE
nofl,          -nofl,           0, FALSE
checksum,      -checksum,       0, FALSE
proj4,         -proj4,          0, FALSE
oo,            -oo,             1, FALSE
listmdd,       -listmdd,        0, FALSE
mdd,           -mdd,            1, FALSE
sd,            -sd,             1, FALSE",
stringsAsFactors = FALSE, strip.white = TRUE,
colClasses = c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_nearblack"]] <- read.csv(text = "
arg,           flag,         narg, repeatable
infile,        ,                1,   FALSE
o,             -o,              0,   FALSE
of,            -of,             0,   FALSE
co,            -co,             0,   FALSE
white,         -white,          0,   FALSE
color,         -color,          1,   TRUE
near,          -near,           1,   FALSE
nb,            -nb,             1,   FALSE
setalpha,      -setalpha,       0,   FALSE
setmask,       -setmask,        0,   FALSE
q,             -q,              0,   FALSE
datasetname,   ,                1, FALSE
json,          -json,           0, FALSE
mm,            -mm,             0, FALSE
stats,         -stats,          0, FALSE
approx_stats,  -approx_stats,   0, FALSE
hist,          -hist,           0, FALSE
nogcp,         -nogcp,          0, FALSE
nomd,          -nomd,           0, FALSE
norat,         -norat,           0, FALSE
noct,          -noct,           0, FALSE
nofl,          -nofl,           0, FALSE
checksum,      -checksum,       0, FALSE
proj4,         -proj4,          0, FALSE
oo,            -oo,             1, FALSE
listmdd,       -listmdd,        0, FALSE
mdd,           -mdd,            1, FALSE
sd,            -sd,             1, FALSE",
stringsAsFactors=FALSE, strip.white = TRUE,
colClasses=c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdal_grid"]] <- read.csv(text = "
arg,             flag,           narg,   repeatable
src_datasource,  ,                  1,        FALSE
dst_filename,    ,                  1,        FALSE
ot,              -ot,               1,        FALSE
of,              -of,               1,        FALSE
txe,             -txe,              1,        FALSE
tye,             -tye,              1,        FALSE
outsize,         -outsize,          1,        FALSE
a_srs,           -a_srs,            1,        FALSE
zfield,          -zfield,           1,        FALSE
z_increase,      -z_increase,       1,        FALSE
z_multiply,      -z_multiply,       1,        FALSE
a,               -a,                1,        FALSE
spat,            -spat,             1,        FALSE
clipsrc,         -clipsrc,          1,        FALSE
clipsrcsql,      -clipsrcsql,       1,        FALSE
clipsrclayer,    -clipsrclayer,     1,        FALSE
clipsrcwhere,    -clipsrcwhere,     1,        FALSE
l,               -l,                1,        FALSE
where,           -where,            1,        FALSE
sql,             -sql,              1,        FALSE
co,              -co,               1,        FALSE
q,               -q,                0,        FALSE
config,          --config,          1,        TRUE",
stringsAsFactors=FALSE, strip.white = TRUE,
colClasses=c("character", "character", "numeric", "logical"))


.gdUtilsEnv[["args_gdalbuildvrt"]] <- read.csv(text = "
output.vrt,                   ,                             1,  FALSE
gdalfile,                     ,                           Inf,  FALSE
tileindex,                    -tileindex,                   0,  FALSE
resolution,                   -resolution,                  1,  FALSE
te,                           -te,                          4,  FALSE
tr,                           -tr,                          2,  FALSE
tap,                          -tap,                         0,  FALSE
separate,                     -separate,                    0,  FALSE
b,                            -b,                           1,  FALSE
sd,                           -sd,                          1,  FALSE
allow_projection_difference,  -allow_projection_difference, 0,  FALSE
q,                            -q,                           0,  FALSE
addalpha,                     -addalpha,                    0,  FALSE
hidenodata,                   -hidenodata,                  0,  FALSE
srcnodata,                    -srcnodata,                   1,  FALSE
vrtnodata,                    -vrtnodata,                   1,  FALSE
a_srs,                        -a_srs,                       1,  FALSE
r,                            -r,                           1,  FALSE
input_file_list,              -input_file_list,             1,  FALSE
overwrite,                    -overwrite,                   0,  FALSE",
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
