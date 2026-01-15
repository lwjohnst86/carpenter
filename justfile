@_default:
    just --list --unsorted

# Run all recipes
run-all: clean install-deps document check-spelling check-url-cran check-url-lychee lint style test build-website check-local-cran install-package

# List all TODO items in the repository
list-todos:
  grep -R -n \
    --exclude-dir=.quarto \
    --exclude-dir=docs \
    --exclude=justfile \
    --exclude=*.csl \
    "TODO" *

# Clean up auto-generated files
clean:
  #!/usr/bin/env Rscript
  devtools::clean_vignettes()
  pkgdown::clean_site()

# Install package dependencies
install-deps:
  #!/usr/bin/env Rscript
  pak::pak(
    dependencies = c(
      "all"
    ),
    ask = FALSE
  )

# Run document generators
document:
  #!/usr/bin/env Rscript
  devtools::document()

# Update wordlist
update-wordlist:
  #!/usr/bin/env Rscript
  spelling::update_wordlist()

# Run the package tests
test:
  #!/usr/bin/env Rscript
  devtools::test()

# Check the spelling
check-spelling:
  #!/usr/bin/env Rscript
  devtools::spell_check()

# Check URLs based on CRAN requirements
check-url-cran:
  #!/usr/bin/env Rscript
  urlchecker::url_check()

# Install https://github.com/lycheeverse/lychee#installation
# Check URLs using lychee tool
check-url-lychee:
  lychee .

# Style all R code in the package
style:
  air format .

# From https://jarl.etiennebacher.com/#installation
# Lint R code for any potential issues
lint:
  jarl check .

# Build the pkgdown website
build-website:
  #!/usr/bin/env Rscript
  pkgdown::build_site()

# Run local CRAN checks
check-local-cran:
  #!/usr/bin/env Rscript
  devtools::check(error_on = "note")

# Install the package itself
install-package:
  #!/usr/bin/env Rscript
  devtools::install()

# Preview website locally
preview-website:
  #!/usr/bin/env Rscript
  pkgdown::preview_site()
