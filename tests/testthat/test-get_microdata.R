context("test-get_microdata")

test_that("EPH punutal", {
  df <- get_microdata(year = 1996, wave = 1)
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(113209,166))
})


test_that("EPH continua", {
  df <- get_microdata(year = 2018, trimester = 2)
  dimensiones <- dim(df)
  expect_equal(dimensiones, c(57835,177))
})


test_that("nuevas bases", {
  df_indiv <- get_microdata(year = 2018, trimester = 4,type = 'individual')
  expect_equal(dim(df_indiv), c(57418,177))
  df_hogar <- get_microdata(year = 2018, trimester = 4,type = 'hogar')
  expect_equal(dim(df_hogar), c(18616,88))

})

