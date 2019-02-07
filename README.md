# Caja de Herramientas para el procesamiento de la Encuesta Permanente de Hogares

## Overview
La librería `eph` tiene por objecto facilitar el trabajo de aquellos usuarios de la [Encuesta Permanente de Hogares](https://www.indec.gob.ar/bases-de-datos.asp) de Argentina, que deseen procesarla mediante R

Algunas de las funciones son:

- `get_bases_eph()`: permite descargar las bases directamente de la página de INDEC
- `put_labels_eph()`: etiqueta las bases siguiendo el último [diseño de registro](https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_t218.pdf)
- `Crea_Panel_Continua()`:Permite armar un pool de datos en panel de la EPH continua a partir de especificar una serie de bases, variables y el largo de la ventana de observación

## Instalación

Desde Rstudio 

```

# install.packages('devtools') si no tiene instalado devtools

devtools::install_github("pablinte/eph")

```

### Modo de uso.

```
# descargar la base del 2018, primer trimestre

df <- get_bases_eph(anio = 2018, trimestre = 1, etiqueta = FALSE)

# etiquetar la base hogar

df_hogar <- put_labels_eph(df$base_hogar, base='hogar')
```


## Aportes de la comunidad

Este paquete se propone incorporar cualquier función de propósitos generales que utilice como base los datos de la Encuesta Permanente de Hogares. Todos los aportes en este sentido son bienvenidos.

Si trabajas con la EPH y querés agregar tu función, te recomendamos que leas el siguiente [issue](https://github.com/pablinte/eph/issues/5#issue-407890587) con consejos de como colaborar
