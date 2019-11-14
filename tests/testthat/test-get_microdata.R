context("test-get_microdata")

test_that("EPH punutal", {
  skip_if_offline()
  skip_on_cran()
  df <- get_microdata(year = 1996, wave = 1, vars = c('CODUSU','AGLOMERADO','IPCF'))
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(113209,3))
})


test_that("EPH continua", {
  skip_if_offline()
  skip_on_cran()
  expect_warning(df <- get_microdata(year = 2015, trimester = 2,vars =  c('PONDERA','ESTADO','CAT_OCUP')))
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(60028,3))
})


test_that("Sin data", {
  skip_if_offline()
  expect_warning(df <- get_microdata(year = 2015, trimester = 4))
  expect_length(df,0)
  })

test_that("muchas bases", {
  skip_if_offline()
  skip_on_cran()
  df <- get_microdata(year = 2017:2018, trimester = 4,type = c('individual','hogar'))
  expect_equal(dim(df$microdata[[1]]), c(58181,177))
  expect_equal(dim(df$microdata[[2]]), c(57418,177))
  expect_equal(dim(df$microdata[[3]]), c(18793,88))
  expect_equal(dim(df$microdata[[4]]), c(18616,88))
})
