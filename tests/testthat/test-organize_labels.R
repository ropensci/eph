context("test-organize_labels")

test_that("multiplication works", {
  df <- get_microdata(year = 2018, trimester = 1,type='hogar')
  df <- organize_labels(df, type='hogar')
  regiones <- expss::val_lab(df$REGION)
  expect_equal(!is.null(regiones),TRUE)
})
