test_that("EAHU descarga", {
  skip_if_offline()
  skip_on_cran()
  df <- get_eahu(year = 2011, type = "individual", vars = "all")
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(111950, 153))
})

test_that("selec variables", {
  skip_if_offline()
  skip_on_cran()
  df <- get_eahu(year = 2011, type = "individual", vars = c("CODUSU", "NRO_HOGAR", "CH04", "PONDERA"))
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(111950, 4))
})

test_that("fuera de 2010/2014", {
  skip_if_offline()
  skip_on_cran()
  expect_warning(df <- get_eahu(year = 2009, type = "individual"))
})

test_that("errores", {
  expect_warning(df <- get_eahu(year = 2011, type = "individu"))
})
