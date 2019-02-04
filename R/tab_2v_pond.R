
tabulado2v <- function(base, var1, var2, ponderador,
                       con_na = FALSE, pct_col = TRUE, pct_fila = FALSE){
  
  ### Cargamos paquetes necesarios
  if(!require(pacman))install.packages("pacman")
  pacman::p_load(tidyverse, questionr, janitor)
  
  ######## CON NA
  if(con_na == TRUE){
  tabla_pond <- as.data.frame(wtd.table(var1, var2, 
                                        weights = ponderador,
                                        na.show = TRUE)) %>%
    spread(., Var2, Freq)
  
  # Porcentaje por columnas
  if(pct_col == TRUE & pct_fila == FALSE){
    tabla_pond <- tabla_pond %>%
      adorn_totals("row") %>% 
      adorn_totals("col") %>% 
      adorn_percentages("col") %>% 
      adorn_pct_formatting()
  } else {
  # Porcentaje por fila
  if(pct_col == FALSE & pct_fila == TRUE){
    tabla_pond <- tabla_pond %>%
      adorn_totals("row") %>% 
      adorn_totals("col") %>% 
      adorn_percentages("row") %>% 
      adorn_pct_formatting()
  }
  }
  } else {

  ########  SIN NA
  if(con_na == FALSE){
    tabla_pond <- as.data.frame(wtd.table(var1, var2, 
                                          weights = ponderador,
                                          na.show = FALSE)) %>% 
      spread(., Var2, Freq)
    
    # Porcentaje por columnas
    if(pct_col == TRUE & pct_fila == FALSE){
      tabla_pond <- tabla_pond %>%
        adorn_totals("row") %>% 
        adorn_totals("col") %>% 
        adorn_percentages("col") %>% 
        adorn_pct_formatting()
    } else {
    
    # Porcentaje por fila
    if(pct_col == FALSE & pct_fila == TRUE){
      tabla_pond <- tabla_pond %>%
        adorn_totals("row") %>% 
        adorn_totals("col") %>% 
        adorn_percentages("row") %>% 
        adorn_pct_formatting()
    }
    }
  }
  }
  print(tabla_pond)
}
