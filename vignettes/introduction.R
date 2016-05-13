## ---- fig.show='hold'----------------------------------------------------
plot(1:10)
plot(10:1)

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(mtcars, 10))

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Possible datasets to use:
#  # head(iris)
#  # head(airquality)
#  # head(longley)
#  # head(swiss)
#  
#  library(dplyr)
#  library(tidyr)
#  ds <- data.frame(state.x77, Region = state.region) %>%
#      mutate(Dangerous = ifelse(Murder > 10, 'Yes', 'No'),
#             Poor = ifelse(Income < 4000, 'Yes', 'No'))
#  ds[c(1, 5, 15, 25, 36), c('Dangerous')] <- NA
#  outline_table(ds, c('Population', 'Life.Exp', 'Dangerous', 'Region'), c('Poor')) %>%
#      add_rows(c('Dangerous', 'Region')) %>%
#      add_rows(c('Population', 'Life.Exp')) %>%
#      rename_rows(function(x) gsub('North', 'Nord', x)) %>%
#      rename_columns('Rows', 'Yes', 'NOPE!!') %>%
#      construct_table()
#  

