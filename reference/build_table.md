# Build the final table.

Output can be to common formats such as rmarkdown, html, etc, based on
the `style` argument of the
[`pander::pander()`](https://rdrr.io/pkg/pander/man/pander.html)
function.

## Usage

``` r
build_table(
  data,
  caption = NULL,
  style = "rmarkdown",
  split = Inf,
  missing = "",
  alignment = "center",
  finish = TRUE
)
```

## Arguments

- data:

  The draft table object.

- caption:

  Table caption.

- style:

  What output style (rmarkdown, grid, simple, etc) should the table be.

- split:

  When should the table split when it is too wide? (Inf means never).

- missing:

  How to deal with missing values in the table (removed by default).

- alignment:

  Table column alignment.

- finish:

  Generate the final table in markdown formatted form.

## Value

Creates a
[`pander::pander()`](https://rdrr.io/pkg/pander/man/pander.html) created
table.

## See also

[`carpenter()`](http://lwjohnst86.github.io/carpenter/reference/carpenter.md)
for a list of all functions, examples, and accessing the introduction
tutorial vignette.
