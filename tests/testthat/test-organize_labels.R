context("test-organize_labels")

test_that("labels hogar", {
  df <- organize_labels(toybase_hogar_2016_04, type = "hogar")
  regiones <- expss::val_lab(df$REGION)
  expect_equal(!is.null(regiones), TRUE)
})


test_that("labels individual", {
  df <- organize_labels(toybase_individual_2016_03, type = "individual")
  regiones <- expss::val_lab(df$REGION)
  expect_equal(!is.null(regiones), TRUE)
})
