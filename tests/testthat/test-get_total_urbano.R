test_that("total urbano descarga", {
  skip_if_offline()
  skip_on_cran()
  df <- get_total_urbano(year = 2016, type = "individual", vars = "all")
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(95782, 152))
})

test_that("selec variables", {
  skip_if_offline()
  skip_on_cran()
  df <- get_total_urbano(year = 2016, type = "individual", vars = c("CODUSU", "CH04", "CH06", "PONDERA"))
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(95782, 4))
})

test_that("antes de 2016", {
  skip_if_offline()
  skip_on_cran()
  expect_warning(df <- get_total_urbano(year = 2009, type = "individual"))
})

test_that("errores", {
  expect_warning(df <- get_total_urbano(year = 2016, type = "individu"))
})
