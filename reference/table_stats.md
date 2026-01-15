# Common summary statistics to use in [`add_rows()`](http://lwjohnst86.github.io/carpenter/reference/add_rows.md).

Common summary statistics to use in
[`add_rows()`](http://lwjohnst86.github.io/carpenter/reference/add_rows.md).

## Usage

``` r
stat_median(x, digits = 1)

stat_iqr(x, digits = 1)

stat_medianIQR(x, digits = 1)

stat_mean(x, digits = 1)

stat_stddev(x, digits = 1)

stat_meanSD(x, digits = 1)

stat_nPct(x, digits = 0)
```

## Arguments

- x:

  Numeric vector to use to calculate the statistic

- digits:

  Number of digits to use

## Value

Create a single character string with the summary statistic

## See also

[`carpenter()`](http://lwjohnst86.github.io/carpenter/reference/carpenter.md)
for a list of all functions, examples, and accessing the introduction
tutorial vignette.
