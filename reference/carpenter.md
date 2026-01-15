# Build common tables for your research needs!

Build common tables for your research needs!

## See also

[`add_rows()`](http://lwjohnst86.github.io/carpenter/reference/add_rows.md)
to add rows to the table,
[`renaming()`](http://lwjohnst86.github.io/carpenter/reference/renaming.md)
for renaming of columns and rows,
[`build_table()`](http://lwjohnst86.github.io/carpenter/reference/build_table.md),
[`table_stats()`](http://lwjohnst86.github.io/carpenter/reference/table_stats.md)
for a list of built-in summary statistics. For a more detailed
walkthrough of carpenter, see the introduction vignette using
[`vignette('carpenter')`](http://lwjohnst86.github.io/carpenter/articles/carpenter.md).

## Examples

``` r
library(magrittr)
outline_table(iris, 'Species') %>%
 add_rows(c('Sepal.Length', 'Petal.Length'), stat_meanSD) %>%
 add_rows('Sepal.Width', stat_medianIQR) %>%
 renaming('rows', function(x) gsub('Sepal\\.', 'Sepal ', x)) %>%
 renaming('header', c('Measures', 'Setosa', 'Versicolor', 'Virginica')) %>%
 build_table(caption = 'A caption for the table')
#> 
#> 
#> | Measures     |    Setosa     |  Versicolor   |   Virginica   |
#> |:-------------|:-------------:|:-------------:|:-------------:|
#> | Sepal Length |   5.0 (0.4)   |   5.9 (0.5)   |   6.6 (0.6)   |
#> | Petal.Length |   1.5 (0.2)   |   4.3 (0.5)   |   5.6 (0.6)   |
#> | Sepal Width  | 3.4 (3.2-3.7) | 2.8 (2.5-3.0) | 3.0 (2.8-3.2) |
#> 
#> Table: A caption for the table
#> 
```
