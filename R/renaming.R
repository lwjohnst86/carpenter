#' Renaming row and column variables.
#'
#' @param table.data The \code{table_draft} object.
#' @param ... Renamed column headers. See
#'   \code{\link[pixiedust]{sprinkle_colnames}} for more help using this
#'   argument.
#' @param pattern Generally a function (anonymous or otherwise) using the
#'   \code{\link[base]{gsub}} function to substitute patterns, words,
#'   characters, or symbols, etc.
#'
#' @return Outputs a \code{table_draft} object with columns or rows renamed,
#'   which will also keep the renaming even if more rows are added via
#'   \code{\link{add_rows}}.
#' @name table_renaming
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
NULL

#' @rdname table_renaming
#' @export
rename_rows <- function(table.data, pattern = NULL) {
    UseMethod('rename_rows', table.data)
}

#' @rdname table_renaming
#' @export
rename_columns <- function(table.data, ...) {
    UseMethod('rename_columns', table.data)
}

#' @rdname table_renaming
#' @export
rename_rows.table_outline <-
    function(table.data, pattern = NULL) {
        stop('Please use this after using add_rows')

#         if (!is.null(replace) & !is.null(pattern))
#             stop('Please provide either the replace arg or the pattern arg, not both.')
#
#         # Incorporate later
# #         if (!is.null(replace)) {
# #             if (length(replace) != length(contents.vars))
# #                 stop('The number in the replace list is not the same as the number of rows.')
# #             table.data$rename.rows <- replace
# #         } else
#
#         if (!is.null(pattern))
#             table.data$rename.rows <- pattern
#
#         class(table.data) <- 'table_outline'
#         return(table.data)
    }

#' @rdname table_renaming
#' @export
rename_rows.table_draft <- function(table.data, pattern.fun = NULL) {
    # Add a replace arg later
    if (!is.null(table.data$rename.rows)) {
        stop('Renaming of rows has already been done.')
    }

    table.data$rename.rows <- pattern.fun
    rows.var <- names(table.data$table[1])
    if (!is.null(pattern.fun)) {
        table.data$table <- table.data$table %>%
            dplyr::rename_('renaming' = rows.var) %>%
            dplyr::mutate(renaming = table.data$rename.rows(renaming))
        names(table.data$table)[1] <- rows.var
    }

    class(table.data) <- 'table_draft'
    return(table.data)
}

#' @rdname table_renaming
#' @export
rename_columns.table_outline <-
    function(table.data, ...) {
        stop('Please use this after using add_rows')
    }

#' @rdname table_renaming
#' @export
rename_columns.table_draft <- function(table.data, ...){
    table.data$table <- pixiedust::dust(table.data$table) %>%
        pixiedust::sprinkle_colnames(...) %>%
        as.data.frame()


    class(table.data) <- 'table_draft'
    return(table.data)
}
