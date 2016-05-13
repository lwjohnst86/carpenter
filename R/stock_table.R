
stock_table <- function(data, analysis.type = c('gee')) {
    stock <- switch(analysis.type,
                    gee = table_gee(data))
}

table_gee <- function(data) {

}
