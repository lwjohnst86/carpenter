#' Build common tables for your research needs!
#'
#' @name carpenter
#' @seealso [add_rows()] to add rows to the table,
#'   [renaming()] for renaming of columns and rows,
#'   [build_table()], [table_stats()] for a list of built-in
#'   summary statistics. For a more detailed walkthrough of carpenter, see the
#'   introduction vignette using `vignette('carpenter')`.
#' @importFrom tibble tibble
#'
#' @examples
#'
#' library(magrittr)
#' outline_table(iris, 'Species') %>%
#'  add_rows(c('Sepal.Length', 'Petal.Length'), stat_meanSD) %>%
#'  add_rows('Sepal.Width', stat_medianIQR) %>%
#'  renaming('rows', function(x) gsub('Sepal\\.', 'Sepal ', x)) %>%
#'  renaming('header', c('Measures', 'Setosa', 'Versicolor', 'Virginica')) %>%
#'  build_table(caption = 'A caption for the table')
#'
NULL
