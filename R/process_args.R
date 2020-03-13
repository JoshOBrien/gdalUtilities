## Helper function used in process_args()
process_repeated_flag <- function(flag, val, narg) {
    if (is.matrix(val)) {
        m <- t(val)
    } else {
        if (narg == 1) {
            ## Properly handle vectors of multiple config options
            ## (e.g. -oo, -co, -mo), which users are unlikely to pass
            ## in as 1-column matrices
            m <- matrix(val, nrow = 1)
        } else {
            ## For flags taking more than one argument, assume a
            ## vector input means the argument isn't being repeated
            m <- matrix(val, ncol = 1)
        }
    }
    as.vector(rbind(flag, m))
}
## ## Example of a repeated flag for with several arguments for each flag:
## ## gdal_translate() can take 2D ground control points given by 4 args each
## process_repeated_flag("-gcp", 1:4, 4)
## ## 3D ground control points take 5 args each; in R, specify using matrix
## process_repeated_flag("-gcp", matrix(1:20, ncol=5, byrow=TRUE), 4)

## Workhorse function
process_args <- function(args, formalsTable) {
    ft <- formalsTable
    opts <- lapply(names(args), function(nm) {
        flag       <- ft[ft$arg == nm, "flag"]
        narg       <- ft[ft$arg == nm, "narg"]
        repeatable <- ft[ft$arg == nm, "repeatable"]
        val <- args[[nm]]
        if (repeatable) {
            ## Handle repeatable flags
            process_repeated_flag(flag, val = val, narg = narg)
        } else {
            ## Handle non-repeatable flags
            if (narg == 0) {
                ## Handle Boolean on/off flags
                if (val) flag else NULL
            } else {
                ## Handle flags that expect their own arguments
                c(flag, val)
            }
        }
    })
    opts <- c(character(0), unlist(opts))
    ## Remove any "" from opts vector
    opts <- Filter(nchar, opts)
    opts
}
