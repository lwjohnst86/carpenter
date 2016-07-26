context("Sketching outline")

test_that("outline_table assertion works", {
    draft <- outline_table(iris, 'Species')
    expect_true('draft' %in% class(draft))

    expect_error(outline_table(iris, 'notexist'))
    expect_error(outline_table(mean, 'Species'))
    expect_error(outline_table(iris, 'Sepal.Length'))
})

test_that("add_rows assertion works", {
    ds <- dplyr::mutate(mtcars, gear = as.factor(gear),
                        vs = as.factor(vs))
    draft <- outline_table(ds, 'vs')

    expect_error(add_rows(draft))
    expect_error(add_rows('mpg'))
    expect_error(add_rows(draft, 'notexist'))
    expect_error(add_rows(draft, 'mpg', stat = iris))
    expect_error(add_rows(draft, c('mpg', 'gear'), stat = stat_mean))

    draft <- add_rows(draft, 'disp', stat = stat_mean)
    expect_error(add_rows(draft, 'Class', stat = stat_mean))
})

test_that("renaming assertion works", {
    ds <- dplyr::mutate(mtcars, gear = as.factor(gear),
                        vs = as.factor(vs))
    draft <- outline_table(ds, 'vs')
    draft <- add_rows(draft, 'disp', stat = stat_mean)

    expect_error(renaming(draft, 'notexist'))
    expect_error(renaming(draft, 'rows', 'wrong_parameter'))
})
