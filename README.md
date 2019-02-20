# Caja de Herramientas para el procesamiento de la Encuesta Permanente de Hogares

## Overview
La librería `eph` tiene por objecto facilitar el trabajo de aquellos usuarios de la [Encuesta Permanente de Hogares](https://www.indec.gob.ar/bases-de-datos.asp) de Argentina, que deseen procesarla mediante R

Algunas de las funciones son:

- `get_microdata()`: permite descargar las bases directamente de la página de INDEC
- `organize_labels()`: etiqueta las bases siguiendo el último [diseño de registro](https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_t218.pdf)
- `organize_panels()`:Permite armar un pool de datos en panel de la EPH continua a partir de especificar una serie de bases, variables y el largo de la ventana de observación
- `calculate_tabulates()`: calcula tabulados ponderados
- `calculate_poverty()`: replica el cálculo de pobreza e indigencia del INDEC, pero para las bases trimestrales^[el calculo oficial se realiza sobre bases semestrales no publicadas]

## Instalación

Desde Rstudio 

```

# install.packages('devtools') si no tiene instalado devtools

devtools::install_github("pablinte/eph")

```

### Modo de uso.

```
base_2016t3 <-  get_microdata(year = 2016,trimester = 3,labels = FALSE)[['base_individual']]
base_2016t4 <- get_microdata(year = 2016,trimester = 4,labels = FALSE)[['base_individual']]

bases <- dplyr::bind_rows(base_2016t3,base_2016t4)
base_pobreza <- calculate_poverty(base = bases, basket = canastas_reg_example,print_summary=TRUE)

#  # A tibble: 2 x 4
#  #Groups:   ANO4 [?]
#  ANO4 TRIMESTRE Tasa_pobreza Tasa_indigencia
#  <int>     <int>        <dbl>           <dbl>
#  1  2016         3        0.307          0.0662
#  2  2016         4        0.300          0.0568
```


## Aportes de la comunidad

Este paquete se propone incorporar cualquier función de propósitos generales que utilice como base los datos de la Encuesta Permanente de Hogares. Todos los aportes en este sentido son bienvenidos.

Si trabajas con la EPH y querés agregar tu función, te recomendamos que leas el siguiente [issue](https://github.com/pablinte/eph/issues/5#issue-407890587) con consejos de como colaborar
