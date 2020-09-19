# BiciMad Project

# Contents 

[Introduction](#introduction)

[Methodology and Tools](#Methodology-and-Tools)

[Data Acquisition](#Data-Acquisition)

[Data Exploration](#Data-Exploration)

[Models](#Modeling)

[Visualization](#Visualization)



# Introduction
Mi interés por desarrollar un proyecto sobre la movilidad sostenible de Madrid surge porque soy aficionada a montar en bici y además por el volumen de datos que se puede manejar y analizar sobre los movimientos de los usuarios. En la búsqueda de datos encontré la base de datos abierta de [EMT Madrid](https://opendata.emtmadrid.es/Datos-estaticos/Datos-generales-(1)) en la cual tienes acceso a los años y meses del sistema de bicicletas públicas de Madrid conocido como BiciMad. Para obtener los datos de los puntos de estacionamientos, me puse en contacto con el [Portal de datos abiertos del Ayuntamiento de Madrid](https://datos.madrid.es/sites/v/index.jsp?vgnextoid=e9b2a4059b4b7410VgnVCM2000000c205a0aRCRD&vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD) ya que los datos no estaban actualizados, fueron muy amables y a los pocos días los actualizaron. 

Después de realizar un brainstorming sobre las diferentes líneas de estudios a realizar, obtuve los siguientes objetivos:

- Análisis exploratorio de los puntos de estacionamientos.
- Análisis exploratorio del uso de bici utilizando los datos BiciMad de Enero 2018.
- Algoritmo que detecte el tipo de usuario.

# Methodology and Tools
El proyecto se ha realizado utilizando Google Colaboratory, es un entorno gratuito de Jupyter Notebook que no requiere configuración y se ejecuta en la nube. Para el desarrollo del código el lenguaje de programación que hemos usado ha sido Python para la limpieza, tratamiento, ejecución de datos así como las diferentes técnicas de Machine Learning. A continuación, indico las herramientas utilizadas:

- Entorno de desarrollo: Jupyter Notebook utilizandolo en Google Colaboratory
- Lenguaje de programación: Python 3.6
- Librerías para limpieza y tratamiento de datos: numpy, pandas.
- Librerías para visualización: matplotlib, seaborn, folium, bokeh, streamlit, altair.
- Librería para modelos: sklearn.

# Data Acquisition

## *Datos de puntos de estacionamientos*

Los datos de estacionamientos en el cual se obtiene la información de los puntos donde se pueden retirar bicicletas eléctricas. Este conjunto de datos recoge las siguientes variables: 

- Número de estación
- Gis_X
- Gis_Y
- Fecha de Alta
- Distrito
- Barrio
- Calle
- Nº de Finca
- Tipo de reserva
- Número de plazas
- Longitud
- Latitud
- Dirección

## *Datos BiciMad de Enero 2018*
El Dataset de BiciMad recoge los datos Enero 2018, codificados en formato JSON y obtenidos en el portal de datos abiertos de la [EMT Madrid](https://opendata.emtmadrid.es/Datos-estaticos/Datos-generales-(1)). Este conjunto de datos recoge las siguientes variables:

- Identificador del trayecto
- Código del usuario. Para una misma fecha, todos los movimientos de un mismo usuario.
- Número de la estación de la que se desengancha la bicicleta.
- Número de la base de la que se desengancha la bicicleta.
- Número de la estación en la que se engancha la bicicleta.
- Número de la base en la que se engancha la bicicleta.
- Franja horaria en la que se realiza el desenganche de la bicicleta.
- Tiempo total en segundos, entre el desenganche y el enganche de la bicicleta. 
- Detalle del trayecto realizado por la bicicleta entre la estación de partida y la de destino, en formato GeoJSON. 
- user_type: Número que indica el tipo de usuario que ha realizado el movimiento. Sus posibles valores son los siguientes:

  * 0: No se ha podido determinar el tipo de usuario
  * 1: Usuario anual (poseedor de un pase anual)
  * 2: Usuario ocasional
  * 3: Trabajador de la empresa 

- ageRange: Número que indica el rango de edad del usuario que ha realizado el movimiento. Sus posibles valores son:

  * 0: No se ha podido determinar el rango de edad del usuario
  * 1: El usuario tiene entre 0 y 16 años
  * 2: El usuario tiene entre 17 y 18 años
  * 3: El usuario tiene entre 19 y 26 años
  * 4: El usuario tiene entre 27 y 40 años
  * 5: El usuario tiene entre 41 y 65 años
  * 6: El usuario tiene 66 años o más 

- Código postal. El código postal del usuario que ha realizado el movimiento. 

# Data Exploration 

*Datos de puntos de estacionamientos*

- Dimensión del dataframe. Tiene 216 filas y 17 columnas.

``` df.shape
   (216, 17)
```` 

- Resumen de información del dataframe.

```python
df.info()
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 216 entries, 0 to 215
Data columns (total 17 columns):
 #   Column           Non-Null Count  Dtype  
---  ------           --------------  -----  
 0   id               216 non-null    object 
 1   Gis_X            216 non-null    object 
 2   Gis_Y            216 non-null    object 
 3   Fecha de Alta    216 non-null    object 
 4   Distrito         216 non-null    object 
 5   Barrio           216 non-null    object 
 6   Calle            216 non-null    object 
 7   Nº Finca         216 non-null    object 
 8   Tipo de Reserva  216 non-null    object 
 9   Anclajes         216 non-null    int64  
 10  Unnamed: 10      0 non-null      float64
 11  LONGITUD         216 non-null    float64
 12  LATITUD          216 non-null    float64
 13  DIRECCION        216 non-null    object 
 14  Year             216 non-null    int64  
 15  ids              216 non-null    int64  
 16  Locationlist     216 non-null    object 
dtypes: float64(3), int64(3), object(11)
````


*Datos de  BiciMad de Enero 2018*

- Dimensión del dataframe. Tiene 263701 registros y 11 columnas.

```python df.shape
   (263701, 11)`
````
- Resumen de información del dataframe.

```python
jan18.info()
<class 'pandas.core.frame.DataFrame'>
Int64Index: 263701 entries, 0 to 263701
Data columns (total 11 columns):
 #   Column            Non-Null Count   Dtype 
---  ------            --------------   ----- 
 0   id                263701 non-null  object
 1   user_day_code     263701 non-null  object
 2   idunplug_station  263701 non-null  int64 
 3   idunplug_base     263701 non-null  int64 
 4   idplug_station    263701 non-null  int64 
 5   idplug_base       263701 non-null  int64 
 6   user_type         263701 non-null  int64 
 7   travel_time       263701 non-null  int64 
 8   unplug_hourTime   263701 non-null  object
 9   ageRange          263701 non-null  int64 
 10  zip_code          263701 non-null  object
dtypes: int64(7), object(4)
````

*Unificación de datos de estacionamiento y datos de enero 2018*

Se realizo un cruce de datos entre los puntos de estacionamientos y los datos del mes de enero de 2018 con el objetivo de explorarlos en conjunto así como se crearon nuevas variables como distance, travel_minutes y count_travel.

```python
data.info()
<class 'pandas.core.frame.DataFrame'>
Int64Index: 2926629 entries, 0 to 2926628
Data columns (total 20 columns):
 #   Column             Dtype  
---  ------             -----  
 0   _id                object 
 1   user_day_code      object 
 2   idunplug_station   int64  
 3   Distrito_idunplug  object 
 4   Barrio_idunplug    object 
 5   Longitud_idunplug  float64
 6   Latitud_idunplug   float64
 7   idplug_station     int64  
 8   Distrito_idplug    object 
 9   Barrio_idplug      object 
 10  Longitud_idplug    float64
 11  Latitud_idplug     float64
 12  user_type          int64  
 13  travel_time        int64  
 14  unplug_hourTime    object 
 15  ageRange           int64  
 16  zip_code           object 
 17  travel_minutes     float64
 18  distance           float64
 19  count_travel       int64  
dtypes: float64(6), int64(6), object(8)
````
- Correlaciones entre las variables

1. *Correlaciones*
![Datos de correlaciones](<https://github.com/rasoco/master_data_science/blob/master/TFM/img/2_image.png>)

2. *Mapa de calor de las correlaciones*

![Mapa de correlaciones](<https://github.com/rasoco/master_data_science/blob/master/TFM/img/3_image.png>)


3. *Pairplot*

![Pairplot](<https://github.com/rasoco/master_data_science/blob/master/TFM/img/4_image.png>)

# Modeling
Para la predección del tipo de usuario hemos utilizado diferentes técnicas de Machine Learning. Por un lado, *Regresión Logística* se trata de un tipo de análisis de regresión utilizado para predecir el resultado de una variable categórica. Por otro lado, *K Nearest Neighbor Classifer*, conocido también como *K Vecinos,* es un algoritmo que almacena todos los casos disponibles y clasifica los casos nuevos basándose en una medida de similitud. 

Además, destacar que se ha utilizado algunos ML con tres variables independendientes y para otros cuatro variables.

Cabe mencionar que se han realizado predicciones utilizando el total de los datos del dataset (2926629) y por otro lado, se ha realizado un balanceo de los datos (18972) en función del tipo de usuario con el objetivo de homogenizar las muestras.

En total se han hecho 8 modelos, analizadas las métricas de cada modelo, hemos decidido implementar el modelo 4 de K Nearest Neighbor Classifer con balanceo de datos ya que sus métricas son notablemente mejores frente al resto. 

## Logistic Regression


- **Utilizando el total de los datos**

=Modelo 1:= Tiene una buena precisión global de 0.99. No obstante, no tiene buena Precisión, Recall ni f1-score cuando tiene que predecir en el perfil 2.
              
|Models/Metrics | Features | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes|   1        |    0.98    |   1.00  |   0.99   |  160080  |   
|1      |  distance     |   2        |    0.00    |   0.00  |   0.00   |   1874   |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  716035  |  
|   accuracy    |       |        |    |      | 0.99| 877989 |
|   macro avg     | |            |0.66  |0.66   |  0.66   | 877989|
|     weighted avg  |  |        |0.99 | 0.99 | 0.99 | 877989 |




|Models  | Features | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes distance|   1        |  0.98  |  1.00  | 0.99 | 160080 |   
|2     |  ageRange     |   2        |    0.00    |   0.00  |   0.00   |     1874  |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  716035|
|   accuracy    |       |        |    |      | 1.00 | 877989 |
|   macro avg     | |            |0.66  |0.66   |  0.66   | 877989|
|     weighted avg  |  |        |0.99 |1.00  | 0.99 | 877989 |

Tiene una buena precisión global de 1.00. No obstante, no tiene buena Precisión, Recall ni f1-score cuando tiene que predecir en el perfil 2.


- **Balanceo de datos**

|Models   | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes|   1        |    0.65    |  0.87   |     0.74     |  4487  |   
| 3    |  distance     |   2        |    0.80     |    0.53  |  0.63   |   4397   |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |   4396  | 
|   accuracy    |       |        |    |      | 0.80 | 13280 |
|   macro avg     | |            |0.81  |0.80  |  0.79  | 13280|
|     weighted avg  |  |        |0.81 | 0.80 | 0.79 | 13280 |

No tiene buena Recall ni f1-score cuando tiene que predecir en el perfil 2.


|Models | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes distance|   1      |    0.95     |   0.72  |   0.82   | 4487  |   
|4     |  ageRange    |   2        |    0.77   |   0.96  |   0.86     |   4397  |      
|       | count_travel  |   3        |    1.00    |    0.99 |   1.00   | 4396  |  
|   accuracy    |       |        |    |      | 0.89|13280 |
|   macro avg     | |            |0.90  |0.89  | 0.89   | 13280|
|     weighted avg  |  |        |0.91 | 0.89 | 0.89 | 13280 |


## K Nearest Neighbor Classifer


- **Utilizando el total de los datos**
              
|Models   | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes|   1        |    0.99     |   1.00  |  0.99   |  160080  |   
|1      |  distance     |   2        |    0.35    |    0.15   |  0.21   |   1874   |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  716035  | 
|   accuracy    |       |        |    |      | 1.00| 877989 |
|   macro avg     | |            |0.78  |0.72    |  0.73   | 877989|
|     weighted avg  |  |        |1.00  | 1.00 | 1.00  | 877989 |


|Models  | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes distance|   1        |     0.99    |   1.00  |   0.99   |  160080  |   
|2     |  ageRange     |   2        |   0.40    |   0.23  |   0.29    |   1874   |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  716035  | 
|   accuracy    |       |        |    |      | 1.00| 877989 |
|   macro avg     | |            |0.80  |0.74   |  0.76   | 877989|
|     weighted avg  |  |        |1.00 | 1.00 | 1.00 | 877989 |


- **Balanceo de datos**

|Models   | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes|   1        |     0.76     |  0.70 |   0.73  |  1837  |   
| 3    |  distance     |   2        |      0.74    |   0.80 |     0.76   |   1927   |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  1928  |  
|   accuracy    |       |        |    |      | 0.83| 5692 |
|   macro avg     | |            |0.83 |0.83   |  0.83   | 5692
|     weighted avg  |  |        |0.83 | 0.83 | 0.83 | 5692 |


|Models | Features      | Type User  | precision  |  recall | f1-score | support  |  
|-------|-------------  |------------|------------|---------|----------|----------|
|       | travel_minutes distance|   1        |    0.89    |   0.78   |  0.83   |  1837 |   
|4     |   ageRange    |   2        |   0.82 |   0.91  |   0.86  |  1927  |      
|       | count_travel  |   3        |    1.00    |   1.00  |   1.00   |  1928   |  
|   accuracy    |       |        |    |      | 0.90| 5692 |
|   macro avg     | |            |0.90  |0.90  |  0.90  | 5692|
|     weighted avg  |  |        |0.90 | 0.90 | 0.90 | 5692|


**Matriz de confusión del Modelo 4 con Balanceo de K Nearest Neighbor Classifer.**

![Matriz de confunsión sin normalizar](<https://github.com/rasoco/master_data_science/blob/master/TFM/img/6_image.png>)



![Matriz de confunsión normalizada](<https://github.com/rasoco/master_data_science/blob/master/TFM/img/5_image.png>)



# Visualization






