library(tidyverse)
library(visdat)

# Cargamos los datos
my_data <- palmerpenguins::penguins
# Graficamos dónde hay valores nulos (NA)
visdat::vis_miss(my_data, sort_miss = T) + 
  ggtitle("Distribución de valores nulos en el dataset")

# Si quieres saber el número de valores perdidos
apply(X = my_data,
      MARGIN = 2, # 2 para saber número de nulos por columna, 1 para filas
      FUN = function(X) {sum(is.na(X))}
      )

# Gracias por leerme !
# Si te gustan estos pequeños snacks de código en mi LinkedIn 
# https://www.linkedin.com/in/adrianalvarezmolina/
# o bajo el hastagh #road2r encontrarás más tips de R ;)