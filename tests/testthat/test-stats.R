context("Checking accuracy of stats")

test_that("stats are correct", {
    expect_identical(stat_mean(1:10), '5.5')
    expect_identical(stat_stddev(c(1,1)), '0.0')
    expect_identical(stat_meanSD(c(1,1)), '1.0 (0.0)')

    expect_identical(stat_median(1:10), '5.5')
    expect_identical(stat_iqr(c(1,1,2,2)), '1.0-2.0')
    expect_identical(stat_medianIQR(c(1,1,2,2)), '1.5 (1.0-2.0)')

    expect_identical(stat_nPct(1:2), c('1 (33%)', '2 (67%)'))
})
