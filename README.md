
<!-- README.md is generated from README.Rmd. Please edit that file -->
carpenter: Making Tables
========================

[![Travis-CI Build Status](https://travis-ci.org/lwjohnst86/carpenter.svg?branch=master)](https://travis-ci.org/lwjohnst86/carpenter)

The main goal of carpenter to help make those pesky descriptive/basic characteristic tables often used in biomedical journal articles easier to make and put together. Right now, this package is focused on those types of tables, but I plan to expand to other similarly used table types.

Installation
============

It's up on GitHub right now, so to install:

    devtools::install_github('lwjohnst86/carpenter')

Example usage
=============

Here is an example workflow for making tables:

``` r
library(carpenter)
library(magrittr)
outline_table(iris, 'Species') %>% 
    add_rows('Sepal.Length', stat_meanSD) %>%
    add_rows('Petal.Length', stat_meanSD) %>%
    add_rows('Sepal.Width', stat_medianIQR) %>% 
    build_table() 
```

| Variables    |     setosa    |   versicolor  |   virginica   |
|:-------------|:-------------:|:-------------:|:-------------:|
| Sepal.Length |   5.0 (0.4)   |   5.9 (0.5)   |   6.6 (0.6)   |
| Petal.Length |   1.5 (0.2)   |   4.3 (0.5)   |   5.6 (0.6)   |
| Sepal.Width  | 3.4 (3.2-3.7) | 2.8 (2.5-3.0) | 3.0 (2.8-3.2) |

For a more detailed view of how to use carpenter, see `?carpenter` or `vignette('carpenter')`. Or view the vignette directly [here](https://htmlpreview.github.io/?https://github.com/lwjohnst86/carpenter/blob/master/vignettes/carpenter.html)

Resources
=========

There are several packages out there that help with making tables. They work to output and customize the tables into a given format, for instance markdown or html, but assume the data is in the form you already want to present it in. So they don't help with getting the data into the format as a table (in the context of descriptive/basic characteristic tables often seen in biomedical research). Even still, they are very useful to look over and learn about!

-   [`pander`](http://rapporter.github.io/pander/)
-   [`pixiedust`](https://cran.r-project.org/package=pixiedust)
-   [`stargazer`](https://cran.r-project.org/package=stargazer) ([tutorial](http://jakeruss.com/cheatsheets/stargazer.html))
-   [`htmlTable`](https://cran.r-project.org/package=htmlTable)
