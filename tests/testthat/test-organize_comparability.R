context("test-organize_comparability")

# --- Bases sinteticas ----------------------------------------------------------

# Base hogar nueva metodologia (2025 T1), 7 hogares.
# Disenada para cubrir todas las ramas de las reglas de reconstruccion:
#   V11 (2 sub-componentes, dominancia 1 > 2 > 0 > 9)
#   V5  (3 sub-componentes, reglas especiales)
hogar_nueva <- function() {
  data.frame(
    CODUSU    = paste0("H", 1:7),
    NRO_HOGAR = 1L,
    ANO4      = 2025L,
    TRIMESTRE = 1L,
    # V11: (1,9)->1  (2,0)->2  (0,9)->0  (9,9)->9  (2,2)->2  (1,1)->1  (0,0)->0
    V11_01 = c(1, 2, 0, 9, 2, 1, 0),
    V11_02 = c(9, 0, 9, 9, 2, 1, 0),
    # V5: (0,1,9)->1  (0,9,9)->9  (0,0,9)->0  (2,0,9)->2  (0,0,0)->0
    #     (2,2,2)->2  (1,0,0)->1
    V5_01 = c(0, 0, 0, 2, 0, 2, 1),
    V5_02 = c(1, 9, 0, 0, 0, 2, 0),
    V5_03 = c(9, 9, 9, 9, 0, 2, 0),
    # V21 y V22 completos para que tambien se reconstruyan
    V21_01 = c(0, 0, 0, 0, 0, 0, 0),
    V21_02 = c(0, 0, 0, 0, 0, 0, 0),
    V21_03 = c(0, 0, 0, 0, 0, 0, 0),
    V22_01 = c(2, 2, 2, 2, 2, 2, 2),
    V22_02 = c(0, 0, 0, 0, 0, 0, 0),
    V22_03 = c(0, 0, 0, 0, 0, 0, 0),
    # Control de jubilaciones (V2 sigue existiendo en la base nueva):
    # el hogar 2 contesto No (2) -> controla la imputacion -7 de V2_M
    V2 = c(1, 2, 1, 9, 1, 1, 1)
  )
}

# Base individual apareada (1 persona por hogar; el individuo I9 no tiene
# hogar en la base hogar -> control NA).
indiv_nueva <- function() {
  data.frame(
    CODUSU     = c(paste0("H", 1:7), "H9"),
    NRO_HOGAR  = 1L,
    COMPONENTE = 1L,
    ANO4       = 2025L,
    TRIMESTRE  = 1L,
    # V2_M, cubre las 6 prioridades + control:
    #   H1 (1000,-7,0)   -> 1000  (suma de no negativos)
    #   H2 (-7,-7,-7) c2 -> -7    (control hogar = No)
    #   H3 (0,0,0)       -> 0     (todos 0)
    #   H4 (-7,-9,-7) c9 -> -9    (incertidumbre)
    #   H5 (-7,-8,-7) c1 -> -8    (ingreso potencial)
    #   H6 (-7,-7,-7) c1 -> -7    (no aplicabilidad)
    #   H7 (0,-7,0)  c1  -> 0     (default)
    #   H9 (-7,-7,-7) cNA-> -7    (sin hogar: salta el control, todos -7)
    V2_01_M = c(1000, -7, 0, -7, -7, -7, 0, -7),
    V2_02_M = c(-7, -7, 0, -9, -8, -7, -7, -7),
    V2_03_M = c(0, -7, 0, -7, -7, -7, 0, -7),
    # PP11L1/PP11L2 invertidas: PP11L2 registra 1/2/3 y PP11L1 no tiene 3
    PP11L1 = c(1, 2, 1, 2, 1, 2, 1, 2),
    PP11L2 = c(1, 2, 3, 1, 2, 3, 1, 2)
  )
}

# --- Base hogar ----------------------------------------------------------------

test_that("reconstruye los agregados si/no de la base hogar", {
  h <- suppressMessages(organize_comparability(hogar_nueva()))
  expect_equal(h$V11, c(1L, 2L, 0L, 9L, 2L, 1L, 0L))
  expect_equal(h$V5,  c(1L, 9L, 0L, 2L, 0L, 2L, 1L))
  expect_true(all(c("V21", "V22") %in% names(h)))
})

test_that("no pisa un agregado que ya existe", {
  h <- hogar_nueva()
  h$V11 <- 5L
  res <- suppressMessages(organize_comparability(h))
  expect_equal(res$V11, rep(5L, 7))
})

test_that("omite el agregado si faltan sub-componentes", {
  h <- hogar_nueva()
  h$V5_03 <- NULL
  res <- suppressMessages(organize_comparability(h))
  expect_false("V5" %in% names(res))
  expect_true("V11" %in% names(res))
})

# --- Base individual -----------------------------------------------------------

test_that("reconstruye los montos con control del hogar", {
  i <- suppressMessages(
    organize_comparability(indiv_nueva(), base_hogar = hogar_nueva())
  )
  expect_equal(i$V2_M, c(1000, -7, 0, -9, -8, -7, 0, -7))
})

test_that("corrige la inversion PP11L1/PP11L2", {
  i0 <- indiv_nueva()
  i <- suppressMessages(
    organize_comparability(i0, base_hogar = hogar_nueva())
  )
  expect_equal(i$PP11L1, i0$PP11L2)
  expect_equal(i$PP11L2, i0$PP11L1)
})

test_that("no intercambia PP11L1/PP11L2 si no hay condicion de error", {
  i0 <- indiv_nueva()
  i0$PP11L1 <- c(1, 2, 3, 1, 2, 3, 1, 2)  # PP11L1 si registra el nivel 3
  i <- suppressMessages(
    organize_comparability(i0, base_hogar = hogar_nueva())
  )
  expect_equal(i$PP11L1, i0$PP11L1)
})

test_that("exige base_hogar para la base individual", {
  expect_error(
    suppressMessages(organize_comparability(indiv_nueva())),
    "base_hogar"
  )
})

test_that("rechaza base_hogar con claves duplicadas", {
  h <- rbind(hogar_nueva(), hogar_nueva()[1, ])
  expect_error(
    suppressMessages(organize_comparability(indiv_nueva(), base_hogar = h)),
    "duplicadas"
  )
})

test_that("rechaza periodos distintos entre base y base_hogar", {
  h <- hogar_nueva()
  h$TRIMESTRE <- 2L
  expect_error(
    suppressMessages(organize_comparability(indiv_nueva(), base_hogar = h)),
    "periodo"
  )
})

# --- Era y validaciones ---------------------------------------------------------

test_that("devuelve sin cambios las bases legacy (< 2024 T4)", {
  h <- hogar_nueva()
  h$ANO4 <- 2023L
  expect_message(res <- organize_comparability(h), "no requiere puente")
  expect_identical(res, h)
})

test_that("rechaza bases con mezcla de eras", {
  h <- hogar_nueva()
  h$ANO4 <- c(2023L, rep(2025L, 6))
  expect_error(suppressMessages(organize_comparability(h)), "combina periodos")
})

test_that("valida el tipo del argumento base", {
  expect_error(organize_comparability("no_soy_un_data_frame"), "data.frame")
})
