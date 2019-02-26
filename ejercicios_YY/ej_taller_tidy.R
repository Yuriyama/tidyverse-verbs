install.packages("vcdExtra")
install.packages("nycflights13")

library(lubridate)
library(nycflights13)
library(vcdExtra)
library(tidyverse)

datasets("nycflights13")

#Checo cómo es la tabla
flights %>% head
flights$carrier
flights$flight
flights$origin

#Busco los vuelos que se retrasan más de 2 horas (al salir)
filter(flights, dep_delay >= 120) #%>% head

#Busco cuáles son los vuelos que salen en verano (Junio, Julio y Agosto)
filter(flights, month == 6 | month == 7 | month == 8) %>% head

#Info de la tabla
?flights

#Arrange ejercicios

#Vuelos más cortos
arrange(flights, desc(distance)) %>% head

flights$distance %>% head

#Vuelos más largos
arrange(flights, distance) %>% head

#Select ejercicios
#¿De cuántas maneras puedo llamar a las variables
#dep_time, dep_delay_time, arr_time, arr_delay_time
#empieza con arr_ o con dep_
select(flights, matches("^arr_|^dep_"))

#Mutate ejercicios
#Utilizar la función str_sub dentro de stringr
#para extraer únicamente el día del campo 
#time_hour

#Summrise ejercicios
#Calcular las medias de las variables date, dep_delay, arr_delay y que remueva los na's
dplyr::summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
dplyr::summarise(flights, delay = mean(arr_delay, na.rm = TRUE))
dplyr::summarise(flights, media_date = mean(time_hour, na.rm = TRUE))


#Group_by ejercicios
#Función top_n y group_by, arrange y summarise
#para extraer los 10 aviones por aerolíneas con el menor
#promedio de velocidad

#antes, velocidad:
mutate(flights,
       velocidad = distance / air_time * 60
)
#ahora la tabla flights ya tiene 20 columnas, con vel
#no se queda con 20
flights %>% head


mutate(flights,
              velocidad = distance / air_time * 60) %>%
         group_by(carrier) %>%
         arrange(desc(velocidad)) %>% 
         top_n(10) %>%
  select(carrier, velocidad)

#%>% ejercicios
#¿Cuál es la hora óptima para evitar retrasos?

#recordemos las tablas en el paquete
datasets("nycflights13")

#Vemos cuál es la estructura de la tabla airports
str(airports)
#La tabla tiene de columnas:
#faa, name, lat, lon, alt, tz, dst, tzone
#vemos cómo es la tabla airports
airports %>% head

#¿Cuáles son los aeropuertos que sí están en
#la base de orígenes/destinos?
semi_join(airports, flights, by = c("faa" = "origin"))
semi_join(airports, flights, by = c("faa" = "dest"))
#Estoy regresando los valores de airports para los cuales
#hay valores en flights dado por faa = origin/dest
#Si tienen el mismo nombre, se pegan por default

#Datos limpios
# Generación aleatoria de datos
df <- data.frame(
  sujetos = LETTERS[1:16],
  grupo = sample(c("control", "tratamiento"), size = 16, replace = T
                 , prob = c(0.5, 0.5))
)
m <- t(sapply(runif(16, 16, 35), FUN = function(x){
  cumsum(c(x, rnorm(11, mean = 0.5, sd = 1)))
}))
colnames(m) <- paste0("mes", 1:12)
df <- cbind(df, m)

knitr::kable(df, 
             caption = 'Mediciones de IMC en sujetos.'
) 

df %>% head

#Datos limpios ejercicio 2
#Queremos convertir la columna 3 a 14 en renglones, ie, 
#observaciones usando gather
?gather
tidyr::gather(df, key = "key", value = "Medi", convert = FALSE)
