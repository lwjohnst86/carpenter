#' Make an outline of the table you want to create.
#'
#' @param data Dataset to use to create the table
#' @param table.rows Column or variable(s) that will make up the rows
#' @param table.columns Column or variable(s) that will make up the columns
#'
#' @return Dataframe ready for further carpentry work, like adding rows,
#'   rounding, summary statistics, renaming, etc.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
outline_table <- function(data, rows, columns) {
    UseMethod('outline_table', data)
}

#' @export
outline_table.data.frame <- function(data, rows, columns) {

    if (!all(rows %in% names(data)) |
        !all(columns %in% names(data))) {
        stop('One or more rows and columns selected for the table do not exist in the dataset.')
    }

    data <- dplyr::select_(data, .dots = c(columns, rows))
    rows <- dplyr::select_(data, .dots = rows)
    columns <- dplyr::select_(data, .dots = columns)

    if (.one_var_type_factor(columns)) {
        header.var <- columns
        contents.vars <- rows
    } else if (.one_var_type_factor(rows)) {
        header.var <- rows
        contents.vars <- columns
    }

    table.data <- structure(
        list(
            data = data,
            header.var = header.var,
            contents.vars = contents.vars
        ),
        class = 'table_outline'
    )

    return(table.data)
}

.all_same_data_types <- function(data) {
    length(unique(sapply(data, class))) == 1
}

.all_numeric <- function(data) all(sapply(data, is.numeric))

.all_factor_char <- function(data) {
    all(sapply(data, class) %in% c('factor', 'character'))
}

.one_var_type_factor <- function(data) {
    .all_factor_char(data) & length(data) == 1
}
