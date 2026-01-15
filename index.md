# carpenter: Making Tables

The main goal of carpenter to simplify making those pesky
descriptive/basic characteristic tables often used in biomedical journal
articles. It was designed to work well within the tidyverse ecosystem,
e.g. relying on using pipes to chain functions together or having
multiple, dedicated functions to use (rather than a monolithic one with
lots of arguments).

## Installation

This package is on CRAN, so install using:

``` r
install.packages('carpenter')
```

For the developmental version, install from GitHub:

``` r
# install.packages("pak")
pak::pak('lwjohnst86/carpenter')
```

## Example usage

Here is an example workflow for making tables:

``` r
library(carpenter)
outline_table(iris, 'Species') %>% 
    add_rows('Sepal.Length', stat_meanSD) %>%
    add_rows('Petal.Length', stat_meanSD) %>%
    add_rows('Sepal.Width', stat_medianIQR) %>% 
    build_table() 
```

| Variables    |    setosa     |  versicolor   |   virginica   |
|:-------------|:-------------:|:-------------:|:-------------:|
| Sepal.Length |   5.0 (0.4)   |   5.9 (0.5)   |   6.6 (0.6)   |
| Petal.Length |   1.5 (0.2)   |   4.3 (0.5)   |   5.6 (0.6)   |
| Sepal.Width  | 3.4 (3.2-3.7) | 2.8 (2.5-3.0) | 3.0 (2.8-3.2) |

For a more detailed view of how to use carpenter, see
[`?carpenter`](http://lwjohnst86.github.io/carpenter/reference/carpenter.md)
or
[`vignette('carpenter')`](http://lwjohnst86.github.io/carpenter/articles/carpenter.md).
Or view the vignette directly
[here](https://htmlpreview.github.io/?https://github.com/lwjohnst86/carpenter/blob/master/vignettes/carpenter.html)

## Resources

There are several packages out there that help with making tables. Most
of them work to output and customize the tables into a given format, for
instance markdown or html, but assume the data is in the form you
already want to present it in. So they don’t help with getting the data
into the form of a table (in the context of descriptive/basic
characteristic tables often seen in biomedical research). Even still,
they are very useful to look over and learn about!

- [`pander`](https://rapporter.github.io/pander/)
- [`pixiedust`](https://cran.r-project.org/package=pixiedust)
- [`stargazer`](https://cran.r-project.org/package=stargazer)
- [`htmlTable`](https://cran.r-project.org/package=htmlTable)
- [`tableone`](https://cran.r-project.org/package=tableone)

## Acknowledgements

[Zhila
Semnani](https://www.linkedin.com/in/zhila-semnani-azad-phd-40507150/)
made the (I think) cool logo! :D
