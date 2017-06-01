context("Building the final table")

## TODO: Rename context


test_that("build_table outputs correct information", {
    ds <- data.frame(
        Groups = factor(rep(c('yes', 'no'), each = 4)),
        Var1 = c(1, 1, 1, 1, 2, 2, 2, 2),
        Var2 = c(1, 1, 2, 2, 1, 1, 2, 2),
        Var3 = factor(rep(c('no', 'yes'), 2, each = 2)),
        Var4 = factor(rep(c('no', 'yes', "huh", "def"), 1, each = 2),
                      levels = c("yes", "no", "def", "huh"))
    )

    draft <- outline_table(ds, 'Groups')
    draft <- add_rows(draft, 'Var1', stat_meanSD)
    draft <- add_rows(draft, 'Var2', stat_medianIQR)
    draft <- add_rows(draft, 'Var3', stat_nPct)
    draft <- add_rows(draft, 'Var4', stat_nPct)
    draft <- renaming(draft, 'rows', function(x)
        gsub('Var', 'V', x))
    draft <- renaming(draft, 'header', c('Rows', 'Group1', 'Group2'))
    output_table <- build_table(draft, finish = FALSE)

    expected_table <- dplyr::data_frame(
        Rows = c('V1', 'V2', 'V3', '- no', '- yes', "V4", "- yes", "- no", "- def", "- huh"),
        Group1 = c('2.0 (0.0)', '1.5 (1.0-2.0)', NA, '2 (50%)', '2 (50%)', NA, NA, NA, "2 (50%)", "2 (50%)"),
        Group2 = c('1.0 (0.0)', '1.5 (1.0-2.0)', NA, '2 (50%)', '2 (50%)', NA, "2 (50%)", "2 (50%)", NA, NA)
    )

    expect_identical(output_table, expected_table)
})

test_that("build_table outputs in order as determined in data", {
    ds <- dplyr::data_frame(
        Group = as.factor(mtcars$vs),
        Z = factor(
            rep(c(0, 1), 16),
            levels = c(1, 0),
            labels = c("yes", "no")
        ),
        A = factor(mtcars$gear, levels = c(5, 4, 3))
    )

    draft <- outline_table(ds, 'Group')
    draft <- add_rows(draft, 'Z', stat_nPct)
    draft <- add_rows(draft, 'A', stat_nPct)
    output_table <- build_table(draft, finish = FALSE)

    expected_table <- dplyr::data_frame(
        Variables = c('Z', "- yes", "- no", "A", '- 5', '- 4', '- 3'),
        `0` = c(NA, '7 (38.9%)', '11 (61.1%)', NA, "4 (22.2%)", "2 (11.1%)", "12 (66.7%)"),
        `1` = c(NA, "9 (64.3%)", "5 (35.7%)", NA, "1 (7.1%)", "10 (71.4%)", "3 (21.4%)")
    )

    expect_identical(output_table, expected_table)
})
