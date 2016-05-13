#' Common summary statistics to use in \code{\link{add_rows}}.
#'
#' @name table_stats
#' @param x Numeric vector to use to calculate the statistic
#' @param digits Number of digits to use
#'
#' @return Create a single character string with the summary statistic
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
#'
NULL

#' @rdname table_stats
#' @export
stat_median <- function(x, digits = 1) {
    round(median(x, na.rm = TRUE), digits) %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_iqr <- function(x, digits = 1) {
    paste0(round(quantile(x, 0.25, na.rm = TRUE), digits),
           '-', round(quantile(x, 0.75, na.rm = TRUE), digits)) %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_medianIQR <- function(x, digits = 1) {
    paste0(stat_median(x, digits), ' (', stat_iqr(x, digits), ')') %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_mean <- function(x, digits = 1) {
    format(round(mean(x, na.rm = TRUE), digits), nsmall = digits) %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_stddev <- function(x, digits = 1) {
    format(round(sd(x, na.rm = TRUE), digits), nsmall = digits) %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_meanSD <- function(x, digits = 1) {
    paste0(stat_mean(x, digits), ' (', stat_stddev(x, digits), ')') %>%
        .drop_nan_na()
}

#' @rdname table_stats
#' @export
stat_nPct <- function(x, digits = 0) {
    paste0(x, ' (', round((100*x) / sum(x), digits), '%)') %>%
        .drop_nan_na()
}

.drop_nan_na <- function(x) {
    gsub('^NaN \\(NA\\)$', '', x)
}
