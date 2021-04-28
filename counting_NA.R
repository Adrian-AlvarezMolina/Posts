library(tidyverse)
library(naniar)
# Datos iniciales
my_data <- data.frame(col_1 = rnorm(n=200, mean = 80, sd = 5),
                      col_2 = sample(x = c(10,30), replace = T,
                                     size = 200, prob = c(0.5, 0.5)))
# Elegimos aleatoriamente filas que convertiremos en NA
set.seed(2021)
col_1_NA <- sample(x = 1:100, replace = F, size = 10)
col_2_NA <- sample(x = 1:100, replace = F, size = 6)
my_data$col_1[col_1_NA] <- NA
my_data$col_2[col_2_NA] <- NA
# Visualizamos cuántas valores nulos (NA) tenemos en cada variable
gg_miss_var(my_data)
# Vector con número de NA en cada variable
sapply(X = my_data, FUN = n_miss)
# Dataframe con el número de NA y la proporción respecto al total de datos
miss_var_summary(my_data)

