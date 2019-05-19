context("test-organize_labels")

test_that("labels hogar", {
  df <- get_microdata(year = 2018, trimester = 1,type='hogar')
  df <- organize_labels(df, type='hogar')
  regiones <- expss::val_lab(df$REGION)
  expect_equal(!is.null(regiones),TRUE)
})


test_that("labels individual", {
  df <- get_microdata(year = 2018, trimester = 1,type='individual')
  df <- organize_labels(df, type='individual')
  regiones <- expss::val_lab(df$REGION)
  expect_equal(!is.null(regiones),TRUE)
})
