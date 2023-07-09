httptest::without_internet({
test_that("Requests happen", {
  httptest::expect_GET(  httr::GET("https://api.github.com/repos/holatam/data/git/trees/master?recursive=1") )
})
})


