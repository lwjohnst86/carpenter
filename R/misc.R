#' @export
print.table_outline <- function(table.data, ...) {
    print(dplyr::tbl_df(table.data$data))
    invisible(table.data)
}

#' @export
print.table_draft <- function(table.data, ...) {
    class(table.data$table) <- 'data.frame'
    print(table.data$table)
    invisible(table.data)

}

#' Ready for pixiedusting.
#'
#' A thin wrapper around the \code{\link[pixiedust]{dust}} function.
#' @param table.data The \code{table_draft} object.
#'
#' @return A \code{\link[pixiedust]{dust}}'ed table ready to be used by
#'   \code{\link{pixiedust}}.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
use_pixiedust <- function(table.data) {
    UseMethod('use_pixiedust', table.data)
}

#' @export
use_pixiedust.table_draft <- function(table.data) {
    if (requireNamespace('pixiedust')) {
        pixiedust::dust(table.data$table)
    } else {
        warning("Can't use pixiedust as it is not installed. Please install it.")
    }
}

#' Ready for refining using pander.
#'
#' A thin wrapper to prepare the output for use in the \code{\link[pander]{pander}} function.
#' @param table.data The \code{table_draft} object.
#'
#' @return A table ready to be used by \code{\link[pander]{pander}}.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
use_pander <- function(table.data) {
    UseMethod('use_pander', table.data)
}

#' @export
use_pander.table_draft <- function(table.data) {
    as.data.frame(table.data$table)
}
