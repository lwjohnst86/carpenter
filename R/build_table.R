#' Build the final table.
#'
#' Output can be to common formats such as rmarkdown, html, etc, based on the
#' \code{style} argument of the \code{\link[pander]{pander}} function.
#'
#' @param data The draft table object.
#' @param caption Table caption.
#' @param style What output style (rmarkdown, grid, simple, etc) should the
#'   table be.
#' @param split When should the table split when it is too wide? (Inf means never).
#' @param missing How to deal with missing values in the table (removed by default).
#' @param alignment Table column alignment.
#' @param finish Generate the final table in markdown formatted form.
#'
#' @return Creates a \code{\link[pander]{pander}} created table.
#' @export
#' @seealso \code{\link{carpenter}} for a list of all functions, examples, and
#'   accessing the introduction tutorial vignette.
build_table <-
    function(data,
             caption = NULL,
             style = 'rmarkdown',
             split = Inf,
             missing = '',
             alignment = 'center',
             finish = TRUE) {

        is_draft(data)
        sketch <- attributes(data)$outline

        draft_table <-
            dplyr::bind_rows(lapply(names(sketch$rows), function(x, s = sketch) {
                func <- eval(parse(text = x))
                sketch_rows <- s$rows[[x]]
                type <- sketch_rows$type
                switch(type,
                       numeric = {
                           row_create <- make_numeric_row
                       },
                       factor = {
                           row_create <- make_factor_row
                       })
                row_create(
                    data = data,
                    header = s$header,
                    rows = sketch_rows$vars,
                    stat = func,
                    digits = sketch_rows$digits
                )
            }))

        if (!is.null(sketch$rename_rows)) {
            replacing <- sketch$rename_rows
            draft_table <- draft_table %>%
                dplyr::mutate_each_(dplyr::funs(replacing), 'Variables')
        }

        if (!is.null(sketch$rename_header)) {
            replacing <- sketch$rename_header
            if (is.function(replacing))
                replacing <- replacing(names(draft_table))
            draft_table <- stats::setNames(draft_table, replacing)
        }

        if (finish) {
            pander::pander(
                draft_table,
                caption = caption,
                style = style,
                split.table = split,
                missing = missing,
                justify = c('left', rep(alignment, times = length(draft_table)-1))
            )
        } else {
            draft_table
        }
    }

# Wrangling functions -----------------------------------------------------

make_numeric_row <-
    function(data, header, rows, stat, digits) {
        row_id <- data.frame(
            id = 1:length(rows),
            Variables = rows,
            stringsAsFactors = FALSE
        )
        dplyr::select_(data, .dots = c(header, rows)) %>%
            tidyr::gather_('Variables', 'Values', rows) %>%
            dplyr::group_by_('Variables', header) %>%
            dplyr::summarize_(val = lazyeval::interp('stat(Values, digits = digits)',
                                                     digits = digits, stat = stat)) %>%
            tidyr::spread_(header, 'val') %>%
            dplyr::full_join(row_id, by = 'Variables') %>%
            dplyr::arrange_('id') %>%
            dplyr::select_('-id') %>%
            dplyr::mutate_each_(dplyr::funs(as.character), dplyr::everything()) %>%
            dplyr::ungroup()
    }

make_factor_row <-
    function(data, header, rows, stat, digits) {
        data <- tidyr::gather_(data, 'Variables', 'Values', rows) %>%
            dplyr::group_by_(header, 'Variables', 'Values') %>%
            dplyr::tally() %>%
            stats::na.omit()

        data <- dplyr::group_by_(data, header, 'Variables') %>%
            dplyr::mutate_(n = lazyeval::interp('stat(n, digits)',
                                                stat = stat, digits = digits)) %>%
            tidyr::spread_(header, 'n') %>%
            dplyr::ungroup() %>%
            dplyr::mutate_(id = lazyeval::interp('1:n()'))

        data <- dplyr::full_join(
            data,
            data %>%
                dplyr::group_by_('Variables') %>%
                dplyr::tally() %>%
                dplyr::mutate_(id = 'cumsum(n) - n + 0.5') %>%
                dplyr::select_('-n'),
            by = c('Variables', 'id')
        )
        dplyr::arrange_(data, 'id') %>%
            dplyr::mutate_(
                Values = "ifelse(is.na(Values), '', Values)",
                Variables = "ifelse(Values != '', '- ', as.character(Variables))",
                Variables = "paste0(Variables, Values)"
            ) %>%
            dplyr::select_('-Values', '-id')
    }
