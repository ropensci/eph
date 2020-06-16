context("test-get_poverty_lines")

test_that("test GBA", {
  skip_if_offline()
  canasta <- get_poverty_lines()
  expect_equal(canasta$CBA[1], 1514.53)
  expect_equal(canasta$ICE[1], 2.42)
  expect_equal(canasta$CBT[1], 3663.66)
})

test_that("test regiones", {
  skip_if_offline()
  canasta <- get_poverty_lines(regional = TRUE)
  expect_equal(canasta$CBA[1], 1224.64)
  expect_equal(unique(canasta$region), c( "Cuyo" , "GBA", "Noreste", "Noroeste", "Pampeana", "Patagonia"))
})
