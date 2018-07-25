* Encoding: windows-1252.
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
    *******************************************************Diseño de Registro de BASE PERSONAS*****************************************************.
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************
    ***************************************************************************************************************************************************************.
    ** --> Las etiquetas y nombres de las variables están en función del Diseño de Registro del 2° trimestre de 2016 publicado por el INDEC.
    ** La sintaxis es de elaboración propia, no es oficial. Es sólo para la base usuaria INDIVIDUAL, aunque algunas variables se comparten con la base HOGAR y pueden correrse allí también.
    ** Cualquier error que encuentres, si podés, arreglalo y compartí las modificaciones. Sino avisame y lo corregimos.
   
    
    *Código para distinguir VIVIENDAS.
    variable labels CODUSU 'Código para distinguir VIVIENDAS, permite aparearlas con Hogares y Personas. Además permite hacer el seguimiento a través de los trimestres'.
    
    *Código para distinguir HOGARES.
    variable labels Nro_hogar ' Código para distinguir HOGARES, permite aparearlos con Personas'.
    
    *Número de componente.
    variable labels Componente 'Número de componente: N° de orden que se asigna a las personas que conforman cada hogar de la vivienda'.
    value labels Componente
    51 "Servicio Doméstico en hogares"
    71 "Pensionistas en hogares".
    
    *Entrevista individual realizada.
    variable labels H15 'Entrevista individual realizada'.
    value labels H15
    1 "Si"
    2 "No".
    
    *Año de relevamiento.
    variable labels ano4 'Año de relevamiento'.
    
    *Trimestre.
    variable labels Trimestre 'Ventana de Observación'.
    value labels trimestre
    1 "1er Trimestre"
    2 "2do Trimestre"
    3 "3er Trimestre"
    4 "4to Trimestre".
    
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
    
    ****Aglomerado.
    variable labels aglomerado 'Código de Aglomerado'.
    value labels aglomerado
    01 "Gran Buenos Aires"
    02 "Gran La Plata"
    03 "Bahía Blanca -Cerri"
    04 "Gran Rosario"
    05 "Gran Santa Fé"
    06 "Gran Panamá"
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
    
    *ch03 - Relación de parentesco.
    variable labels CH03 'Relación de parentesco'.
    value labels CH03 
    1 "Jefe/a"
    2 "Cónyuge / Pareja"
    3 "Hijo/a Hijastro/a"
    4 "Yerno/Nuera"
    5 "Nietro/a"
    6 "Madre/Padre"
    7 "Suegro/a"
    8 "Hermano/a"
    9 "Otros Familiares"
    10 "No familiares".
    
    *CH04 - Sexo.
    variable labels CH04 'Sexo'.
    value labels ch04
    1 "Varón"
    2 "Mujer".
    
    *CH05 - Fecha de Nacimiento.
    variable labels CH05 'Fecha de nacimiento (día, mes y año)'.
    
    *Ch06 - Edad en años cumplidos.
    variable labels ch06 'Edad en años cumplidos'.
    
    *ch07 - Situación conyugal.
    variable labels ch07 '¿Actuamente está...'.
    value labels ch07
    1 "unido?"
    2 "casado?"
    3 "separado/a o divorsiado/a?"
    4 "viudo/a?"
    5 "soltero/a?"
    9 "Ns/Nr".
    
    *Ch08 - Tipo de cobertura médica.
    variable labels ch08 'Tipo de cobertura médica'.
    value labels ch08
    1 "Obra social (incluye PAMI)"
    2 "Mutual / Prepaga / Servicio de emergencia"
    3 "Planes y seguros Públicos"
    4 "No paga ni le descuentan"
    9 "Ns./Nr."
    12 "Obra social y Mutual / Prepaga / Servicio de Emergencia"
    13 "Obra social y Planes y Seguros Públicos"
    23 "Mutual / Prepaga / Servicio de Emergencia / Planes y Seguros Públicos"
    123 "Obra social, mutual / prepaga / servicio de emergencia y planes y seguros p?bilcos".
    
    *ch09 - ¿Sabe leer y escribir?.
    variable labels ch09 '¿Sabe leer y escribir?'.
    value labels ch09
    1 "Sí"
    2 "No"
    3 "Menor de 2 años".
    
    
    *ch010 - ¿Asiste o asistió a algún establecimiento educativo? (colegio, escuela, universidad).
    variable labels ch10 '¿Asiste o asistió a algún establecimiento educativo? (colegio, escuela, universidad)'.
    value labels ch10
    1 "Sí, asiste"
    2 "No asiste, pero asistió"
    3 "Nunca asistió"
    9 "Ns/Nr".
    
    *Ch11 - Ese establecimiento es...
    variable labels Ch11 'Ese establecimiento es...'.
    value labels ch11
    1 "Público"
    2 "Privado"
    9 "Ns./Nr.".
    
    *ch12 - ¿Cuál es el nivel más alto que cursa o cursó?".
    variable labels ch12 '¿Cuál es el nivel más alto que cursa o cursó?'.
    value labels ch12
    1 "Jardín / Preescolar"
    2 "Primario"
    3 "EGB"
    4 "Secundario"
    5 "Polimodal"
    6 "Terciario"
    7 "Universitario"
    8 "Posgrado Univ."
    9 "Educación especial (discapacitado)"
    99 "Ns/Nr".
    
    *ch13 - ¿Finalizó ese nivel?.
    variable labels ch13 '¿Finalizó ese nivel?'.
    value labels ch13
    1 "Sí"
    2 "No"
    9 "Ns/Nr".
    
    *ch14 - ¿Cuál fue el último año que aprobó?.
    variable labels ch14 '¿Cuál fue el último año que aprobó?'.
    value labels ch14
    00 "Ninguno"
    01 "Primero"
    02 "Segundo"
    03 "Tercero"
    04 "Cuarto"
    05 "Quinto"
    06 "Sexto"
    07 "Síptimo"
    08 "Octavo"
    09 "Noveno"
    98 "Educación especial"
    99 "Ns/Nr".
    
    *Ch15 - ¿Dónde nació?.
    variable labels ch15 '¿Dónde nació?'.
    value labels ch15
    1 "En esta localidad"
    2 "En otra localidad de esta provincia"
    3 "En otra provincia (especificar)"
    4 "En un país limitrofe (especificar Brasil, Bolivia, Chile, Paraguay, Uruguay)"
    5 "En otro país (especificar)"
    9 "Ns./Nr.".
    
    *ch15_cod - Especificar: contiene código que corresponde a:.
    variable labels ch15_cod 'Especificar: contiene código que corresponde a: 3. En otra provincia 4. En un paìs limìtrofe 5. En otro país'.
    
    *Ch16 - ¿Dónde vivía hace 5 años?.
    variable labels ch16 '¿Dónde vivía hace 5 años?'.
    value labels ch16
    1 "En esta localidad"
    2 "En otra localidad de esta provincia"
    3 "En otra provincia (especificar)"
    4 "En un país limitrofe (especificar Brasil, Bolivia, Chile, Paraguay, Uruguay)"
    5 "En otro país (especificar)"
    6 "No había nacido"
    9 "Ns./Nr.".
    
    *ch16_cod - Especificar: contiene código que corresponde a:.
    variable labels ch16_cod 'Especificar: contiene código que corresponde a: 3. En otra provincia 4. En un paìs limìtrofe 5. En otro país'.
    
    *Nivel_ed - Nivel educativo.
    variable labels nivel_ed 'Nivel Educativo'.
    value labels nivel_ed
    1 "Primaria incompleta (incluye educación especial)"
    2 "Primaria completa"
    3 "Secundaria incompleta"
    4 "Secundaria completa"
    5 "Superior universitaria incompleta"
    6 "Superior universitaria completa"
    7 "Sin instrucción"
    9 "Ns./Nr.".
    
    
    *Estado - Condición de Actividad.
    variable labels estado 'Condición de actividad'.
    value labels estado
    0 "Entrevista individual no realizada (no respuesta al cuestionario individual)"
    1 "Ocupado"
    2 "Desocupado"
    3 "Inactivo"
    4 "Menor de 10 años".
    
    *Cat_Ocup - Categoría ocupacional.
    variable labels cat_ocup 'Categoría ocupacional'.
    value labels cat_ocup
    1 "Patrón"
    2 "Cuenta propia"
    3 "Obrero o empleado"
    4 "Trabajador familiar sin remuneración"
    9 "Ns./Nr.".
    
    *cat_inac - Categoría de inactividad.
    variable labels Cat_inac 'Categoría de inactividad'.
    value labels cat_inac
    1 "Jubilado / pensionado"
    2 "Rentista"
    3 "Estudiante"
    4 "Ama de casa"
    5 "Menor de 6 años"
    6 "Discapacitado"
    7 "Otros".
    
    *IMPUTA - Indica los casos que han sido imputados.
    variable labels IMPUTA 'Indica los casos que han sido imputados'.
    
    *PP02c1 - ¿De Qué manera estuvo buscando trabajo? - Hizo contactos, entrevistas.
    variable labels Pp02c1 '¿De Qué manera estuvo buscando trabajo? - Hizo contactos, entrevistas'.
    value labels pp02c1
    1 "Si"
    2 "No".
    
    *PP02c2 - ¿De Qué manera estuvo buscando trabajo? - Mandó curriculum, puso o contestó avisos.
    variable labels Pp02c2 '¿De Qué manera estuvo buscando trabajo? - Mandó curriculum, puso o contestó avisos'.
    value labels pp02c2
    1 "Si"
    2 "No".
    
    *PP02c3 - ¿De Qué manera estuvo buscando trabajo? - Se presentó en establecimientos.
    variable labels Pp02c3 '¿De Qué manera estuvo buscando trabajo? - Se presentó en establecimientos'.
    value labels pp02c3
    1 "Si"
    2 "No".
    
    *PP02c4 - ¿De Qué manera estuvo buscando trabajo? - Hizo algo para ponerse por su cuenta.
    variable labels Pp02c4 '¿De Qué manera estuvo buscando trabajo? - Hizo algo para ponerse por su cuenta'.
    value labels pp02c4
    1 "Si"
    2 "No".
    
    *PP02c5 - ¿De Qué manera estuvo buscando trabajo? - Puso carteles en negocios, preguntó en el barrio.
    variable labels Pp02c5 '¿De Qué manera estuvo buscando trabajo? - Puso carteles en negocios, preguntó en el barrio'.
    value labels pp02c5
    1 "Si"
    2 "No".
    
    *PP02c6 - ¿De Qué manera estuvo buscando trabajo? - Consultó a parientes, amigos.
    variable labels Pp02c6 '¿De Qué manera estuvo buscando trabajo? - Consultó a parientes, amigos'.
    value labels pp02c6
    1 "Si"
    2 "No".
    
    *PP02c7 - ¿De Qué manera estuvo buscando trabajo? - Se anotó en bolsas, listas, planes de empleo, agencias, contratistas o alguien le estpa buscando trabajo.
    variable labels Pp02c7 '¿De Qué manera estuvo buscando trabajo? - Se anotó en bolsas, listas, planes de empleo, agencias, contratistas o alguien le estpa buscando trabajo'.
    value labels pp02c7
    1 "Si"
    2 "No".
    
    *PP02c8 - ¿De Qué manera estuvo buscando trabajo? - BusCó trabajo de otra forma activa.
    variable labels Pp02c8 '¿De Qué manera estuvo buscando trabajo? - Buscó trabajo de otra forma activa'.
    value labels pp02c8
    1 "Si"
    2 "No".
    
    *Pp02e - Durante esos 30 días no busCó trabajo, porque...
    variable labels pp02e 'Durante esos 30 días no busCó trabajo, porque...'.
    value labels pp02e
    1 "está suspendido"
    2 "ya tiene trabajo asegurado"
    3 "se cansó de buscar tranajo"
    4 "hay poco trabajo en esta ?poca del año"
    5 "por otras razones".
    
    *pp02h - En los últimos 12 meses, ¿buscó trabajo en algún momento?.
    variable labels pp02h 'En los últimos 12 meses, ¿buscó trabajo en algún momento?'.
    value labels pp02h
    1 "Sí"
    2 "No".
    
    *pp02i - En los últimos 12 meses, ¿trabajó en algún momento?.
    variable labels pp02i 'En los últimos 12 meses, ¿trabajó en algún momento?'.
    value labels pp02i
    1 "Sí"
    2 "No".
    
    *pp03c - La semana pasada, ¿tenía...
    variable labels pp03c 'La semana pasada, ¿tenía...'.
    value labels pp03c
    1 "...un Sólo empleo / ocupación / actividad?"
    2 "...más de un empleo / ocupación / actividad?".
    
    *pp03d - Cantidad de ocupaciones.
    variable labels pp03d 'Cantidad de ocupaciones.'.
    
    *pp3e_tot - Total de horas que trabajó en la semana en la ocupación principal.
    variable labels pp3e_tot 'Total de horas que trabajó en la semana en la ocupación principal'.
    
    *pp3f_tot - Total de horas que trabajó en la semana en otras ocupaciones.
    variable labels pp3f_tot 'Total de horas que trabajó en la semana en otras ocupaciones'.
    
    *pp03g - La semana pasada, ¿quería trabajar más horas?.
    variable labels pp03g 'La semana pasada, ¿quería trabajar más horas?'.
    value labels pp03g
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
        
    *pp03h - Si hubiera conseguido más horas...
    variable labels pp03h 'Si hubiera conseguido más horas...'.
    value labels pp03h
    1 "podÍa trabajarlas esta semana"
    2 "podÍa empezar a trabajarlas en dos semanas a más tardar"
    3 "no podÍa trabajar más horas"
    9 "Ns./Nr.".    
    
    *pp03i - En los últimos 30 días, ¿buscó trabajar más horaSí.
    variable labels pp03i 'En los últimos 30 días, ¿buscó trabajar más horas?'.
    value labels pp03i
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
        
    *pp03j - Aparte de este/os trabajo/s, ¿estuvo buscando algún empleo / ocupación / actividad?.
    variable labels pp03j 'Aparte de este/os trabajo/s, ¿estuvo buscando algún empleo / ocupación / actividad?'.
    value labels pp03j
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
        
    *intensi - intensi.
    variable labels intensi 'INTENSI'.
    value labels intensi
    1 "Subocupado por insuficiencia horaria"
    2 "Ocupado pleno"
    3 "Sobreocupado"
    4 "Ocupado que no trabajó en la semana"
    9 "Ns./Nr.".
        
    *pp04a - El negocio / empresa / institución / actividad en la que trabaja es (se refiere al que trabaja más horas semanales)...
    variable labels pp04a 'El negocio / empresa / institución / actividad en la que trabaja es (se refiere al que trabaja más horas semanales)...'.
    value labels pp04a
    1 "...estatal"
    2 "...privada"
    3 "...de otro tipo"
    9 "Ns./Nr.".    
    
    *PP04B_COD - ¿A qué se dedica o produce el negocio / empresa / institución?.
    variable labels PP04B_COD '¿A qué se dedica o produce el negocio / empresa / institución?'.
        
    *pp04b1 - Si presta servicio doméstico en hogares particulares.
    variable labels pp04b1 'Si presta servicio doméstico en hogares particulares'.
    value labels pp04b1
    1 "Casa de familia"
    2 "No presta servicio doméstico en hogars particulares".
        
    *pp04b2 - ¿En cuántas casas trabaja?.
    variable labels pp04b2 '¿En cuántas casas trabaja?'.    
    
    *pp04b3_mes - Antigüedad en MES.
    variable labels PP04B3_MES '¿Cuánto tiempo hace que trabaja allí? - MES'.    
    
    *pp04b3_ANO - Antigüedad en AÑOS.
    variable labels PP04B3_ANO '¿Cuánto tiempo hace que trabaja allí? - AÑO'.
    
    
    *pp04b3_DIA - Antigüedad en DÍAS.
    variable labels PP04B3_DIA '¿Cuánto tiempo hace que trabaja allí? - DÍAS'.
        
    *PP04C - ¿Cuántas personas, incluído... trabajan allí en total?.
    variable labels pp04c '¿Cuántas personas, incluído... trabajan allí en total?'.
    value labels pp04c
    1 "1 persona"
    2 "2 personas"
    3 "3 personas"
    4 "4 personas"
    5 "5 personas"
    6 "6 a 10 personas"
    7 "11 a 25 personas"
    8 "26 a 40 personas"
    9 "de 41 a 100 personas"
    10 "de 101 a 200 personas"
    11 "de 201 a 500 personas"
    12 "más de 500 personas"
    99 "Ns./Nr.".
        
    *pp04c99 - Tamaño del establecimiento.
    variable labels pp04c99 'Tamaño del establecimiento'.
    value labels pp04c99
    1 "hasta 5"
    2 "de 6 a 40"
    3 "más de 40"
    9 "Ns./Nr.".
        
    *pp04D_cod - Código de ocupación para ocupados.
    VARIABLE labels PP04D_COD 'Código de ocupación'.    
    
    *pp04G - ¿Dónde realiza principalmente sus tareaS?.
    variable labels pp04G '¿Dónde realiza principalmente sus tareas?'.
    value labels pp04G
    1 "En un local / oficina / establecimiento / neogocio / taller / chacra / finca"
    2 "En un puesto o kiosko fijo callejero"
    3 "En vehículos: bicicleta, moto, autos, barcos, botes (no incluye servicio de transporte)"
    4 "En vehículos para transporte de personas y mercaderías -aéreo, marítimo, terrestre-"
    5 "En obras en construcción, de infraestructura, minería o similares"
    6 " En esta vivienda (sin lugar exclusivo)"
    7 "En la vivienda del socio o del patrón"
    8 "En el domicilio / local de los clientes"
    9 "En la calle, espacios públicos, ambulante, de casa en casa, puesto móvil callejero"
    10 "En otro lugar (especificar)"
    99 "Ns./Nr.".
    
    
    *pp05b2_MES - Ocupación Principal de los Trabajadores independientes - Antigüedad en meses.
    variable labels pp05b2_MES '¿Cuánto tiempo hace que trabaja en ese emppleo en forma contínua? - MES'.
    
    
    *pp05b2_ANO - Ocupación Principal de los Trabajadores independientes - Antigüedad en años.
    variable labels pp05b2_ANO '¿Cuánto tiempo hace que trabaja en ese emppleo en forma contínua? - AÑO'.
    
    
    *pp05b2_DIA - Ocupación Principal de los Trabajadores independientes - Antigüedad en días.
    variable labels pp05b2_DIA '¿Cuánto tiempo hace que trabaja en ese emppleo en forma contínua? - DIA'.
    
    *pp05c_1 - ¿En ese negocio / empresa / actividad, tiene maquinarias / equipos?.
    variable labels pp05c_1 '¿En ese negocio / empresa / actividad, tiene... maquinarias / equipos?'.
    value labels pp05c_1
    1 "Propio (del negocio)"
    2 "Prestado / alquilado"
    3 "No tiene"
    9 "Ns./Nr.".
    
    
    *pp05c_2 - ¿En ese negocio / empresa / actividad, tiene local (incluye kiosko, puesto fijo)?.
    variable labels pp05c_2 '¿En ese negocio / empresa / actividad, tiene... local (incluye kiosko, puesto fijo)?'.
    value labels pp05c_2
    1 "Propio (del negocio)"
    2 "Prestado / alquilado"
    3 "No tiene"
    9 "Ns./Nr.".
    
    
    *pp05c_3 - ¿En ese negocio / empresa / actividad, tiene vehículo?.
    variable labels pp05c_3 '¿En ese negocio / empresa / actividad, tiene... vehículo?'.
    value labels pp05c_3
    1 "Propio (del negocio)"
    2 "Prestado / alquilado"
    3 "No tiene"
    9 "Ns./Nr.".
    
    
    *pp05E - ¿Para la actividad del negocio, en los últimos 3 meses, tuvo que gastar en la compra de materias primas, productos, pagar servicios u otros gastos?.
    variable labels pp05E '¿Para la actividad del negocio, en los últimos 3 meses, tuvo que gastar en la compra de materias primas, productos, pagar servicios u otros gastos?'.
    value labels pp05E
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp05f - Ese negocio / empresa / actividad, trabaja habitualmente para...
    variable labels pp05F '¿Ese negocio / empresa / actividad, trabaja habitualmente para...'.
    value labels pp05F
    6 "un sólo cliente? (persona, empresa)"
    7 "distintos clientes? (incluye público en general)"
    9 "Ns./Nr.".
    
    
    *pp05H - ¿Durante cuánto tiempo ha estado trabajando en ese empleo de forma contínua?.
    variable labels pp05H '¿Durante cuánto tiempo ha estado trabajando en ese empleo de forma contínua? (con interrupciones laborales no mayores a 15 días)'.
    value labels pp05H
    1 "Menos de 1 mes"
    2 "De 1 a 3 meses"
    3 "Más de 3 a 6 meses"
    4 "Más de 6 meses a 1 año"
    5 "Más de 1 año a 5 años"
    6 "Más de 5 años"
    9 "Ns./Nr.".
    
    
    *pp06A - ¿En ese negocio / empresa / actividad ¿tiene socios o familiares asociados?.
    variable labels pp06A '¿En ese negocio / empresa / actividad ¿tiene socios o familiares asociados?'.
    value labels pp06A
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp06C - Monto de patrones y cuenta propia sin socios percibido este mes.
    weight off.
    use all.
    variable labels pp06C 'Monto de patrones y cuenta propia sin socios'.
    value labels pp06c
    -7 "No tenìa esa ocupaciòn"
    -8 "No tuvo ingresos".
    
    
    *pp06D - Monto de patrones y cuenta propia con socios percibidos en ese mes.
    variable labels pp06D 'Monto de patrones y cuenta propia con socios'.
    value labels pp06d
    -7 "No tenìa esa ocupaciòn"
    -8 "No tuvo ingresos".
    
    
    *pp06E - ¿Ese negocio / empresa / actividad...
    variable labels pp06E '¿Ese negocio / empresa / actividad...'.
    value labels pp06E
    1 "...es una sociedad jurídicamente constituída? (SA, SRL, comandita por acciones, etc.)"
    2 "... es una sociedad de otra forma legal?"
    3 "...o es una sociedad convenida de palabra?"
    9 "Ns./Nr.".
    
    
    *pp06H - ¿Es una actividad familiar?.
    variable labels pp06H '¿Es una actividad familiar?'.
    value labels pp06H
    1 "Sí"
    2 "No".
    
    
    *pp07A - ¿Cuánto tiempo hace que está trabajando en ese empleo en forma contínua?.
    variable labels pp07A '¿Cuánto tiempo hace que está trabajando en ese empleo en forma contínua? (sin interrupcción de la relación laboral en la misma empresa / negocio / institución)'.
    value labels pp07A
    1 "Menos de 1 mes"
    2 "1 a 3 meses"
    3 "Más de 3 a 6 meses"
    4 "Más de 6 a 12 meses"
    5 "Más de 1 a 5 años"
    6 "Más de 5 años"
    9 "Ns./Nr.".
    
    
    *pp07C - ¿Ese empleo tiene tiempo de finalización?.
    variable labels pp07C '¿Ese empleo tiene tiempo de finalización?'.
    value labels pp07C
    1 "Sí (incluye changa, trabajo transitorio, por tarea u obra, suplencia, etc.)"
    2 "No (incluye permanente, fijo. estable, de planta)"
    9 "Ns./Nr.".
    
    
    *pp07D - ¿Por cuánto tiempo es ese trabajo?.
    variable labels pp07D '¿Por cuánto tiempo es ese trabajo?'.
    value labels pp07D
    1 "sólo fue esa vez / sólo cuando lo miran"
    2 "hasta 3 meses"
    3 "más de 3 a 6 meses"
    4 "más de 6 a 12 meses"
    5 "más de 1 año"
    9 "Ns./Nr.".
    
    
    *pp07E - ¿Ese trabajo es...?.
    variable labels pp07E '¿Ese trabajo es...?'.
    value labels pp07E
    1 "...un plan de empleo"
    2 "...un período de prueba"
    3 "...una beca / pasantía / aprendizaje"
    4 "Ninguno de estos"
    9 "Ns./Nr.".
    
    
    *pp07F1 - En ese trabajo le dan... de comer gratis en el lugar de trabajo.
    variable labels pp07F1 '¿En ese trabajo le dan... de comer gratis en el lugar de trabajo'.
    value labels pp07F1
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp07F2 - ¿En ese trabajo le dan... vivienda?.
    variable labels pp07F2 '¿En ese trabajo le dan... vivienda?'.
    value labels pp07F2
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp07F3 - ¿En ese trabajo le dan... algún producto o mercadería?.
    variable labels pp07F3 '¿En ese trabajo le dan... algún producto o mercadería?'.
    value labels pp07F3
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp07F4 - ¿En ese trabajo le dan... algún producto o mercadería?.
    variable labels pp07F4 '¿En ese trabajo le dan... aglún otro beneficio? (automóvil, teléfono celular, pasajes, etc.)'.
    value labels pp07F4
    1 "Sí"
    2 "No"
    9 "Ns./Nr.".
    
    *pp07F5 - ¿En ese trabajo le dan... no recibe ninguno?.
    variable labels pp07F5 '¿En ese trabajo le dan... no recibe ninguno?'.
    value labels pp07F5
    5 "No recibe ninguno"
    9 "Ns./Nr.".
    
    
    *pp07G1 - ¿En ese trabajo tiene... vacaciones pagas?.
    variable labels pp07G1 '¿En ese trabajo tiene... vacaciones pagas?'.
    value labels pp07G1
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    *pp07G2 - ¿En ese trabajo tiene... aguinaldo?.
    variable labels pp07G2 '¿En ese trabajo tiene... aguinaldo?'.
    value labels pp07G2
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    *pp07G3 - ¿En ese trabajo tiene... días pagos por enfermedad?.
    variable labels pp07G3 - ¿En ese trabajo tiene... días pagos por enfermedad?.
    value labels pp07G3
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    *pp07G4 - ¿En ese trabajo tiene... obra social?.
    variable labels pp07G4 - ¿En ese trabajo tiene... obra social?.
    value labels pp07G4
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    *PP07G_59 - ¿En ese trabajo tiene... no tiene ninguno?.
    variable labels PP07G_59 - ¿En ese trabajo tiene... no tiene ninguno?.
    value labels  PP07G_59
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    
    *pp07H - ¿Por ese trabajo tiene descuento jubilatorio?.
    variable labels pp07H '¿Por ese trabajo tiene descuento jubilatorio?'.
    value labels pp07H
    1 "Sí"
    2 "No".
    
    *pp07I - ¿Aporta por sí mismo a algún sistema jubilatorio?.
    variable labels pp07I '¿Aporta por sí mismo a algún sistema jubilatorio?'.
    value labels pp07I
    1 "Sí"
    2 "No".
    
    *pp07j - ¿El turno habitual de trabajo es...?.
    variable labels pp07j '¿El turno habitual de trabajo es...?'.
    value labels pp07j
    1 "...de día"
    2 "...de noche"
    3 "...de otro tipo (rotativo, día y noche, guardias con franco".
    
    *pp07K - ¿Cuándo cobra...?.
    variable labels pp07k '¿Cuándo cobra...'.
    value labels pp07k
    1 "...le dan recibo con sello / membrete / firma del empleador?"
    2 "...le dan un papel / recibo sin nada?"
    3 "...entrega una factura?"
    4 "...no le dan ni entrega nada?"
    5 "...no cobra, es trabajador sin pago / ad-honorem?".
    
    *PP08D1 - ¿Cuánto cobró por ese mes por esos conceptos? Monto total de sueldos/jornales, salario familiar, horas extras, otras bonificaciones habituales y tickets, vales o similares.
    variable labels PP08D1 '¿Cuánto cobró por ese mes por esos conceptos? Monto total de sueldos/jornales, salario familiar, horas extras, otras bonificaciones habituales y tickets, vales o similares'.
    
    *PP08D4 - Por el mes de...(mes)....¿cobró... Monto percibido en tickets.
    variable labels PP08D4 'Por el mes de...(mes)....¿cobró... Monto percibido en tickets.'.
    
    *PP08F1 - ¿Cuánto cobró por ese mes de ..(mes)... Monto en pesos cobrado por Comisión por venta/producción.
    variable labels PP08F1 '¿Cuánto cobró por ese mes de ..(mes)... Monto en pesos cobrado por Comisión por venta/producción.'.
    
    *PP08F2 - ¿Cuánto cobró por ese mes de ..(mes)... Monto en pesos cobrado por Propinas.
    variable labels PP08F2 '¿Cuánto cobró por ese mes de ..(mes)... Monto en pesos cobrado por Propinas.'.
    
    *PP08J1 - ¿Cuánto cobró por ese mes de ..(mes)... Monto aguinaldo.
    variable labels PP08J1 '¿Cuánto cobró por ese mes de ..(mes)... Monto aguinaldo.'.
    
    *PP08J2 - ¿Cuánto cobró por ese mes de ..(mes)... Monto otras bonificaciones no habituales.
    variable labels PP08J2 '¿Cuánto cobró por ese mes de ..(mes)... Monto otras bonificaciones no habituales.'.
    
    *PP08J3 - ¿Cuánto cobró por ese mes de ..(mes)... Monto retroactivos.
    variable labels PP08J3 '¿Cuánto cobró por ese mes de ..(mes)... Monto retroactivos.'.
    
    *PP09A - SOLO OCUPADOS DE: CIUDAD DE BUENOS AIRES  Partidos del GBA En su ocupación (o en la de más horas)¿trabaja....en ....
    variable labels PP09A 'SOLO OCUPADOS DE: CIUDAD DE BUENOS AIRES  Partidos del GBA En su ocupación (o en la de más horas)¿trabaja....en ....'.
    value labels PP09A
    1 "Ciudad de Buenos Aires"
    2 "Partidos del GBA"
    3 "Ambos"
    4 "En otro lugar".
    
    *PP09A_ESP - Especificar: contiene la descripción de otro lugar.
    variable labels PP09A_ESP 'Especificar: contiene la descripción de otro lugar.'.
    
    *pp09b - En su ocupación (o en la de más horas), trabaja... en esta ciudad?.
    variable labels pp09b 'En su ocupación (o en la de más horas), trabaja... en esta ciudad?'.
    value labels pp09b
    1 "Sì"
    2 "No".
    
    *pp09c - ¿Dónde trabaja...?.
    variable labels pp09c '¿Dónde trabaja...?'.
    value labels pp09c
    1 "En otro lugar de esta provincia"
    2 "En otra provincia"
    3 "En otro país".
    
    *PP09C_ESP - Descripción de otro lugar (según pregunta PP09C).
    variable labels PP09C_ESP 'Descripción de otro lugar (según pregunta PP09C).'.
    
    *pp10a - ¿Cuánto hace que está buscando trabajo..?.
    variable labels pp10a '¿Cuánto hace que está buscando trabajo..?'.
    value labels pp10a
    1 "Menos de 1 mes"
    2 "De 1 a 3 meses"
    3 "Más de 3 a 6 meses"
    4 "Más de 6 a 12 meses"
    5 "Más de 1 año".
    
    *pp10c - ¿Durante ese tiempo hizo algún trabajo / changa.
    variable labels pp10c '¿Durante ese tiempo hizo algún trabajo / changa'.
    value labels pp10c
    1 "Sí"
    2 "No".
    
    *pp10d - ¿Has trabajdo alguna vez?.
    variable labels pp10d '¿Has trabajdo alguna vez?'.
    value labels pp10d
    1 "Sí"
    2 "No".
    
    *pp10e - ¿Cuánto tiempo hace que terminó su último trabajo / changa?.
    variable labels pp10e '¿Cuánto tiempo hace que terminó su último trabajo / changa?'.
    value labels pp10e
    1 "Menos de 1 mes"
    2 "De 1 a 3 meses"
    3 "más de 3 a 6 meses"
    4 "Más de 6 a 12 meses"
    5 "Más de 1 a 3 años"
    6 "Más de 3 años".
    
    *pp11a - ¿El negocio / empresa / institución / actividad en la que trabaja era...?.
    variable labels pp11a '¿El negocio / empresa / institución / actividad en la que trabaja era...?'.
    value labels pp11a
    1 "Estatal"
    2 "Privado"
    3 "De otro tipo".
    
    *PP11B_COD - A qué se dedicaba ó que producía ese negocio/empresa/institución? (Ver Clasificador de Rama de Actividad  CAESMERCOSUR).
    variable labels PP11B_COD 'A qué se dedicaba ó que producía ese negocio/empresa/institución?'.
    
    *pp11b1 - Si prestaba servicios domésticos en hogares particulares.
    variable labels pp11b1 'Si prestaba servicios domésticos en hogares particulares,'.
    value labels pp11b1
    1 "Casa de familia".
    
    *pp11b2 - ¿Cuánto tiempo trabajó allí?.
    variable labels pp11b2_dia '¿Cuánto tiempo trabajó allí? - DIAS'.
    variable labels pp11b2_mes '¿Cuánto tiempo trabajó allí? - MESES'.
    variable labels pp11b2_ano '¿Cuánto tiempo trabajó allí? - AÑOS'.
    
    *pp11c - ¿Cuántas personas, inluído ... trabajan allí en total?.
    variable labels pp11c '¿Cuántas personas, inluído ... trabajan allí en total?'.
    value labels pp11c
    1 "1 persona"
    2 "2 personas"
    3 "3 personas"
    4 "4 personas"
    5 "5 personas"
    6 "6 a 10 personas"
    7 "11 a 25 personas"
    8 "26 a 40 personas"
    9 "41 a 100 personas"
    10 "101 a 200 personas"
    11 "201 a 500 personas"
    12 "Más de 500 personas"
    99 "Ns./Nr.".
    
    *pp11c99 - Ns./Nr. cuántas personas trabajan allí en total.
    variable labels pp11c99 'Ns./Nr. cuántas personas trabajan allí en total'.
    value labels pp11c99
    1 "Hasta 5 personas"
    2 "De 6 a 40 personas"
    3 "Más de 40 personas"
    9 "Ns./Nr.".
    
    *PP11D_COD - Cómo se llamaba la ocupación que tenía? (Ver Clasificador Nacional de Ocupaciones  CNO, versión 2001).
    variable labels PP11D_COD 'Cómo se llamaba la ocupación que tenía?'.
    
    *pp11g - ¿Cuánto tiempo seguido estuvo trabajando en ese lugar?.
    variable labels pp11g_ANO '¿Cuánto tiempo seguido estuvo trabajando en ese lugar? - AÑO'.
    variable labels pp11g_MES '¿Cuánto tiempo seguido estuvo trabajando en ese lugar? - MES'.
    variable labels pp11g_DIA '¿Cuánto tiempo seguido estuvo trabajando en ese lugar? - DIA'.
    
    *PP11L - ¿Cuál fue la razón principal por la que dejó esa actividad?.
    variable labels PP11L '¿Cuál fue la razón principal por la que dejó esa actividad?'.
    value labels PP11L
    1 "falta de clientes/clientes que no pagan"
    2 "falta de capital/equipamiento"
    3 "trabajo estacional"
    4 "tenía gastos demasiado altos"
    5 "otras causas laborales (especificar)"
    6 "jubilación/retiro"
    7 "causas personales (matrimonio, embarazo cuidado de hijos o familiar, estudio, enfermedad)".
    
    *PP11L1 - ¿Ese trabajo era...
    variable labels PP11L1 '¿Ese trabajo era...'.
    value labels PP11L1
    1 "...una changa, trabajo transitorio, por tarea u obra, suplencia, etc?"
    2 "...un trabajo permanente, fijo, estable, de planta, etc.?"
    3 "Ns./Nr.".
    
    *PP11M - Ese trabajo era...
    variable labels PP11M - 'Ese trabajo era...'.
    value labels PP11M
    1 "...un plan de empleo?"
    2 "...un período de prueba?"
    3 "...otro tipo de trabajo?".
    
    *pp11n - ¿En ese trabajo lehacían descuento jubilatorio?.
    variable labels pp11n '¿En ese trabajo lehacían descuento jubilatorio?'.
    value labels pp11n
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    use all.
    weight off.
    
    
    
    *pp11o - ¿Cuál fue la razón principal por la que dejó ese trabajo?.
    variable labels pp11o '¿Cuál fue la razón principal por la que dejó ese trabajo?'.
    value labels pp11o
    1 "Despido / cierre (quiebre/venta/traslado de la empresa/reestructuración o recorte de personal/falta de ventas o clientes"
    2 "Por retiro voluntario del sector público"
    3 "Por jubilación"
    4 "Fin de tranajo temporario / estacional"
    5 "Le pagaban poco / no le pagaban"
    6 "Malas relaciones laborales / malas condiciones de trabajo (insalubre, cambios de horarios, etc.)"
    7 "Renuncia obligada / pactada"
    8 "Otras causas laborales"
    9 "Por razones personales (matrimonio, embarazo, cuidado de hijos o la familia, estudio, enfermedad)".
        
    *pp11p - ¿Cerró la empresa?.
    variable labels pp11p '¿Cerró la empresa?'.
    value labels pp11p
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    *pp11q - ¿Fué la única persona que quedó sin trabajo?.
    variable labels pp11q  '¿Fué la única persona que quedó sin trabajo?'.
    value labels pp11q
    1 "Si"
    2 "No"
    9 "Ns./Nc.".
    
    
    *pp11r - ¿Le enviaron telegrama?.
    variable labels pp11r '¿Le enviaron telegrama?'.
    value labels pp11r
    1 "Si"
    2 "No".
    
    
    *pp11s - ¿Le pagaron indemnización?.
    variable labels pp11s '¿Le pagaron indemnización?'.
    value labels pp11s
    1 "Si"
    2 "No".
    
    
    *pp11t - ¿Está cobrando seguro de desempleo?.
    variable labels pp11t '¿Está cobrando seguro de desempleo?'.
    value labels pp11t
    1 "Si"
    2 "No"
    9 "Ns./Nr.".
    
    ** Ingresos de la ocupación principal.
    *p21 - MONTO DE INGRESO DE LA OCUPACIÓN PRINCIPAL.
    variable labels p21 'MONTO DE INGRESO DE LA OCUPACIÓN PRINCIPAL.'.
    
    *DECOCUR - Nº de decil de ingreso de la ocupación principal del TOTAL EPH.
    variable labels DECOCUR 'Nº de decil de ingreso de la ocupación principal del TOTAL EPH.'.
    
    *IDECOCUR - Nº de decil de ingreso de la ocupación principal del INTERIOR EPH.
    variable labels IDECOCUR 'Nº de decil de ingreso de la ocupación principal del INTERIOR EPH'.
    
    *RDECOCUR - Nº de decil de ingreso de la ocupación principal de la REGION.
    variable labels RDECOCUR 'Nº de decil de ingreso de la ocupación principal de la REGION'.
    
    *GDECOCUR - Nº de decil de ingreso de la ocupación principal del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.
    variable labels GDECOCUR 'Nº de decil de ingreso de la ocupación principal del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES'.
    
    *PDECOCUR - Nº de decil de ingreso de la ocupación principal del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.
    variable labels PDECOCUR 'Nº de decil de ingreso de la ocupación principal del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES'.
    
    *ADECOCUR - Nº de decil de ingreso de la ocupación principal del AGLOMERADO.
    variable labels ADECOCUR 'Nº de decil de ingreso de la ocupación principal del AGLOMERADO.'.
    
    *PONDIIO - Ponderador del ingreso de la ocupación principal.
    variable labels PONDIIO 'Ponderador del ingreso de la ocupación principal.'.
    
    ** Ingreso de otras ocupaciones.
    *Tot_p12 - MONTO DE INGRESO DE OTRAS OCUPACIONES. (Incluye: ocupación secundaria, ocupación previa a la semana de referencia, deudas/retroactivos por
    ocupaciones anteriores al mes de referencia, etc).
    variable labels Tot_p12 'MONTO DE INGRESO DE OTRAS OCUPACIONES. (Incluye: ocupación secundaria, ocupación previa a la semana de referencia, deudas/retroactivos por ocupaciones anteriores al mes de referencia, etc).'.
    
    ** Ingreso total individual.
    *p47T - MONTO DE INGRESO TOTAL INDIVIDUAL(sumatoria ingresos laborales y no laborales).
    variable labels p47T 'MONTO DE INGRESO TOTAL INDIVIDUAL(sumatoria ingresos laborales y no laborales).'.
    
    *DECINDR - Nº de decil de ingreso total individual del TOTAL EPH.
    variable labels DECINDR 'Nº de decil de ingreso total individual del TOTAL EPH.'.
    
    *IDECINDR - Nº de decil de ingreso total individual del INTERIOR EPH.
    variable labels IDECINDR 'Nº de decil de ingreso total individual del INTERIOR EPH.'.
    
    *RDECINDR - Nº de decil de ingreso total individual de la REGION.
    variable labels RDECINDR 'Nº de decil de ingreso total individual de la REGION.'.
    
    *GDECINDR - Nº de decil de ingreso total individual del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.
    variable labels GDECINDR 'Nº de decil de ingreso total individual del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.'.
    
    *PDECINDR - Nº de decil de ingreso total individual del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.
    variable labels PDECINDR 'Nº de decil de ingreso total individual del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.'.
    
    *ADECINDR - Nº de decil de ingreso total individual del AGLOMERADO.
    variable labels ADECINDR 'Nº de decil de ingreso total individual del AGLOMERADO.'.
    
    *PONDII - Ponderador para ingreso total individual.
    variable labels PONDII 'Ponderador para ingreso total individual.'.
    
    ** Ingresos no laborales.
    *V2_M N - Monto del ingreso por JUBILACION O PENSION.
    variable labels V2_M 'Monto del ingreso por JUBILACION O PENSION.'.
    
    *V3_M - Monto del ingreso por INDEMNIZACION POR DESPIDO.
    variable labels V3_M 'Monto del ingreso por INDEMNIZACION POR DESPIDO.'.
    
    *V4_M - Monto del ingreso por SEGURO DE DESEMPLEO.
    variable labels V4_M 'Monto del ingreso por SEGURO DE DESEMPLEO.'.
    
    *V5_M - Monto del ingreso por SUBSIDIO O AYUDA SOCIAL (EN DINERO) DEL GOBIERNO, IGLESIAS, ETC.
    variable labels V5_M 'Monto del ingreso por SUBSIDIO O AYUDA SOCIAL (EN DINERO) DEL GOBIERNO, IGLESIAS, ETC.'.
    
    * V8_M - Monto del ingreso por ALQUILER (VIVIENDA , TERRENO, OFICINA, ETC.) DE SU PROPIEDAD.
    variable labels V8_M 'Monto del ingreso por ALQUILER (VIVIENDA , TERRENO, OFICINA, ETC.) DE SU PROPIEDAD.'.
    
    *V9_M - Monto del ingreso por GANANCIAS DE ALGUN NEGOCIO EN EL QUE NO TRABAJÓ.
    variable labels V9_M 'Monto del ingreso por GANANCIAS DE ALGUN NEGOCIO EN EL QUE NO TRABAJÓ.'.
    
    *V10_M - Monto del ingreso por INTERESES O RENTAS POR PLAZOS FIJOS/INVERSIONES.
    variable labels V10_M 'Monto del ingreso por INTERESES O RENTAS POR PLAZOS FIJOS/INVERSIONES.'.
    
    *V11_M - Monto del ingreso por BECA DE ESTUDIO.
    variable labels V11_M 'Monto del ingreso por BECA DE ESTUDIO.'.
    
    *V12_M - Monto del ingreso por CUOTAS DE ALIMENTOS O AYUDA EN DINERO DE PERSONAS QUE NO VIVEN EN EL HOGAR.
    variable labels V12_M 'Monto del ingreso por CUOTAS DE ALIMENTOS O AYUDA EN DINERO DE PERSONAS QUE NO VIVEN EN EL HOGAR.'.
    
    *V18_M - Monto del ingreso por OTROS INGRESOS EN EFECTIVO (LIMOSNAS, JUEGOS DE AZAR, ETC.).
    variable labels V18_M 'Monto del ingreso por OTROS INGRESOS EN EFECTIVO (LIMOSNAS, JUEGOS DE AZAR, ETC.).'.
    
    *V19_AM - Monto del ingreso por TRABAJO DE MENORES DE 10 AÑOS.
    variable labels V19_AM 'Monto del ingreso por TRABAJO DE MENORES DE 10 AÑOS.'.
    
    *V21_M - Monto del ingreso por aguinaldo.
    variable labels V21_M 'Monto del ingreso por aguinaldo.'.
    
    *T_Vi - MONTO TOTAL DE INGRESOS NO LABORALES.
    variable labels T_Vi 'MONTO TOTAL DE INGRESOS NO LABORALES'.
    
    ** Ingreso total familiar
    *ITF - MONTO DEL INGRESO TOTAL FAMILIAR.
    variable labels ITF 'MONTO DEL INGRESO TOTAL FAMILIAR.'.
    
    *DECIFR - Nº de decil de ingreso total familiar del TOTAL.
    variable labels DECIFR 'Nº de decil de ingreso total familiar del TOTAL.'.
    
    *IDECIFR - Nº de decil de ingreso total familiar del INTERIOR.
    variable labels IDECIFR 'Nº de decil de ingreso total familiar del INTERIOR.'.
    
    *RDECIFR - Nº de decil de ingreso total familiar de la REGION.
    variable labels RDECIFR 'Nº de decil de ingreso total familiar de la REGION.'.
    
    *GDECIFR - Nº de decil de ingreso total familiar del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.
    variable labels GDECIFR 'Nº de decil de ingreso total familiar del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.'.
    
    *PDECIFR - Nº de decil de ingreso total familiar del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.
    variable labels PDECIFR 'Nº de decil de ingreso total familiar del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.'.
    
    *ADECIFR - Nº de decil de ingreso total familiar del AGLOMERADO (ver Anexo I).
    variable labels ADECIFR 'Nº de decil de ingreso total familiar del AGLOMERADO (ver Anexo I).'.
    
    ** Ingreso per cápita familiar
    *IPCF - MONTO DEL INGRESO PER CÁPITA FAMILIAR.
    variable labels IPCF 'MONTO DEL INGRESO PER CÁPITA FAMILIAR.'.
    
    *DECCFR - Nº de decil de ingreso per cápita familiar del TOTAL EPH (ver Anexo I).
    variable labels DECCFR 'Nº de decil de ingreso per cápita familiar del TOTAL EPH (ver Anexo I).'.
    
    *IDECCFR - Nº de decil de ingreso per cápita familiar del  INTERIOR EPH (ver Anexo I).
    variable labels IDECCFR 'Nº de decil de ingreso per cápita familiar del  INTERIOR EPH (ver Anexo I).'.
    
    *RDECCFR - Nº de decil de ingreso per cápita familiar de la REGION.
    variable labels RDECCFR 'Nº de decil de ingreso per cápita familiar de la REGION.'.
    
    *GDECCFR - Nº de decil de ingreso per cápita familiar del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.
    variable labels GDECCFR 'Nº de decil de ingreso per cápita familiar del CONJUNTO DE AGLOMERADOS DE 500 MIL Y MAS HABITANTES.'.
    
    *PDECCFR - Nº de decil de ingreso per cápita familiar del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.
    variable labels PDECCFR 'Nº de decil de ingreso per cápita familiar del CONJUNTO DE AGLOMERADOS DE MENOS DE 500 MIL HABITANTES.'.
     
    *ADECCFR - Nº de decil de ingreso per cápita familiar del AGLOMERADO.
    variable labels ADECCFR 'Nº de decil de ingreso per cápita familiar del AGLOMERADO.'.
    
    *PONDIH - Ponderador del ingreso total familiar y del ingreso per capita familiar, para hogares.
    variable labels PONDIH 'Ponderador del ingreso total familiar y del ingreso per capita familiar, para hogares.'.
    

