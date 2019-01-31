
<!-- README.md is generated from README.Rmd. Please edit that file -->

# carpenter: Making Tables <img src="man/figures/logo.png" align="right" height=140/>

[![Travis-CI Build
Status](https://travis-ci.org/lwjohnst86/carpenter.svg?branch=master)](https://travis-ci.org/lwjohnst86/carpenter)
[![CRAN Status
Badge](http://www.r-pkg.org/badges/version/carpenter)](https://cran.r-project.org/package=carpenter)
[![Coverage
status](https://codecov.io/gh/lwjohnst86/carpenter/branch/master/graph/badge.svg)](https://codecov.io/github/lwjohnst86/carpenter?branch=master)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/lwjohnst86/carpenter?branch=master&svg=true)](https://ci.appveyor.com/project/lwjohnst86/carpenter)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Downloads](https://cranlogs.r-pkg.org/badges/carpenter)](https://www.r-pkg.org/pkg/carpenter)

The main goal of carpenter to simplify making those pesky
descriptive/basic characteristic tables often used in biomedical journal
articles. It was designed to work well within the tidyverse ecosystem,
e.g. relying on using pipes to chain functions together or having
multiple, dedicated functions to use (rather than a monolithic one with
lots of arguments).

# Installation

This package is on CRAN, so install using:

``` r
install.packages('carpenter')
```

For the developmental version, install from GitHub:

``` r
# install.packages("remotes")
remotes::install_github('lwjohnst86/carpenter')
```

# Example usage

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
| :----------- | :-----------: | :-----------: | :-----------: |
| Sepal.Length |   5.0 (0.4)   |   5.9 (0.5)   |   6.6 (0.6)   |
| Petal.Length |   1.5 (0.2)   |   4.3 (0.5)   |   5.6 (0.6)   |
| Sepal.Width  | 3.4 (3.2-3.7) | 2.8 (2.5-3.0) | 3.0 (2.8-3.2) |

For a more detailed view of how to use carpenter, see `?carpenter` or
`vignette('carpenter')`. Or view the vignette directly
[here](https://htmlpreview.github.io/?https://github.com/lwjohnst86/carpenter/blob/master/vignettes/carpenter.html)

# Resources

There are several packages out there that help with making tables. Most
of them work to output and customize the tables into a given format, for
instance markdown or html, but assume the data is in the form you
already want to present it in. So they don’t help with getting the data
into the form of a table (in the context of descriptive/basic
characteristic tables often seen in biomedical research). Even still,
they are very useful to look over and learn about\!

  - [`pander`](http://rapporter.github.io/pander/)
  - [`pixiedust`](https://cran.r-project.org/package=pixiedust)
  - [`stargazer`](https://cran.r-project.org/package=stargazer)
  - [`htmlTable`](https://cran.r-project.org/package=htmlTable)
  - [`tableone`](https://cran.r-project.org/package=tableone)
