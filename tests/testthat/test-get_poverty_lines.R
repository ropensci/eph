context("test-get_poverty_lines")

test_that("test canasta", {
  canasta <- get_poverty_lines(update=FALSE)
  expect_equal(canasta$cba[1], 1367.11)
})

