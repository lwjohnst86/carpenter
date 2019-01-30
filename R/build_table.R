#' Build the final table.
#'
#' Output can be to common formats such as rmarkdown, html, etc, based on the
#' `style` argument of the [pander::pander()] function.
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
#' @return Creates a [pander::pander()] created table.
#' @export
#' @seealso [carpenter()] for a list of all functions, examples, and
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
                dplyr::mutate_at("Variables", dplyr::funs(replacing))
        }

        if (!is.null(sketch$rename_header)) {
            replacing <- sketch$rename_header
            if (is.function(replacing))
                replacing <- replacing(names(draft_table))
            draft_table <- stats::setNames(draft_table, replacing)
        }

        if (finish) {
            draft_table <- as.data.frame(draft_table)
            pander::pander(
                draft_table,
                caption = caption,
                style = style,
                split.table = split,
                missing = missing,
                justify = c('left', rep(alignment, times = length(draft_table) - 1))
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
        dplyr::select_at(data, c(header, rows)) %>%
            tidyr::gather('Variables', 'Values', rows) %>%
            dplyr::group_by_at(c('Variables', header)) %>%
            dplyr::summarize_(val = lazyeval::interp('stat(Values, digits = digits)',
                                                     digits = digits, stat = stat)) %>%
            dplyr::ungroup() %>%
            tidyr::spread(header, 'val') %>%
            dplyr::full_join(row_id, by = 'Variables') %>%
            dplyr::arrange_at('id') %>%
            dplyr::select_at(dplyr::vars(-'id')) %>%
            dplyr::mutate_all(dplyr::funs(as.character))
    }

make_factor_row <-
    function(data, header, rows, stat, digits) {
        factor_levels <- unlist(lapply(data[rows], levels))
        variable_names_pattern <- paste0("(", paste(rows, collapse = "|"), ").*")
        variable_names <- gsub(variable_names_pattern, "\\1", names(factor_levels))

        factor_levels_df <-
            dplyr::data_frame(Variables = variable_names,
                              Values = factor_levels) %>%
            dplyr::group_by_at("Variables") %>%
            dplyr::mutate(ValOrder = 1:dplyr::n())

        variable_names_order <- dplyr::data_frame(Variables = rows,
                                                  VarOrder = 1:length(rows))

        factor_summary <- data %>%
            dplyr::mutate_at(rows, as.numeric) %>%
            tidyr::gather('Variables', 'ValOrder', rows) %>%
            dplyr::group_by_at(c(header, 'Variables', 'ValOrder')) %>%
            dplyr::tally() %>%
            stats::na.omit() %>%
            dplyr::ungroup() %>%
            dplyr::full_join(factor_levels_df, by = c('Variables', "ValOrder"))

        factor_summary <- factor_summary %>%
            dplyr::group_by_at(c(header, 'Variables')) %>%
            dplyr::mutate_(n = lazyeval::interp('stat(n, digits)',
                                                stat = stat, digits = digits)) %>%
            tidyr::spread(header, 'n') %>%
            dplyr::ungroup() %>%
            dplyr::full_join(variable_names_order, by = "Variables") %>%
            dplyr::arrange_at(c("VarOrder", "ValOrder"))

        factor_pretable <- dplyr::full_join(
            factor_summary,
            dplyr::data_frame(VarOrder = 1:length(rows) - 0.5,
                              Variables = rows),
            by = c('Variables', 'VarOrder')
        )

        dplyr::arrange_at(factor_pretable, c("VarOrder", "ValOrder")) %>%
            dplyr::mutate_(
                Values = "ifelse(is.na(Values), '', as.character(Values))",
                Variables = "ifelse(Values != '', '- ', as.character(Variables))",
                Variables = "paste0(Variables, Values)"
            ) %>%
            dplyr::select_at(dplyr::vars(-"Values", -"ValOrder", -"VarOrder"))
    }
