
tabulado2v <- function(base, var1, var2, ponderador,
                       con_na, pct_col, pct_row){
  
  ### Cargamos paquetes necesarios
  require(pacman)
  p_load(tidyverse, questionr, janitor)
  
  ######## CON NA
  if(con_na == TRUE){
  tabla_pond <- as.data.frame(wtd.table(var1, var2, 
                                        weights = base$ponderador,
                                        na.show = TRUE)) %>% 
    spread(., Var2, Freq)
  
  # Por columnas
  if(pct_col == TRUE & pct_row == FALSE){
    tabla_pond <- tabla_pond %>%
      adorn_totals("row") %>% 
      adorn_totals("col") %>% 
      adorn_percentages("col") %>% 
      adorn_pct_formatting()
  } else {
  # Por fila
  if(pct_col == FALSE & pct_row == TRUE){
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
                                          weights = base$ponderador,
                                          na.show = FALSE)) %>% 
      spread(., Var2, Freq)
    
    # Por columnas
    if(pct_col == TRUE & pct_row == FALSE){
      tabla_pond <- tabla_pond %>%
        adorn_totals("row") %>% 
        adorn_totals("col") %>% 
        adorn_percentages("col") %>% 
        adorn_pct_formatting()
    } else {
    
    # Por fila
    if(pct_col == FALSE & pct_row == TRUE){
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
