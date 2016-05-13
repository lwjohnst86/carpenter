#' Add rows to the table with summary statistics.
#'
#' @param table.data Output from the \code{outline_table} object.
#' @param row.vars The variables that you want added to the table. Must be from
#'   the list supplied to \code{outline_table}.
#' @param summary.stat The summary statistic or any other function. A list of
#'   built functions can be found in \code{\link{table_stats}}.
#' @param digits
#'
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
#' @return Outputs a \code{table_draft} object with the variables added to the
#'   rows.
#' @export
#'
add_rows <-
    function(table.data, row.vars, summary.stat = function(x)
        mean(x), digits = 2) {
        UseMethod('add_rows', table.data)
    }

#' @export
add_rows.table_outline <- function(table.data, row.vars = NULL,
                                   summary.stat = NULL, digits = 1) {
    if (is.null(row.vars))
        row.vars <- table.data$contents.vars

    if (.all_numeric(table.data$data[, row.vars])) {
        if (is.null(summary.stat))
            summary.stat <- stat_mean

        table.data$table <- table.data %>%
            .numeric_wrangle(row.vars = row.vars, summary.stat = summary.stat,
                             digits = digits)
    }

    if (.all_factor_char(table.data$data[, row.vars])) {
        if (is.null(summary.stat))
            summary.stat <- stat_nPct

        table.data$table <- table.data %>%
            .factor_wrangle(row.vars = row.vars, summary.stat = summary.stat,
                            digits = digits)
    }

    class(table.data) <- 'table_draft'
    return(table.data)
}



#' @export
add_rows.table_draft <- function(table.data, row.vars = NULL,
                                 summary.stat = NULL, digits = 1) {
    if (is.null(row.vars))
        row.vars <- names(table.data$contents.vars)

    if (.all_numeric(table.data$data[, row.vars])) {
        if (is.null(summary.stat))
            summary.stat <- stat_mean

        table.data$table <-
            dplyr::bind_rows(
                table.data$table,
                table.data %>%
                    .numeric_wrangle(
                        row.vars = row.vars, summary.stat = summary.stat,
                        digits = digits
                    )
            )
    }

    if (.all_factor_char(table.data$data[, row.vars])) {
        if (is.null(summary.stat))
            summary.stat <- stat_nPct

        table.data$table <-
            dplyr::bind_rows(
                table.data$table,
                table.data %>%
                    .factor_wrangle(
                        row.vars = row.vars, summary.stat = summary.stat,
                        digits = digits
                    )
            )
    }

    if (!is.null(table.data$rename.rows)) {
        rows.var <- names(table.data$table[1])
        table.data$table <- table.data$table %>%
            dplyr::rename_('renaming' = rows.var) %>%
            dplyr::mutate(renaming = table.data$rename.rows(renaming))
        names(table.data$table)[1] <- rows.var
    }

    class(table.data) <- 'table_draft'
    return(table.data)
}

.numeric_wrangle <-
    function(table.data, row.vars = names(table.data$contents.vars),
             summary.stat, digits = 1) {
        column.names <- names(table.data$header.var)
        table.data$data %>%
            tidyr::gather_('Row', 'Values', row.vars) %>%
            dplyr::group_by_('Row', column.names) %>%
            dplyr::summarize(val = summary.stat(Values, digits)) %>%
            tidyr::spread_(column.names, 'val') %>%
            dplyr::mutate_each_(funs(as.character), names(.))
    }

.factor_wrangle <-
    function(table.data, row.vars = table.data$contents.vars,
             summary.stat = stat_nPct, digits = 0) {
        column.names <- names(table.data$header.var)
        ds <- table.data$data
        ds <- tidyr::gather_(ds, 'Row', 'Values', row.vars)
        ds <- dplyr::group_by_(ds, column.names, 'Row', 'Values')
        ds <- na.omit(dplyr::tally(ds))
        ds <- dplyr::group_by_(ds, column.names, 'Row')
        ds <- dplyr::mutate(ds, n = summary.stat(n, digits))
        ds <- tidyr::spread_(ds, column.names, 'n')
        ds <- dplyr::ungroup(ds)
        ds <- dplyr::mutate(ds, id = 1:n())

        ds <- dplyr::full_join(
            ds,
            ds %>%
                dplyr::group_by_('Row') %>%
                dplyr::tally() %>%
                dplyr::mutate(id = cumsum(n) - n + 0.5) %>%
                dplyr::select(-n),
            by = c('Row', 'id')
        )
        ds <- dplyr::arrange(ds, id)
        factor_rows <- ds %>%
            dplyr::mutate(
                Values = ifelse(is.na(Values), '', Values),
                Row = ifelse(Values != '', '- ', as.character(Row)),
                Row = paste0(Row, Values)
            ) %>%
            dplyr::select(-Values,-id)

        return(factor_rows)
    }
