# Changelog

## carpenter 0.2.3

### Fixes

- Replaced deprecated dplyr functions with their modern equivalents.
- Fix CRAN note about `LazyData`.

## carpenter 0.2.2

CRAN release: 2019-02-05

### Bug fixes

- Fixed issue where factor ordering changes
  ([\#11](https://github.com/lwjohnst86/carpenter/issues/11);
  [\#13](https://github.com/lwjohnst86/carpenter/issues/13))
- Fix errors due to update to dplyr (explicitly define
  [`dplyr::n()`](https://dplyr.tidyverse.org/reference/context.html))
  and switch over to using `_at` dplyr versions.

### General additions

- Add code coverage and appveyor.

## carpenter 0.2.1

CRAN release: 2017-05-22

### Bug fixes

- Fixed ERRORS in CRAN results due to changes and version update in
  dplyr
- Fixed ERRORS in pander and table output due to changes in dplyr

### Misc

- Added `tableone` package to resources in vignette

## carpenter 0.2.0

CRAN release: 2016-07-29

- Major rewrite of the underlying code for carpenter, making it more
  rigorous and sturdy (compared to the previous version).
- Added test suites to confirm the package does what it should.
- Wrote a introduction vignette.
- Added resources for other packages that make tables.
- Added a `NEWS.md` file to track changes to the package.
