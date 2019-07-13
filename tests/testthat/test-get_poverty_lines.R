context("test-get_poverty_lines")

test_that("test canasta", {
  canasta <- get_poverty_lines(update=TRUE)
  expect_equal(canasta$cba[1], 1367.11)
  expect_equal(round(canasta$ice[1],2), 2.27)
  expect_equal(canasta$cbt[1], 3103.34)
})

