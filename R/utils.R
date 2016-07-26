#' @export
print.draft <- function(x, ...) {
    draft_table <- build_table(x, finish = FALSE)
    print(draft_table)
    invisible(x)
}

is_df <- function(data) {
    if (!is.data.frame(data))
        stop('Please supply a dataframe in the `data` arg.', call. = FALSE)
}

is_factor <- function(data, x) {
    if (!is.factor(data[[x]]))
        stop('Please use a factor variable for the header.', call. = FALSE)
}

is_draft <- function(data) {
    if (!'draft' %in% class(data))
        stop('Please use an objected created from `outline_table`.', call. = FALSE)
}

vars_type <- function(data, vars) {
    type <- sapply(data[vars], class)
    type <- gsub('integer', 'numeric', type)
    type <- gsub('character', 'factor', type)
    type <- unique(type)
    if (length(type) > 1) {
        stop('Please do not mix numeric and character/factor variables',
             ' in the ', type, '.', call. = FALSE)
    } else if (length(type) == 1) {
        return(type)
    }
}

vars_exist <- function(data, vars) {
    vars.want <- vars
    vars.have <- names(data)
    index <- vars.want %in% vars.have
    if (!any(index)) {
        vars <-
            paste(vars.want[which(!vars.want %in% vars.have)], separate = ', ')
        stop('The variables ',
             vars,
             ' do not exist in the dataset.',
             call. = FALSE)
    }
}

