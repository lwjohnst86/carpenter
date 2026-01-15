# Renaming row and header variables.

Renaming row and header variables.

## Usage

``` r
renaming(data, type = c("rows", "header"), replace)
```

## Arguments

- data:

  The `table_draft` object.

- type:

  Whether to rename the row column or the headers.

- replace:

  If type is 'row', needs to be a function (anonymous or otherwise)
  using the [`base::gsub()`](https://rdrr.io/r/base/grep.html) function
  to substitute patterns, words, characters, or symbols, etc. If type is
  'header', needs to be a string of equal length as the header to
  replace the header variables.

## Value

Adds to the table outline to rename the rows and/or header variables in
the final table.

## See also

[`carpenter()`](http://lwjohnst86.github.io/carpenter/reference/carpenter.md)
for a list of all functions, examples, and accessing the introduction
tutorial vignette.
