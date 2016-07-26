context("Building the final table")

## TODO: Rename context


test_that("build_table outputs correct information", {
    ds <- data.frame(
        Groups = rep(c('yes', 'no'), each = 4),
        Var1 = c(1, 1, 1, 1, 2, 2, 2, 2),
        Var2 = c(1, 1, 2, 2, 1, 1, 2, 2),
        Var3 = rep(c('no', 'yes'), 2, each = 2)
    )

    draft <- outline_table(ds, 'Groups')
    draft <- add_rows(draft, 'Var1', stat_meanSD)
    draft <- add_rows(draft, 'Var2', stat_medianIQR)
    draft <- add_rows(draft, 'Var3', stat_nPct)
    draft <- renaming(draft, 'rows', function(x)
        gsub('Var', 'V', x))
    draft <- renaming(draft, 'header', c('Rows', 'Group1', 'Group2'))
    output_table <- build_table(draft, finish = FALSE)

    expected_table <- data.frame(
        Rows = c('V1', 'V2', 'V3', '- no', '- yes'),
        Group1 = c('2.0 (0.0)', '1.5 (1.0-2.0)', NA, '2 (50%)', '2 (50%)'),
        Group2 = c('1.0 (0.0)', '1.5 (1.0-2.0)', NA, '2 (50%)', '2 (50%)'),
        stringsAsFactors = FALSE
    )

    expect_identical(output_table, dplyr::tbl_df(expected_table))
})
