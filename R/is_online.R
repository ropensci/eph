#' Check internet connection
#'
#' @param site An example domain
#'
#' @noRd
is_online <- function(site="http://example.com/") {
  tryCatch({
    readLines(site,n=1)
    TRUE
  },
  warning = function(w) invokeRestart("muffleWarning"),
  error = function(e) FALSE)
}
