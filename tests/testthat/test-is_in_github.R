httptest::without_internet({
  test_that("Requests happen", {
    skip_on_cran()
    httptest::expect_GET(httr::GET("https://api.github.com/repos/holatam/data/git/trees/master?recursive=1"))
  })
})

httptest::with_mock_dir("is_in_github",{
  test_that("Requests work", {
    skip_on_cran()
    testthat::expect_type(is_in_github(), "logical")
  })
})
