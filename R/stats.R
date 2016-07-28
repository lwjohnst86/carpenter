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
    x <- stats::median(x, na.rm = TRUE)
    x <- round(x, digits)
    x <- format(x, nsmall = digits)
    gsub('^NaN \\(NA\\)$', '', x)
}

#' @rdname table_stats
#' @export
stat_iqr <- function(x, digits = 1) {
    # fq = first quartile
    fq <- stats::quantile(x, 0.25, na.rm = TRUE)
    fq <- round(fq, digits)
    fq <- format(fq, nsmall = digits)
    # tq = third quartile
    tq <- stats::quantile(x, 0.75, na.rm = TRUE)
    tq <- round(tq, digits)
    tq <- format(tq, nsmall = digits)
    gsub('^NaN \\(NA\\)$', '', paste0(fq, '-', tq))
}

#' @rdname table_stats
#' @export
stat_medianIQR <- function(x, digits = 1) {
    med <- carpenter::stat_median(x, digits)
    iqr <- carpenter::stat_iqr(x, digits)
    gsub('^NaN \\(NA\\)$', '', paste0(med, ' (', iqr, ')'))
}

#' @rdname table_stats
#' @export
stat_mean <- function(x, digits = 1) {
    x <- mean(x, na.rm = TRUE)
    x <- round(x, digits)
    x <- format(x, nsmall = digits)
    gsub('^NaN \\(NA\\)$', '', x)
}

#' @rdname table_stats
#' @export
stat_stddev <- function(x, digits = 1) {
    x <- stats::sd(x, na.rm = TRUE)
    x <- round(x, digits)
    x <- format(x, nsmall = digits)
    gsub('^NaN \\(NA\\)$', '', x)
}

#' @rdname table_stats
#' @export
stat_meanSD <- function(x, digits = 1) {
    ave <- carpenter::stat_mean(x, digits)
    std <- carpenter::stat_stddev(x, digits)
    gsub('^NaN \\(NA\\)$', '',paste0(ave, ' (', std, ')'))
}

#' @rdname table_stats
#' @export
stat_nPct <- function(x, digits = 0) {
    pct <- round((100*x) / sum(x), digits)
    gsub('^NaN \\(NA\\)$', '', paste0(x, ' (', pct, '%)'))
}
