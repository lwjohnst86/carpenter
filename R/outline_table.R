#' Make an outline of the table you want to create.
#'
#' @param data Dataset to use to create the table
#' @param header Column or variable(s) that will make up the rows
#'
#' @return Dataframe ready for further carpentry work, like adding rows,
#'   summary statistics, renaming, etc.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
outline_table <- function(data, header = NULL) {
    is_df(data)
    if (is.null(header)) {
        data <- data %>%
            dplyr::mutate(.Use_All = factor('all'))
        header <- '.Use_All'
    }
    is_factor(data, header)
    outline(data = data, header = header)
}

outline <- function(data, ...) {
    sketch <- list(...)
    if (!is.null(attr(data, 'outline')))
        sketch <- utils::modifyList(attr(data, 'outline'), sketch)

    if (!'draft' %in% class(data))
        class(data) <- c('draft', class(data))

    attr(data, 'outline') <- sketch
    return(data)
}
