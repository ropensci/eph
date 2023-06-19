# Bienvenides :tada: :tada: :tada: 

El objetivo de esta librería es construir un Toolbox para el procesamiento de la [Encuesta Permanente de Hogares (indec)](https://www.indec.gob.ar/bases-de-datos.asp)

Para agregar tu función te pedimos que sigas los siguentes pasos:

1. Hace un fork de este repositorio
2. Agregues tu función como un archivo .R en la carpeta R/ con el mismo nombre que la función
3. Documenta la misma con [roxygen2](http://kbroman.org/pkg_primer/pages/docs.html) aclarando su funcionalidad, los parámetros y un ejemplo de uso. Para ver como se documenta poder revisar otra de las funciones en ese mismo directorio
4. Recordá que para que tu función se pueda utilizar, al final de la documentación debes agregar un 
`#' @export`
5. Controla que los tipos y valores de los parametros de tu función estén bien (para un ejemplo, podes mirar [get_microdata.r](https://github.com/rindec/eph/blob/master/R/get_microdata.R)) y agregá los tests que sean pertinentes.
6. Agrega las dependencias en el archivo DESCRIPTION
7. Chequea el paquete con ```devtools::check()```
8. Si todo funciona bien, entonces hace un pull request

__obs.__ Te pedimos que en la medida de los posible trates de seguir la [guía de estilo del Tidyverse](https://style.tidyverse.org/syntax.html) que va a simplificar mucho la lectura del código y la usabilidad de la librería


# Nombres de Funciones

Para mantener la cohesión interna de la librería, decidimos el siguiente esquema de nombres para funciones:

- Las mismas deben ser escritas en inglés, al igual que los parametros que utilicen. 
- funciones que descargan datos `get_`{microdata | poverty_lines}
- funciones que calculan cosas `calculate_`{poverty | tabulates}
- funciones que organizan los datos `organize_` {labels | panels}
- funciones que estiman cosas `estimate_{confint}`
