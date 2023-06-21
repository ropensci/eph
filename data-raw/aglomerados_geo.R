library(sf)
library(tidyverse)

aglos <- sf::st_read('../data/eph/georef/aglomerados_eph.json')
# entidades <- sf::st_read('../data/eph/georef/entidades_eph.json')
# radios <- sf::st_read('../data/eph/georef/radios_eph.json')


centroides_aglomerados <-  aglos %>%
  filter(!st_is_empty(geometry)) %>%
  group_by(eph_codagl) %>%
  summarise(AGLOMERADO = as.integer(paste(unique(eph_codagl))),
            nombre_aglomerado = unique(eph_aglome)[1]) %>%
  st_centroid() %>%
  select(AGLOMERADO, nombre_aglomerado, geometry)

# ggplot() +
#   geom_sf(data = centroides_aglomerados )


centroides_aglomerados <- centroides_aglomerados %>% st_transform('+proj=longlat +datum=WGS84')

#remove geometry because of incompatibility with dplyr 1.0
centroides_aglomerados <- centroides_aglomerados %>%
  bind_cols(
sf::st_coordinates(centroides_aglomerados) %>%
  as_tibble() %>%
  rename(lon=X, lat=Y)) %>%
  as_tibble() %>%
  select(-geometry)

usethis::use_data(centroides_aglomerados, overwrite = TRUE)


data_frame_roxygen <- function(obj) {
  if (inherits(obj, c("data.frame", "tibble"))) {
    cl <- vapply(obj, FUN = typeof, FUN.VALUE = character(1))

    items <- paste0(sprintf("#'   \\item{\\code{%s}}{%s ---DESCRIPTION---}", names(cl), cl))


    items <- paste0(items, collapse = "\n")


    header <- c(
      title = paste0("#' @title ", deparse(substitute(obj))),
      description = "#' @description ---COLUMN DESCRIPTION---",
      format = sprintf("#' @format A data frame with %s rows and %s variables:", nrow(obj), length(cl))
    )

    ret <- sprintf(
      "%s\n%s\n%s",
      paste(header, collapse = "\n"),
      sprintf("#' \\describe{\n%s \n#'}", items),
      sprintf('\n"%s"', deparse(substitute(obj)))
    )
  }
  ret
}


data_frame_roxygen(centroides_aglomerados)
