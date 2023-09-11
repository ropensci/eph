## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(eph)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

## -----------------------------------------------------------------------------
ind_3_18 <- get_microdata(
  year = 2018,
  trimester = 3,
  type = "individual"
)

## -----------------------------------------------------------------------------
ind_3_18 <- organize_labels(
  df = ind_3_18,
  type = "individual"
)

## -----------------------------------------------------------------------------
hog_3_18 <- get_microdata(
  year = 2018,
  trimester = 3,
  type = "hogar"
) %>%
  organize_labels(.,
    type = "hogar"
  )

## -----------------------------------------------------------------------------
calculate_tabulates(
  base = ind_3_18,
  x = "NIVEL_ED",
  y = "CH04",
  weights = "PONDERA",
  add.totals = "row",
  add.percentage = "col"
)

## -----------------------------------------------------------------------------
calculate_tabulates(
  base = ind_3_18,
  x = "NIVEL_ED",
  y = "CH04",
  add.totals = "row",
  add.percentage = "col"
)

## -----------------------------------------------------------------------------
### Armo vector con el nombre de las variables de interés incluyendo
# -variables necesarias para hacer el panel
# -variables que nos interesan en nuestro análisis
variables <- c(
  "CODUSU", "NRO_HOGAR", "COMPONENTE", "ANO4",
  "TRIMESTRE", "CH04", "CH06", 
  "ESTADO", "PONDERA"
) 

### Descargo la base individual para el 2018_t1
base_2018t1 <- get_microdata(
  year = 2018, trimester = 1, type = "individual",
  vars = variables
)

### Descargo la base individual para el 2018_t2
base_2018t2 <- get_microdata(
  year = 2018, trimester = 2, type = "individual",
  vars = variables
)

### Armo el panel
pool <- organize_panels(
  bases = list(base_2018t1, base_2018t2),
  variables = c("ESTADO", "PONDERA"),
  window = "trimestral"
)

## -----------------------------------------------------------------------------
pool

## ----message=FALSE, warning=FALSE---------------------------------------------
pool %>%
  organize_labels(.) %>%
  calculate_tabulates(
    x = "ESTADO",
    y = "ESTADO_t1",
    weights = "PONDERA",
    add.percentage = "row"
  )

## ----message=FALSE, warning=FALSE---------------------------------------------
df <- get_microdata(
  year = 2017:2019,
  trimester = 1:4,
  type = "individual",
  vars = c("ANO4", "TRIMESTRE", "PONDERA", "ESTADO", "CAT_OCUP")
)

df %>%
  sample_n(5)

## -----------------------------------------------------------------------------
df <- df %>%
  group_by(ANO4, TRIMESTRE) %>%
  summarise(indicador = sum(PONDERA[CAT_OCUP == 3 & ESTADO == 1], na.rm = T) / sum(PONDERA[ESTADO == 1], na.rm = T))

df

## -----------------------------------------------------------------------------
lineas <- get_poverty_lines()
lineas

## ---- fig.width=7, fig.height=5-----------------------------------------------
lineas %>%
  select(-ICE) %>%
  pivot_longer(cols = c("CBA", "CBT"), names_to = "canasta", values_to = "valor") %>%
  ggplot() +
  geom_line(aes(x = periodo, y = valor, col = canasta))

## -----------------------------------------------------------------------------
canastas_reg_example

## -----------------------------------------------------------------------------
adulto_equivalente %>% head()

## ----warning=FALSE------------------------------------------------------------
bases <- bind_rows(toybase_individual_2016_03, toybase_individual_2016_04)
base_pobreza <- calculate_poverty(
  base = bases,
  basket = canastas_reg_example,
  print_summary = TRUE
)

## -----------------------------------------------------------------------------
base_pobreza %>%
  select(CODUSU, ITF, region, adequi_hogar, CBA_hogar, CBT_hogar, situacion) %>%
  sample_n(10)

