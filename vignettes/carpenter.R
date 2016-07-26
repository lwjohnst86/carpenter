## ------------------------------------------------------------------------
library(magrittr)

outline_table(iris, 'Species') %>% 
    add_rows('Sepal.Length', stat_meanSD) %>%
    add_rows('Petal.Length', stat_meanSD) %>%
    add_rows('Sepal.Width', stat_medianIQR) %>% 
    renaming('header', function(x) gsub('setosa', 'Setosa', x)) %>% 
    renaming('rows', function(x) gsub('Sepal', 'Seeeepal', x)) %>% 
    build_table() 

mtcars %>% 
    dplyr::mutate(
        gear = as.factor(gear),
        vs = as.factor(vs)
    ) %>% 
    outline_table('vs') %>% 
    add_rows('gear', stat_nPct) %>% 
    add_rows('mpg', stat_meanSD) %>%
    add_rows('drat', stat_medianIQR) %>% 
    build_table()

