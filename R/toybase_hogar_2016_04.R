#' Seleccion aleatoria de casos de la base 2016 trimestre 4 para la base hogar
#'
#' @format  Un data frame con 2000 filas y 177 variables
#'
#' \describe{
#' \item{CODUSU}{'Codigo para distinguir VIVIENDAS, permite aparearlas con Hogares y Personas. Ademas permite hacer el seguimiento a traves de los trimestres'}
#' \item{ANO4}{'Anio de relevamiento'}
#' \item{TRIMESTRE}{'Ventana de Observacion'}
#' \item{NRO_HOGAR}{'Codigo para distinguir HOGARES, permite aparearlos con Personas'}
#' \item{REALIZADA}{'Entrevista individual realizada'}
#' \item{REGION}{'Codigo de Region'}
#' \item{MAS_500}{'Aglomerados segun tamanio'}
#' \item{AGLOMERADO}{'Codigo de Aglomerado'}
#' \item{PONDERA}{'Ponderacion'}
#' \item{IV1}{'Tipo de vivienda'}
#' \item{IV1_ESP}{'Otros (Especificar)'}
#' \item{IV2}{'Cuantos ambientes/  habitaciones  tiene  la  vivienda en  total?  (sin  contar  banio/s,  cocina,  pasillo/s,lavadero, garage)'}
#' \item{IV3}{'Los pisos interiores son principalmente de...'}
#' \item{IV3_ESP}{'Otros. Especificar'}
#' \item{IV4}{'La cubierta exterior del techo es de....'}
#' \item{IV5}{'El techo tiene cielorraso/revestimiento interior?'}
#' \item{IV6}{'Tiene agua...'}
#' \item{IV7}{'El agua es de...'}
#' \item{IV7_ESP}{'Otras fuentes. Especificar'}
#' \item{IV8}{'Tiene banio/letrina?'}
#' \item{IV9}{'El banio o letrina esta...'}
#' \item{IV10}{'El banio tiene...'}
#' \item{IV11}{'El desague del banio es...'}
#' \item{IV12_1}{'La vivienda esta ubicada cerca de basural/es(3 cuadras O menos)'}
#' \item{IV12_2}{'La vivienda esta ubicada en zona inundable (en los ultimos 12 meses)'}
#' \item{IV12_3}{'La vivienda esta ubicada en villa de emergencia (por observacion)'}
#' \item{II1}{   'Cuantos  ambientes/  habitaciones tiene este  hogar para su uso exclusivo?'}
#' \item{II2}{ 'De esos, cuantos usan habitualmente para dormir?'}
#' \item{II3}{ 'Utiliza alguno exclusivamente como lugar de Trabajo(paraconsultorio,estudio,taller, negocio, etc.).'}
#' \item{II3_1}{ 'Si utiliza alguno exclusivamente como lugar de Trabajo Cuantos?.'}
#' \item{II4_1}{ 'Tiene ademas...  Cuarto de cocina.'}
#' \item{II4_2}{ 'Tiene ademas... Lavadero.'}
#' \item{II4_3}{'Tiene ademas... Garage.'}
#' \item{II5}{'De esos ...(los si de preg.4) usan alguno para dormir.'}
#' \item{II5_1}{'Si Utiliza alguno para dormir Cuantos?.'}
#' \item{II6}{'De esos ...(los si de preg.4) utiliza alguno de estos exclusivamente como lugar de trabajo (consultorio, estudio, taller, negocio, etc.).'}
#' \item{II6_1}{'Si utiliza alguno exclusivamente como lugar de  trabajo Cuantos?'}
#' \item{II7}{'Regimen de tenencia'}
#' \item{II7_ESP}{'Otra situacion (Especificar).'}
#' \item{II8}{'Combustible utilizado para cocinar'}
#' \item{II8_ESP}{'Otro. Especificar.'}
#' \item{II9}{'Banio (tenencia y uso).'}
#' \item{V1}{'En los ultimos tres meses   las personas de este hogar han vivido... de lo que ganan en el trabajo?.'}
#' \item{V2}{'En los ultimos tres meses   las personas de este hogar han vivido... de alguna jubilacion o pension?.'}
#' \item{V21}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... Aguinaldo de alguna  jubilacion  o  pension cobrada el mes anterior?'}
#' \item{V22}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... Retroactivo de alguna jubilacion o pension que cobro el mes anterior?'}
#' \item{V3}{'En los ultimos tres meses   las personas de este hogar han vivido de... indemnizacion por despido?'}
#' \item{V4}{'En los ultimos tres meses   las personas de este hogar han vivido de... seguro de desempleo?'}
#' \item{V5}{'En los ultimos tres meses   las personas de este hogar han vivido de... desubsidio oayuda  social(en dinero) del gobierno, iglesias, etc.?'}
#' \item{V6}{'En los ultimos tres meses   las personas de este hogar han vivido con...  mercaderias,  ropa,  alimentos     del gobierno  iglesias, escuelas, etc.?'}
#' \item{V7}{'En los ultimos tres meses   las personas de este hogar han vivido con... mercaderias, ropa, alimentos de familiares, vecinos u otras personas que no viven en  este  hogar?    '}
#' \item{V8}{'En los ultimos tres meses   las personas de este hogar han vivido de... algun alquiler (por una vivienda, terreno, oficina, etc.)de su propiedad?'}
#' \item{V9}{'En los ultimos tres meses   las personas de este hogar han vivido de... ganancias de algun negocio enel que  no  trabajan?'}
#' \item{V10}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... intereses o rentas por  plazos fijos/  inversiones?'}
#' \item{V11}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... una beca de estudio?'}
#' \item{V12}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... cuotas de alimentos o  ayuda  en  dinero  de personas que no viven en el hogar?'}
#' \item{V13}{ 'En los ultimos tres meses   las personas de este hogar han vivido con... gastar lo que tenian ahorrado?'}
#' \item{V14}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... pedir prestamos a familiares/amigos'}
#' \item{V15}{ 'En los ultimos tres meses   las personas de este hogar han vivido de... pedir prestamos a bancos, financieras, etc.?'}
#' \item{V16}{'En los ultimos tres meses  las personas de este hogar han vivido de... Compran en  cuotas  o  al  fiado  con  tarjeta  de credito o libreta?'}
#' \item{V17}{ 'Han tenido que vender alguna de sus pertenencias?'}
#' \item{V18}{   'Tuvieron otros  ingresos  en  efectivo  (limosnas, juegos de azar, etc.)'}
#' \item{V19_A}{ 'menores de  10  anios  ayudan  con  algun  dinero    trabajando?'}
#' \item{V19_B}{ 'Menores de  10  anios  ayudan  con  algun  dinero  pidiendo?'}
#' \item{IX_TOT}{  'Cantidad de miembros del Hogar'}
#' \item{IX_MEN10}{  'Cantidad de miembros del Hogar menores de 10 anios'}
#' \item{IX_MAYEQ10}{  'Cantidad de miembros del Hogar de 10 y mas anios'}
#' \item{ITF}{   'MONTO DE INGRESO TOTAL FAMILIAR'}
#' \item{DECIFR}{  'Nro de decil del ingreso total del hogar del TOTAL EPH'}
#' \item{IDECIFR}{   'Nro de decil del ingreso total del hogar del TOTAL EPH'}
#' \item{RDECIFR}{ 'Nro de decil de  ingreso  total  del  hogar  de  la  REGION.'}
#' \item{GDECIFR}{ 'Nro de decil de  ingreso  total  del  hogar  del Conjunto  de AGLOMERADOS DE 500 MIL Y MAS HABITANTES.'}
#' \item{PDECIFR}{ 'Nro de decil de  ingreso  total  del  hogar  del Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL  HABITANTES'}
#' \item{ADECIFR}{ 'Nro  de  decil  de  ingreso  total  del  hogar  del  AGLOMERADO'}
#' \item{IPCF}{  'Monto de ingreso per capita familiar(ver AnexoI)'}
#' \item{DECCFR}{  'Nro de decil del  ingreso  per  capita  familiar  del  TOTAL EPH'}
#' \item{IDECCFR}{ 'Nro  de  decil  del  ingreso  per  capita  familiar  del INTERIOR'}
#' \item{RDECCFR}{ 'Nro de decil de  ingreso  per  capita  familiar  de  la  REGION'}
#' \item{GDECCFR}{ 'Nro  de  decil  de  ingreso  per  capita  familiar  del  Conjunto  de AGLOMERADOS DE 500 MIL Y MAS HABITANTES'}
#' \item{PDECCFR}{ 'Nro  de  decil  de  ingreso  per  capita  familiar  del  Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL  HABITANTES'}
#' \item{ADECCFR}{ 'Nro  de  decil  de  ingreso  per  capita  familiar  del  AGLOMERADO'}
#' \item{PONDIH}{'Ponderador  del  ingreso  total  familiar  y   del ingreso per capita familiar'}
#' \item{VII1_1}{  'Realizacion de las tareas de la casa   - Numero de componente del hogar'}
#' \item{VII1_2}{  'Realizacion de las tareas de la casa - Numero de componente del hogar'}
#' \item{VII2_1}{  'Otras personas que ayudan en las tareas de la casa   - Numero de componente del hogar'}
#' \item{VII2_2}{  'Otras personas que ayudan en las tareas de la casa - Numero de componente del hogar'}
#' \item{VII2_3}{  'Otras personas que ayudan en las tareas de la casa - Numero de componente del hogar'}
#' \item{VII2_4}{  'Otras personas que ayudan en las tareas de la casa - Numero de componente del hogar'}
#' ...
#' }
#'
"toybase_hogar_2016_04"
