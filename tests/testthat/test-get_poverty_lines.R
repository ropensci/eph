context("test-get_poverty_lines")

test_that("test canasta", {
  canasta <- get_poverty_lines()
  expect_equal(canasta$CBA[1], 1514.53)
  expect_equal(canasta$ICE[1], 2.42)
  expect_equal(canasta$CBT[1], 3663.66)
})

