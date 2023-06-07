#' Descarga de Bases de la Encuesta anual de hogares urbanos
#'
#' @param year un integer entre 2010 y 2014
#' @param type tipo de base a descargar: 'individual' ; 'hogar'
#' @param vars variables a seleccionar. Default trae todas las variables
#'
#' @noRd

get_eahu_internal <- function(year,
                              type,
                              vars = 'all'){

  if(!is.numeric(year)){
    cli::cli_abort(c(
      "year debe ser numeric"
    ))
  }
  if(!type %in% c("individual", "hogar")){
    cli::cli_abort(c(
      "Elegir alguna de las opciones de type: 'individual' u 'hogar'."
    ))
  }

  if(!year %in% 2010:2014){

    cli::cli_abort(c(
      "El anio elegido no es valido",
      "i" = "Hay datos disponibles entre 2010 y 2014"
    ))

  }


    link <- sprintf('https://github.com/holatam/data/raw/master/eahu/%s/eahu_%s_%s.RDS',type,type,year)

    base <- emptyenv()
    try(base <- readRDS(gzcon(url(link))),silent = TRUE)

    assertthat::assert_that(assertthat::not_empty(base),msg = "Problema con la descarga. Posiblemente un error de la conexion a internet")


    if (all(vars == 'all')) {

      base <- base %>%
        dplyr::rename_all(toupper)

      return(base)

    }
    if (nrow(base)>0) {


      chequeo <- vars %in% toupper(colnames(base))

      assertthat::assert_that(all(chequeo),
      msg=sprintf('Las variables: %s no se encuentran disponibles para esta base.
                             Puede deberse a que son variables de la base individual (hogar) y se quiere descargar la base hogar (individual)',sub(",([^,]*)$", " y\\1", paste0(vars[!chequeo], collapse = ", "))))

      base <- base %>%
        dplyr::rename_all(toupper) %>%
        dplyr::select(vars)

      return(base)

    }



}


