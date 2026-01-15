# Add rows to the table with summary statistics.

Add rows to the table with summary statistics.

## Usage

``` r
add_rows(data, row_vars, stat, digits = 1)
```

## Arguments

- data:

  Output from the `outline_table` object.

- row_vars:

  The variables that you want added to the table. Must be from
  `outline_table`.

- stat:

  The summary statistic or any other function. A list of built functions
  can be found in
  [`table_stats()`](http://lwjohnst86.github.io/carpenter/reference/table_stats.md).

- digits:

  What to round the value to.

## Value

Adds a row with summary statistics for a variable. Is a
[tibble](https://tibble.tidyverse.org/reference/tibble-package.html).

## See also

[`carpenter()`](http://lwjohnst86.github.io/carpenter/reference/carpenter.md)
for a list of all functions, examples, and accessing the introduction
tutorial vignette. See
[`table_stats()`](http://lwjohnst86.github.io/carpenter/reference/table_stats.md)
for a list of carpenter builtin statistics.
