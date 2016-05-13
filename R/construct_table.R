#' Construct the final table.
#'
#' Output can be to common formats such as rmarkdown, html, etc, based on the
#' \code{style} argument of the \code{\link[pander]{pander}} function.
#' @param table.data The \code{table_draft} object.
#' @param ... Additional parameters for \code{link{pander}} options
#'
#' @return Creates a \code{\link{pander}} created table.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
construct_table <- function(table.data, ...) {
    UseMethod('construct_table', table.data)
}

#' @rdname construct_table
#' @export
construct_table.table_draft <-
    function(table.data, caption = NULL, style = 'rmarkdown',
             alignment = function(x)
                 ifelse(sapply(x, is.numeric), 'center', 'left'),
             split = Inf, missing = '') {
        pander::panderOptions('table.alignment.default',
                              alignment)
        table.data$table %>%
            pander::pander(
                caption = caption, style = style,
                split.table = split, missing = missing
            )
    }

