#' Add rows to the table with summary statistics.
#'
#' @param data Output from the \code{outline_table} object.
#' @param row_vars The variables that you want added to the table. Must be from
#'   \code{outline_table}.
#' @param stat The summary statistic or any other function. A list of
#'   built functions can be found in \code{\link{table_stats}}.
#' @param digits What to round the value to.
#'
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette. See \code{\link{table_stats}}
#'   for a list of carpenter builtin statistics.
#'
#' @return Adds a row with summary statistics for a variable.
#' @export
#'
add_rows <- function(data, row_vars, stat, digits = 1) {
    is_draft(data)

    if (missing(row_vars))
        stop('Please indicate which variables to use as the rows.')
    vars_exist(data, row_vars)

    if (missing(stat))
        stat <- stat_mean
    if (!is.function(stat))
        stop('Please use a function for the `stat` arg.', call. = FALSE)

    stat <- deparse(substitute(stat))
    type <- vars_type(data, row_vars)
    rows <- list()

    current_stats <- attr(data, 'outline')$rows
    if (!is.null(current_stats)) {
        if (stat %in% names(current_stats)) {
            if (type != current_stats[[stat]]$type)
                stop('Should this statistic `', stat, '` be used with this ',
                     type, ' data type?', call. = FALSE)
            row_vars <- c(current_stats[[stat]]$vars, row_vars)
        }
    }

    rows[stat] <- list(list(
        vars = row_vars,
        stat = stat,
        digits = digits,
        type = type
    ))

    data <- outline(data = data, rows = rows)
    return(data)
}
