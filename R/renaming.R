#' Renaming row and header variables.
#'
#' @param data The `table_draft` object.
#' @param type Whether to rename the row column or the headers.
#' @param replace If type is 'row', needs to be a function (anonymous or otherwise)
#'   using the [base::gsub()] function to substitute patterns, words,
#'   characters, or symbols, etc. If type is 'header', needs to be a string of
#'   equal length as the header to replace the header variables.
#'
#' @return Adds to the table outline to rename the rows and/or header variables
#'   in the final table.
#' @export
#' @seealso [carpenter()] for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
renaming <- function(data, type = c('rows', 'header'), replace) {
    is_draft(data)
    type <- match.arg(type)
    switch(type,
           rows = {
               if (!is.function(replace))
                   stop('Please use a function for renaming the row variables.', call. = FALSE)
               data <- outline(data = data, rename_rows = replace)
           },
           header = {
               if (!is.character(replace) & !is.function(replace))
                   stop('Please use a character string of the replacement ',
                        'headers or a search and replace function (e.g. gsub) for renaming.',
                        call. = FALSE)
               data <- outline(data = data, rename_header = replace)
           })
    return(data)
}
