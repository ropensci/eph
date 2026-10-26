#' Puente de comparabilidad para las bases posteriores al rediseño 2024
#'
#' @description
#' A partir del cuarto trimestre de 2024, el rediseño del cuestionario de la
#' EPH eliminó de las bases usuarias varias variables agregadas y publicó en
#' su lugar sub-componentes por fuente. \code{organize_comparability()}
#' reconstruye las variables eliminadas con reglas determinísticas, para
#' mantener la comparabilidad con la serie histórica:
#'
#' \itemize{
#'   \item \strong{Base hogar} (estrategias del hogar, sí/no): \code{V5}
#'     (subsidio en dinero), \code{V11} (beca de estudio), \code{V21}
#'     (aguinaldo) y \code{V22} (retroactivos), a partir de sus
#'     sub-componentes (\code{V5_01}–\code{V5_03}, \code{V11_01}–\code{V11_02},
#'     \code{V21_01}–\code{V21_03}, \code{V22_01}–\code{V22_03}).
#'   \item \strong{Base individual} (montos de ingresos no laborales):
#'     \code{V2_M}, \code{V5_M}, \code{V11_M}, \code{V21_M} y \code{V22_M},
#'     a partir de sus sub-componentes y usando como control la variable de
#'     estrategia correspondiente de la base hogar (\code{V2}, \code{V5},
#'     \code{V11}, \code{V21}, \code{V22}), apareada por
#'     \code{CODUSU + NRO_HOGAR}.
#'   \item Además corrige, si detecta la condición de error, la inversión de
#'     las columnas \code{PP11L1} y \code{PP11L2} de la base individual (sus
#'     contenidos aparecen intercambiados en las bases publicadas).
#' }
#'
#' Las bases anteriores a 2024 trimestre 4 no requieren puente y se devuelven
#' sin cambios, con un aviso. Si una variable agregada ya existe en la base, o
#' faltan sus sub-componentes, su reconstrucción se omite con un aviso. Las
#' variables reconstruidas se agregan al final de la base; ningún valor
#' existente se modifica (única excepción: el intercambio PP11L1/PP11L2
#' cuando corresponde).
#'
#' @param base data.frame con una base usuaria de la EPH (hogar o individual)
#'   tal como la devuelve \code{\link{get_microdata}}. El tipo de base se
#'   detecta por la presencia de la columna \code{COMPONENTE}.
#' @param base_hogar data.frame con la base hogar del mismo trimestre.
#'   Obligatorio cuando \code{base} es una base individual (aporta las
#'   variables control de la reconstrucción; si sus propios agregados faltan,
#'   se reconstruyen internamente). Se ignora cuando \code{base} ya es una
#'   base de hogar.
#'
#' @return El mismo data.frame \code{base}, con las variables reconstruidas
#'   agregadas al final.
#'
#' @details
#' Las reglas de reconstrucción son las del pipeline EPH-Observatorio (UNR) y
#' están documentadas en la Parte A del Manual Metodológico citado en las
#' referencias. En síntesis: los agregados sí/no de la base hogar se obtienen
#' por dominancia de categorías (Sí > No > No corresponde > Ns/Nr, con reglas
#' especiales para tres sub-componentes), y los montos de la base individual
#' por suma de componentes no negativos, con imputación de los códigos
#' negativos de INDEC (-7/-8/-9) según un orden de prioridades que usa la
#' respuesta del hogar como control.
#'
#' @references
#' Tessmer, G. y Boggiano, B. (2026). \emph{From Breaks to Bridges: An
#' Architecture for Survey Redesigns That Expand Conceptual Scope}. SSRN
#' Working Paper 6597399.
#' \url{https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6597399}
#'
#' Observatorio Económico Social UNR. \emph{Manual Metodológico EPH –
#' Observatorio}, Parte A. RepHip UNR: \url{https://hdl.handle.net/2133/33253}.
#' Datasets: \doi{10.57715/UNR/BL85Z8}
#'
#' @examples
#' \dontrun{
#' hogares    <- get_microdata(year = 2025, period = 1, type = "hogar")
#' individuos <- get_microdata(year = 2025, period = 1, type = "individual")
#'
#' hogares    <- organize_comparability(base = hogares)
#' individuos <- organize_comparability(base = individuos,
#'                                      base_hogar = hogares)
#' }
#' @export
organize_comparability <- function(base, base_hogar = NULL) {
  if (!is.data.frame(base)) {
    cli::cli_abort(
      "El argumento {.arg base} requiere un data.frame (base usuaria de hogar o individual)."
    )
  }
  faltan <- setdiff(c("ANO4", "TRIMESTRE"), names(base))
  if (length(faltan) > 0) {
    cli::cli_abort(
      "La base no contiene la(s) columna(s) {.var {faltan}}, necesarias para determinar el periodo."
    )
  }

  # El puente aplica solo a las bases de la nueva metodologia (>= 2024 T4)
  if (comparability_era(base) == "legacy") {
    cli::cli_inform(
      "Base anterior al cambio metodologico (2024 T4): no requiere puente. Se devuelve sin cambios."
    )
    return(base)
  }

  es_individual <- "COMPONENTE" %in% names(base)

  # ---- Base HOGAR -----------------------------------------------------------
  if (!es_individual) {
    if (!is.null(base_hogar)) {
      cli::cli_warn("{.arg base_hogar} se ignora: {.arg base} ya es una base de hogar.")
    }
    return(comparability_hogar(base))
  }

  # ---- Base INDIVIDUAL ------------------------------------------------------
  if (is.null(base_hogar)) {
    cli::cli_abort(c(
      "Para una base individual se requiere {.arg base_hogar} (la base hogar del mismo trimestre).",
      "i" = "Las variables control de la reconstruccion (V2, V5, V11, V21, V22) provienen de la base de hogar."
    ))
  }
  if (!is.data.frame(base_hogar) || "COMPONENTE" %in% names(base_hogar)) {
    cli::cli_abort(
      "{.arg base_hogar} no parece una base de hogar: debe ser un data.frame sin la columna {.var COMPONENTE}."
    )
  }
  per_indiv <- comparability_periodos(base)
  per_hogar <- comparability_periodos(base_hogar)
  if (!identical(per_indiv, per_hogar)) {
    cli::cli_abort(
      "{.arg base} ({per_indiv}) y {.arg base_hogar} ({per_hogar}) no pertenecen al mismo periodo."
    )
  }

  # Correccion PP11L1/PP11L2: en las bases publicadas los contenidos de ambas
  # columnas aparecen intercambiados. Condicion de error: PP11L2 registra los
  # niveles 1/2/3 (que corresponden a la PP11L1 del cuestionario legacy) y
  # PP11L1 nunca registra el nivel 3.
  if (all(c("PP11L1", "PP11L2") %in% names(base))) {
    pp11l1 <- comparability_numerico(base$PP11L1)
    pp11l2 <- comparability_numerico(base$PP11L2)
    if (all(c(1, 2, 3) %in% unique(pp11l2)) && !(3 %in% pp11l1)) {
      cli::cli_inform(
        "Se detecto la inversion PP11L1/PP11L2: se intercambian ambas columnas."
      )
      base[, c("PP11L1", "PP11L2")] <- base[, c("PP11L2", "PP11L1")]
    }
  }

  # Variables control: si a la base hogar le faltan los agregados, se
  # reconstruyen aca (solo para uso interno; base_hogar no se devuelve).
  base_hogar <- comparability_hogar(base_hogar, avisar = FALSE)

  clave_hogar <- paste(base_hogar$CODUSU, base_hogar$NRO_HOGAR, sep = "\r")
  if (anyDuplicated(clave_hogar) > 0) {
    cli::cli_abort(
      "{.arg base_hogar} tiene combinaciones CODUSU + NRO_HOGAR duplicadas: no es posible asignar los controles del hogar."
    )
  }
  idx_hogar <- match(paste(base$CODUSU, base$NRO_HOGAR, sep = "\r"), clave_hogar)
  if (anyNA(idx_hogar)) {
    cli::cli_inform(
      "{sum(is.na(idx_hogar))} individuo(s) sin hogar correspondiente en {.arg base_hogar}: su control queda NA."
    )
  }

  relaciones <- list(
    V11_M = c("V11_01_M", "V11_02_M"),
    V2_M  = c("V2_01_M", "V2_02_M", "V2_03_M"),
    V21_M = c("V21_01_M", "V21_02_M", "V21_03_M"),
    V22_M = c("V22_01_M", "V22_02_M", "V22_03_M"),
    V5_M  = c("V5_01_M", "V5_02_M", "V5_03_M")
  )
  controles <- c(V11_M = "V11", V2_M = "V2", V21_M = "V21",
                 V22_M = "V22", V5_M = "V5")

  creadas <- character(0)
  for (dependiente in names(relaciones)) {
    independientes <- relaciones[[dependiente]]
    control <- controles[[dependiente]]
    if (!dependiente %in% names(base) &&
        all(independientes %in% names(base)) &&
        control %in% names(base_hogar)) {
      m <- do.call(cbind, lapply(base[independientes], comparability_numerico))
      ctrl <- comparability_numerico(base_hogar[[control]])[idx_hogar]
      base[[dependiente]] <- vapply(
        seq_len(nrow(base)),
        function(i) comparability_ingreso(m[i, ], ctrl[i]),
        numeric(1)
      )
      creadas <- c(creadas, dependiente)
    } else {
      cli::cli_inform(
        "Se omite {.var {dependiente}}: ya existe, faltan sus variables de origen o falta la variable control {.var {control}} en {.arg base_hogar}."
      )
    }
  }
  if (length(creadas) > 0) {
    cli::cli_inform("Variables reconstruidas en la base individual: {.var {creadas}}")
  }

  base
}


# ------------------------------------------------------------------------------
# Auxiliares internos
# ------------------------------------------------------------------------------

#' Reconstruye los agregados si/no de una base hogar
#' @noRd
comparability_hogar <- function(base, avisar = TRUE) {
  relaciones <- list(
    V11 = c("V11_01", "V11_02"),
    V21 = c("V21_01", "V21_02", "V21_03"),
    V22 = c("V22_01", "V22_02", "V22_03"),
    V5  = c("V5_01", "V5_02", "V5_03")
  )
  creadas <- character(0)
  for (dependiente in names(relaciones)) {
    independientes <- relaciones[[dependiente]]
    if (!dependiente %in% names(base) &&
        all(independientes %in% names(base))) {
      m <- do.call(cbind, lapply(base[independientes], comparability_numerico))
      base[[dependiente]] <- as.integer(vapply(
        seq_len(nrow(base)),
        function(i) comparability_dependiente(m[i, ]),
        numeric(1)
      ))
      creadas <- c(creadas, dependiente)
    } else if (avisar) {
      cli::cli_inform(
        "Se omite {.var {dependiente}}: ya existe o faltan sus variables de origen."
      )
    }
  }
  if (avisar && length(creadas) > 0) {
    cli::cli_inform("Variables reconstruidas en la base de hogar: {.var {creadas}}")
  }
  base
}

#' Agregado si/no a partir de los sub-componentes de una fila.
#' Codigos: 1 = Si, 2 = No, 0 = No corresponde, 9 = Ns/Nr.
#' Logica identica al pipeline EPH-Observatorio (02.check.R, seccion 3.1).
#' @noRd
comparability_dependiente <- function(vars) {
  # 2 sub-componentes: regla de dominancia transitiva 1 > 2 > 0 > 9
  if (length(vars) == 2) {
    dominancia <- factor(vars, levels = c(9, 0, 2, 1), ordered = TRUE)
    return(as.numeric(as.character(max(dominancia))))
  }
  # 3 sub-componentes: reglas especiales sobre la dominancia estricta
  if (length(vars) == 3) {
    # Prioridad 1: al menos un 1 (Si) -> 1
    if (any(vars == 1)) return(1)
    # Prioridad 2: solo hay 0 (No corresponde) y 9 (Ns/Nr)
    if (all(vars %in% c(0, 9))) {
      # dos o mas 9 -> 9; un solo 9 (o ninguno) -> 0
      if (sum(vars == 9) >= 2) return(9) else return(0)
    }
    # Prioridad 3 (default): 2 (No)
    return(2)
  }
  cli::cli_abort("La reconstruccion solo esta definida para 2 o 3 sub-componentes.")
}

#' Monto agregado a partir de los sub-componentes de una fila y el valor de
#' la variable control del hogar. Codigos negativos de INDEC: -7 = no
#' corresponde, -8 = no tuvo ingresos ese mes, -9 = Ns/Nr.
#' Logica identica al pipeline EPH-Observatorio (02.check.R, seccion 3.2).
#' @noRd
comparability_ingreso <- function(valores, valor_control) {
  # Prioridad absoluta: hay ingresos positivos -> suma de los no negativos
  if (any(valores > 0, na.rm = TRUE)) {
    return(sum(valores[valores >= 0], na.rm = TRUE))
  }
  # Prioridad 1: todos los sub-componentes en 0 -> 0
  if (all(valores == 0, na.rm = TRUE)) {
    return(0)
  }
  # Prioridad 2: el hogar contesto [2 = No] a la fuente correspondiente -> -7
  if (!is.na(valor_control) && valor_control == 2) {
    return(-7)
  }
  # Prioridad 3: incertidumbre; algun -9 -> el total no puede determinarse
  if (any(valores == -9)) return(-9)
  # Prioridad 4: ingreso potencial; sin -9 pero con algun -8 -> -8
  if (any(valores == -8)) return(-8)
  # Prioridad 5: no aplicabilidad; solo quedan -7 -> -7
  if (all(valores == -7)) return(-7)
  # Prioridad 6 (default): cero explicito
  return(0)
}

#' Convierte una columna a numerico (texto INDEC con coma decimal o numerico).
#' @noRd
comparability_numerico <- function(x) {
  if (is.numeric(x)) return(as.numeric(x))
  x <- trimws(as.character(x))
  x[x == "" | x == "NA"] <- NA_character_
  suppressWarnings(as.numeric(sub(",", ".", x, fixed = TRUE)))
}

#' Clasifica la base en legacy (< 2024 T4) o nueva (>= 2024 T4).
#' Aborta si la base mezcla periodos de ambas metodologias.
#' @noRd
comparability_era <- function(base) {
  anio <- comparability_numerico(base$ANO4)
  trim <- comparability_numerico(base$TRIMESTRE)
  per <- unique(100 * anio + trim)
  per <- per[!is.na(per)]
  if (length(per) == 0) {
    cli::cli_abort("No se pudo determinar el periodo: ANO4/TRIMESTRE sin datos validos.")
  }
  nueva <- per >= 202404
  if (all(nueva)) return("nueva")
  if (all(!nueva)) return("legacy")
  cli::cli_abort(c(
    "La base combina periodos anteriores y posteriores al cambio metodologico (2024 T4).",
    "i" = "Separe los periodos y aplique la funcion solo a los trimestres de la nueva metodologia."
  ))
}

#' Etiquetas de periodo de una base, ordenadas (p. ej. "2025-T1").
#' @noRd
comparability_periodos <- function(base) {
  anio <- comparability_numerico(base$ANO4)
  trim <- comparability_numerico(base$TRIMESTRE)
  per <- sort(unique(paste0(anio, "-T", trim)))
  paste(per, collapse = ", ")
}
