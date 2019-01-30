 ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
        *******************************************************Diseño de Registro de BASE HOGAR*****************************************************.
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************.
    ** --> Las etiquetas y nombres de las variables están en función del Diseño de Registro del 1° trimestre de 2018 publicado por el INDEC.
    ** La sintaxis es de elaboración propia, no es oficial. Es sólo para la base usuaria , aunque algunas variables se comparten con la base INDIVIDUAL y pueden correrse allí también.
** Cualquier error que encuentres, si podés, arreglalo y compartí las modificaciones. Sino avisame y lo corregimos.

*Código para distinguir VIVIENDAS.
variable labels CODUSU 'Código para distinguir VIVIENDAS, permite aparearlas con Hogares y Personas. Además permite hacer el seguimiento a través de los trimestres'.

*Año de relevamiento.
variable labels ano4 'Año de relevamiento'.
    
*Trimestre.
variable labels Trimestre 'Ventana de Observación'.
value labels trimestre
1 "1er Trimestre"
2 "2do Trimestre"
3 "3er Trimestre"
4 "4to Trimestre".
    
*Código para distinguir HOGARES.
variable labels Nro_hogar ' Código para distinguir HOGARES, permite aparearlos con Personas'.

*Entrevista individual realizada.
variable labels REALIZADA 'Entrevista individual realizada'.
value labels REALIZADA
1 "Si"
2 "No".

*Región.
variable labels region 'Código de Región'.
value labels REGION
01 "Gran Buenos Aires"
40 "Noroeste"
41 "Nordeste"
42 "Cuyo"
43 "Pampeana"
44 "Patagónica".

*Aglomerados según tamaño.
variable labels MAS_500 'Aglomerados según tamaño'.

*Recodificación de la variable Aglomerados según tamaño para pasar de tipo CADENA a NUMERICA.
AUTORECODE VARIABLES=MAS_500  /INTO MAS_500_rec  /BLANK=MISSING  /PRINT.
variable labels MAS_500_rec 'Aglomerados según tamaño'.

 ****Aglomerado.
variable labels aglomerado 'Código de Aglomerado'.
value labels aglomerado
02 "Gran La Plata"
03 "Bahía Blanca - Cerri"
04 "Gran Rosario"
05 "Gran Santa Fé"
06 "Gran Paraná"
07 "Posadas"
08 "Gran Resistencia"
09 "Cdro. Rivadavia - R.Tilly"
10 "Gran Mendoza"
12 "Corrientes"
13 "Gran Córdoba"
14 "Concordia"
15 "Formosa"
17 "Neuquén - Plottier"
18 "S. del Estero - La Banda"
19 "Jujuy - Palpalá"
20 "Río Gallegos"
22 "Gran Catamarca"
23 "Salta"
25 "La Rioja"
26 "San Luis - El Chorrillo"
27 "Gran San Juan"
29 "Gran Tucumán - T. Viejo"
30 "Santa Rosa - Toay"
31 "Ushuaia - Río Grande"
32 "Ciudad de Buenos Aires"
33 "Partidos del GBA"
34 "Mar del Plata - Batán"
36 "Río Cuarto"
38 "San Nicolás - Villa Constitución"
91 "Rawson - Trelew"
93 "Viedma - Carmen de Patagones".

*Ponderacion.
variable labels pondera 'Ponderación'.

*Tipo de vivienda ( por observación).
variable labels IV1 'Tipo de vivienda'.
value labels IV1
1 "Casa"
2 "Departamento"
3 "Pieza de inquilinato"
4 "Pieza en hotel/pensión"
5 "Local no construido para habitación"
6 "Otros. Especificar".

* Otros (especificar).
variable labels IV1_ESP 'Otros (especificar)'.

* Cuántos ambientes/  habitaciones  tiene  la  vivienda en  total?  (sin  contar  baño/s,  cocina,  pasillo/s,
lavadero, garage).
variable labels IV2 'Cuántos ambientes/  habitaciones  tiene  la  vivienda en  total?  (sin  contar  baño/s,  cocina,  pasillo/s,lavadero, garage)'.

* Los pisos interiores son principalmente de...
variable labels IV3 'Los pisos interiores son principalmente de...'.
value labels IV3
1 "Mosaico/baldosa/madera/cerámica/alfombra"
2 "Cemento/ladrillo fijo"
3 "Ladrillo suelto/tierra"
4 "Otros. Especificar".

variable labels IV3_ESP 'Otros. Especificar'.

* La cubierta exterior del techo es de....
variable labels IV4 'La cubierta exterior del techo es de....'.
value labels IV4
1 "Membrana/cubierta asfáltica"
2 "Baldosa/losa sin cubierta"
3 "Pizarra/teja"
4 "Chapa de metal sin cubierta"
5 "Chapa de fibrocemento/plástico"
6 "Chapa de cartón"
7 "Caña/tabla/paja con barro/paja sola"
9 "N/S. Depto en propiedad horizontal".

* El techo tiene cielorraso/revestimiento interior?.
variable labels IV5 'El techo tiene cielorraso/revestimiento interior?'.
value labels IV5
1 "Si"
2 "No".

* Tiene agua...
variable labels IV6 'Tiene agua...'.
value labels IV6
1 "Por cañería dentro de la vivienda"
2 "Fuera de la vivienda pero dentro del terreno"
3 "Fuera del terreno".

* El agua es de...
variable labels IV7 'El agua es de...'.
value labels IV7
1 "Red pública (agua corriente)"
2 "Perforación con bomba a motor"
3 "Perforación con bomba manual"
4 "Otras fuentes".

variable labels IV7_ESP 'Otras fuentes. Especificar'.

* ¿Tiene baño/letrina?.
variable labels IV8 '¿Tiene baño/letrina?'.
value labels IV8
	1 "Si"
	2 "No".

* IV9 	El baño o letrina está...
variable labels IV9 'El baño o letrina está...'.
value labels IV9
1 "Dentro de la vivienda"
2 "Fuera de la vivienda pero dentro del terreno"
3 "Fuera del terreno".

* IV10		El baño tiene....			
variable labels IV10	'El baño tiene...'.
value labels IV10
1 "Inodoro  con  botón/  mochila/ cadena y  arrastre	de agua"
2 "Inodoro sin botón/cadena y con arrastre de agua (a balde)"
3 "Letrina (sin arrastre de agua)".

* IV11		El desague del baño es....			
variable labels IV11	'El desague del baño es...'.
value labels IV11
1 "A red pública (cloaca)"
2 "A cámara séptica y pozo ciego"
3 "Sólo a pozo ciego"
4 "A hoyo/excavación en al tierra".
					
* IV12_1		La vivienda está ubicada cerca de basural/es(3 cuadras O menos).
variable labels IV12_1	'La vivienda está ubicada cerca de basural/es(3 cuadras O menos)'.
value labels IV12_1
1 "Si"
2 "No".
					
* IV12_2		La vivienda está ubicada en zona inundable (en los últimos 12 meses)			.
variable labels IV12_2	'La vivienda está ubicada en zona inundable (en los últimos 12 meses)'.
value labels IV12_2
1 "Si"
2 "No".

* IV12_3		La vivienda está ubicada en villa de emergencia (por observación).
variable labels IV12_3	'La vivienda está ubicada en villa de emergencia (por observación)'.
value labels IV12_3
1 "Si"
2 "No".

*******   Características habitacionales del hogar.
* II1		Cuántos  ambientes/  habitaciones tiene este  hogar para su uso exclusivo?.
variable labels II1		'Cuántos  ambientes/  habitaciones tiene este  hogar para su uso exclusivo?'.
					
* II2		De esos, cuántos usan habitualmente para dormir?.
variable labels II2	'De esos, cuántos usan habitualmente para dormir?'.
					
* II3		Utiliza alguno exclusivamente como lugar de Trabajo(paraconsultorio,estudio,taller, negocio, etc.).
variable labels  II3	'Utiliza alguno exclusivamente como lugar de Trabajo(paraconsultorio,estudio,taller, negocio, etc.).'.
value labels II3
1 "Si"
2 "No".
					
* II3_1		Si utiliza alguno exclusivamente como lugar de	Trabajo ¿Cuántos?.
variable labels II3_1	'Si utiliza alguno exclusivamente como lugar de	Trabajo ¿Cuántos?.'.
					
* II4_1		Tiene además...	Cuarto de cocina.
variable labels II4_1	'Tiene además...	Cuarto de cocina.'.
value labels II4_1
1 "Si"
2 "No".
					
* II4_2		Tiene además... Lavadero.
variable labels II4_2	'Tiene además... Lavadero.'.
value labels II4_2
1 "Si"
2 "No".

* II4_3 	Tiene además... Garage.
variable labels  II4_3 'Tiene además... Garage.'.
value labels II4_3
1 "Si"
2 "No".

* II5 	De esos ...(los si de preg.4) usan alguno para dormir.
variable labels II5 'De esos ...(los si de preg.4) usan alguno para dormir.'.
value labels II5
1 "Si"
2 "No".

* II5_1 	Si Utiliza alguno para dormir ¿Cuántos?.
variable labels II5_1 'Si Utiliza alguno para dormir ¿Cuántos?.'.

* II6 	De esos ...(los si de preg.4) utiliza alguno de	estos exclusivamente como lugar	de trabajo (consultorio, estudio, taller, negocio, etc.).
variable labels II6 'De esos ...(los si de preg.4) utiliza alguno de	estos exclusivamente como lugar	de trabajo (consultorio, estudio, taller, negocio, etc.).'.
value labels II6
	1 "Si"
	2 "No".

*II6_1 	Si utiliza alguno exclusivamente como lugar de	trabajo ¿Cuántos?.
variable labels II6_1 'Si utiliza alguno exclusivamente como lugar de	trabajo ¿Cuántos?'.

*II7 	Régimen de tenencia.
variable labels II7 'Régimen de tenencia'.
value labels II7
	01 "Propietario de la vivienda y el terreno"
	02 "Propietario de la vivienda solamente"				
	03 "Inquilino/arrendatario de la vivienda"				
	04 "Ocupante por pago de impuestos/expensas"
	05 "Ocupante en relación de dependencia"
	06 "Ocupante gratuito (con permiso)"
	07 "Ocupante de hecho (sin permiso)"				
	08 "Está en sucesión?"
 09 "Otra situación (especificar).".

*II7_Esp C(45)	09 "Otra situación (especificar).
variable labels II7_Esp 'Otra situación (especificar).'.
* II8 	Combustible utilizado para cocinar.
variable labels II8 'Combustible utilizado para cocinar'.
value labels II8
01 "Gas de red"		
02 "Gas de tubo/garrafa"				
03 "Kerosene/ leña/ carbón"
04 "Otro (especificar)".
* II8_Esp - Otro. Especificar.
variable labels II8_Esp 'Otro. Especificar.'.
* II9 	Baño (tenencia y uso).
variable labels II9 'Baño (tenencia y uso).'.
value labels II9
	01 "Uso exclusivo del hogar"
	02 " Compartido  con  otro/s  hogar/es  de  la  misma	vivienda"
	03 "Compartido con otra/s vivienda/s"
	04 "No tiene baño".
					
******************************* Estrategias del hogar.	
* V1 ¿En los últimos tres meses	 las personas de este hogar han vivido... de lo que ganan en el trabajo?.
variable labels V1 '¿En los últimos tres meses	 las personas de este hogar han vivido... de lo que ganan en el trabajo?.'.
value labels		V1
1 "Si"
2 "No".
* V2 ¿En los últimos tres meses	 las personas de este hogar han vivido... de alguna jubilación o pensión?.
variable labels V2 '¿En los últimos tres meses	 las personas de este hogar han vivido... de alguna jubilación o pensión?.'.
value labels		V2
1 "Si"
2 "No".
					
* V21	¿En los últimos tres meses	 las personas de este hogar han vivido de... Aguinaldo de	alguna	jubilación	o  pensión cobrada el mes anterior.
variable labels V21	'¿En los últimos tres meses	 las personas de este hogar han vivido de... Aguinaldo de	alguna	jubilación	o  pensión cobrada el mes anterior?'.
value labels V21
1 "Si"
2 "No".		
* V22	¿En los últimos tres meses	 las personas de este hogar han vivido de... Retroactivo de	alguna jubilación o pensión que cobró el mes anterior?.
variable labels V22	'¿En los últimos tres meses	 las personas de este hogar han vivido de... Retroactivo de	alguna jubilación o pensión que cobró el mes anterior?'.
value labels V22
1 "Si"
2 "No".
* V3	¿En los últimos tres meses	 las personas de este hogar han vivido de... indemnización por despido?.
variable labels V3	'¿En los últimos tres meses	 las personas de este hogar han vivido de... indemnización por despido?'.
value labels V3
1 "Si"
2 "No".
* V4	¿En los últimos tres meses	 las personas de este hogar han vivido de... seguro de desempleo?.
variable labels V4	'¿En los últimos tres meses	 las personas de este hogar han vivido de... seguro de desempleo?'.
value labels V4
1 "Si"
2 "No".
* V5	¿En los últimos tres meses	 las personas de este hogar han vivido de... desubsidio	oayuda	social(en	dinero) del gobierno, iglesias, etc.?.
variable labels V5	'¿En los últimos tres meses	 las personas de este hogar han vivido de... desubsidio	oayuda	social(en	dinero) del gobierno, iglesias, etc.?'.
value labels V5
1 "Si"
2 "No".
* V6	¿En los últimos tres meses	 las personas de este hogar han vivido con...  mercaderías,  ropa,  alimentos			del gobierno	iglesias, escuelas,	etc.?.
variable labels V6	'¿En los últimos tres meses	 las personas de este hogar han vivido con...  mercaderías,  ropa,  alimentos			del gobierno	iglesias, escuelas,	etc.?'.
value labels	V6
1 "Si"
2 "No".
* V7	¿En los últimos tres meses	 las personas de este hogar han vivido con... mercaderías, ropa, alimentos de familiares,	vecinos u otras personas que no viven en  este	hogar?.
variable labels V7	'¿En los últimos tres meses	 las personas de este hogar han vivido con... mercaderías, ropa, alimentos de familiares,	vecinos u otras personas que no viven en  este	hogar?		'.
value labels	V7
1 "Si"
2 "No".
* V8		¿En los últimos tres meses	 las personas de este hogar han vivido de... algún alquiler (por una vivienda, terreno,	oficina, etc.)de su propiedad?.
variable labels V8	'¿En los últimos tres meses	 las personas de este hogar han vivido de... algún alquiler (por una vivienda, terreno,	oficina, etc.)de su propiedad?'.
value labels V8
1 "Si"
2 "No".
* V9	¿En los últimos tres meses	 las personas de este hogar han vivido de... ganancias de algún negocio enel que  no	trabajan?.
variable labels V9	¿En los últimos tres meses	 las personas de este hogar han vivido de... ganancias de algún negocio enel que  no	trabajan?.
value labels V9
1 "Si"
2 "No".	
* V10	¿En los últimos tres meses	 las personas de este hogar han vivido de... intereses o rentas por  plazos fijos/	inversiones?.
variable labels V10	'¿En los últimos tres meses	 las personas de este hogar han vivido de... intereses o rentas por  plazos fijos/	inversiones?'.
value labels V10
1 "Si"
2 "No".
* V11	¿En los últimos tres meses	 las personas de este hogar han vivido de... una beca de estudio?.
variable labels V11	'¿En los últimos tres meses	 las personas de este hogar han vivido de... una beca de estudio?'.
value labels V11
1 "Si"
2 "No".	
* V12	¿En los últimos tres meses	 las personas de este hogar han vivido de... cuotas de alimentos o  ayuda  en  dinero  de	personas que no viven en el hogar?.
variable labels V12	'¿En los últimos tres meses	 las personas de este hogar han vivido de... cuotas de alimentos o  ayuda  en  dinero  de	personas que no viven en el hogar?'.
value labels V12
1 "Si"
2 "No".	
					
* V13	¿En los últimos tres meses	 las personas de este hogar han vivido con... gastar lo que tenían ahorrado?.
variable labels V13	'¿En los últimos tres meses	 las personas de este hogar han vivido con... gastar lo que tenían ahorrado?'.
value labels V13
1 "Si"
2 "No".	
* V14	¿En los últimos tres meses	 las personas de este hogar han vivido de... pedir préstamos a familiares/amigos.
variable labels V14	'¿En los últimos tres meses	 las personas de este hogar han vivido de... pedir préstamos a familiares/amigos'.
value labels V14
1 "Si"
2 "No".
* V15	¿En los últimos tres meses	 las personas de este hogar han vivido de... pedir préstamos a bancos, financieras, etc.?.
variable labels V15	'¿En los últimos tres meses	 las personas de este hogar han vivido de... pedir préstamos a bancos, financieras, etc.?'.
value labels V15
1 "Si"
2 "No".	
* V16 ¿En los últimos tres meses	 las personas de este hogar han vivido de... Compran en  cuotas  o  al  fiado  con  tarjeta  de	crédito o libreta?.
variable labels V16 '¿En los últimos tres meses	 las personas de este hogar han vivido de... Compran en  cuotas  o  al  fiado  con  tarjeta  de	crédito o libreta?'.
value labels V16
1 "Si"
2 "No".
* V17		Han tenido que vender alguna de sus pertenencias?.
variable labels V17	'Han tenido que vender alguna de sus pertenencias?'.
value labels V17
1 "Si"
2 "No".
* V18		Tuvieron otros  ingresos  en  efectivo  (limosnas,	juegos de azar, etc.).
variable labels V18		'Tuvieron otros  ingresos  en  efectivo  (limosnas,	juegos de azar, etc.)'.
value labels V18
1 "Si"
2 "No".
* V19_A		menores de  10  años  ayudan  con  algún  dinero		trabajando?.
variable labels V19_A		'menores de  10  años  ayudan  con  algún  dinero		trabajando?'.
value labels V19_A
1 "Si"
2 "No".
* V19_B		menores de  10  años  ayudan  con  algún  dinero	pidiendo?.
variable labels V19_B	'Menores de  10  años  ayudan  con  algún  dinero	pidiendo?'.
value labels V19_B
1 "Si"
2 "No".
*************************************  Resumen del hogar					.
* IX_Tot		Cantidad de miembros del Hogar.
variable labels IX_Tot		'Cantidad de miembros del Hogar'.
* IX_Men10		Cantidad de miembros del Hogar menores de 10 años.
variable labels IX_Men10		'Cantidad de miembros del Hogar menores de 10 años'.
* IX_Mayeq10		Cantidad de miembros del Hogar de 10 y más años.
variable labels IX_Mayeq10		'Cantidad de miembros del Hogar de 10 y más años'.
					
********************Ingreso total familiar					.
* ITF		MONTO DE INGRESO TOTAL FAMILIAR(ver Anexo I).
variable labels ITF		'MONTO DE INGRESO TOTAL FAMILIAR'.
 
* DECIFR		No de decil del ingreso total del hogar del TOTAL	EPH (ver Anexo I).			
variable labels DECIFR		'Nro de decil del ingreso total del hogar del TOTAL	EPH'.
* IDECIFR		No  de  decil  del  ingreso  total  del  hogar  del	INTERIOR (ver Anexo I).
variable labels IDECIFR		'Nro de decil del ingreso total del hogar del TOTAL	EPH'.
* RDECIFR 	No de	decil de  ingreso  total  del  hogar  de  la	REGION (ver Anexo I).				
variable labels RDECIFR 	'Nro de	decil de  ingreso  total  del  hogar  de  la	REGION.'.
* GDECIFR 	No de	decil de  ingreso  total  del  hogar	del	Conjunto	de AGLOMERADOS DE 500 MIL	Y MAS	HABITANTES (ver Anexo I).				
variable labels GDECIFR 	'Nro de	decil de  ingreso  total  del  hogar	del	Conjunto	de AGLOMERADOS DE 500 MIL	Y MAS	HABITANTES.'.
* PDECIFR 	No de	decil de  ingreso  total  del  hogar	del	Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL	HABITANTES (ver Anexo I).				
variable labels PDECIFR 	'Nro de	decil de  ingreso  total  del  hogar	del	Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL	HABITANTES'.
* ADECIFR 	No  de  decil  de  ingreso  total  del  hogar  del	AGLOMERADO (ver Anexo I).				
variable labels ADECIFR 	'Nro  de  decil  de  ingreso  total  del  hogar  del	AGLOMERADO'.
****************Ingreso per cápita familiar					.
* IPCF 	Monto de ingreso per cápita familiar(ver AnexoI).
variable labels IPCF 	'Monto de ingreso per cápita familiar(ver AnexoI)'.
* DECCFR 	No de	decil del  ingreso  per  cápita  familiar  del	TOTAL EPH (ver Anexo I).
variable labels DECCFR 	'Nro de	decil del  ingreso  per  cápita  familiar  del	TOTAL EPH'.
* IDECCFR 	No  de  decil  del  ingreso  per  cápita  familiar  del	INTERIOR (ver Anexo I).				
variable labels IDECCFR 	'Nro  de  decil  del  ingreso  per  cápita  familiar  del	INTERIOR'.
* RDECCFR 	No de	decil de  ingreso  per  cápita  familiar  de  la	REGION (ver Anexo I).				
variable labels RDECCFR 	'Nro de	decil de  ingreso  per  cápita  familiar  de  la	REGION'.
* GDECCFR 	No  de  decil  de  ingreso  per  cápita  familiar  del	Conjunto	de AGLOMERADOS DE 500 MIL	Y MAS	HABITANTES (ver Anexo I).				
variable labels GDECCFR 	'Nro  de  decil  de  ingreso  per  cápita  familiar  del	Conjunto	de AGLOMERADOS DE 500 MIL	Y MAS	HABITANTES'.
* PDECCFR 	No  de  decil  de  ingreso  per  cápita  familiar  del	Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL	HABITANTES (ver Anexo I).				
variable labels PDECCFR 	'Nro  de  decil  de  ingreso  per  cápita  familiar  del	Conjunto  de  AGLOMERADOS  DE  MENOS  DE  500  MIL	HABITANTES'.
* ADECCFR 	No  de  decil  de  ingreso  per  cápita  familiar  del	AGLOMERADO (ver Anexo I).				
variable labels ADECCFR 	'Nro  de  decil  de  ingreso  per  cápita  familiar  del	AGLOMERADO'.
* PONDIH Ponderador  del  ingreso  total  familiar  y		del	ingreso per cápita familiar (ver Anexo I).
variable labels PONDIH 'Ponderador  del  ingreso  total  familiar  y		del	ingreso per cápita familiar'.
*****************Organización del hogar.
* VII 1_1 	Realización de las tareas de la casa		- Número de componente del hogar.
variable labels VII1_1 	'Realización de las tareas de la casa		- Número de componente del hogar'.
value labels VII1_1
96 "Servicio doméstico"
97:"Otra persona que no vive en el hogar".
					
* VII 1_2		Realización de las tareas de la casa - Número de componente del hogar.
variable labels VII1_2		'Realización de las tareas de la casa - Número de componente del hogar'.
value labels VII1_2
96 "Servicio doméstico"			
97 "Otra persona que no vive en el hogar".
			
* VII 2_1		Otras personas que ayudan en las tareas de la casa		- Número de componente del hogar.
variable labels VII2_1		'Otras personas que ayudan en las tareas de la casa		- Número de componente del hogar'.
value labels VII2_1
96 "Servicio doméstico"
97 "Otra persona que no vive en el hogar"
98 "Ninguna".
* VII 2_2		Otras personas que ayudan en las tareas de la casa	- Número de componente del hogar.
variable labels VII2_2		'Otras personas que ayudan en las tareas de la casa	- Número de componente del hogar'.
value labels VII2_2
96 "Servicio doméstico"			
97 "Otra persona que no vive en el hogar"
98 "Ninguna".
* VII 2_3		Otras personas que ayudan en las tareas de la casa	- Número de componente del hogar.
variable labels VII2_3		'Otras personas que ayudan en las tareas de la casa	- Número de componente del hogar'.
value labels VII2_3
96 "Servicio doméstico"			
97 "Otra persona que no vive en el hogar"
98 "Ninguna".
* VII 2_4		Otras personas que ayudan en las tareas de la casa - Número de componente del hogar.
variable labels VII2_4		'Otras personas que ayudan en las tareas de la casa - Número de componente del hogar'.
value labels VII2_4
96 "Servicio doméstico"			
97 "Otra persona que no vive en el hogar 98: Ninguna".
