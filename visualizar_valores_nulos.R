library(tidyverse)
library(visdat)

# Cargamos los datos
my_data <- palmerpenguins::penguins
# Graficamos d�nde hay valores nulos (NA)
visdat::vis_miss(my_data, sort_miss = T) + 
  ggtitle("Distribuci�n de valores nulos en el dataset")

# Si quieres saber el n�mero de valores perdidos
apply(X = my_data,
      MARGIN = 2, # 2 para saber n�mero de nulos por columna, 1 para filas
      FUN = function(X) {sum(is.na(X))}
      )

# Gracias por leerme !
# Si te gustan estos peque�os snacks de c�digo en mi LinkedIn 
# https://www.linkedin.com/in/adrianalvarezmolina/
# o bajo el hastagh #road2r encontrar�s m�s tips de R ;)