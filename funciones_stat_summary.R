library(tidyverse)
my_data <- iris

# Usar stat_summary con una funci�n customizada --------------

# Creamos la funci�n para calcular la media geom�trica
fun_geometric_mean <- function(y) {
  geometric_mean_fun <- 
    # La media geom�trica se obtiene elevando el n�mero e
    # a la media de los valores logaritmicos
    return(exp(mean(log(y))))
}  

my_data %>%
  ggplot(aes(x = Species, y = Sepal.Length)) +
  geom_jitter(width = 0.2, alpha = 0.1) +
  stat_summary(fun = "fun_geometric_mean", color = "blue", 
               geom = "point") +
  ggtitle ("Media geom�trica de\nSepal.Lengthseg�n especie")







# Funci�n para representar m�s de un valor --------------------------------

# super_fun obtiene los percentiles 10 y 90 para represetar barras
# aunque esos par�metros podr�n cambiarse
super_fun <- function(x,lower = 0.1, upper = 0.9) {
  
  ymin = quantile(x, lower)
  y = quantile(x, 0.5)
  ymax = quantile(x, upper)
  
  return(data.frame(ymin = ymin, y = y, ymax = ymax))
}
  
my_data %>%
  ggplot(aes(x = Species, y = Sepal.Length)) +
  geom_jitter(width = 0.2, alpha = 0.1) + 
  stat_summary(fun.data = "super_fun",
               color = "blue", 
               geom = "errorbar") +
  ggtitle("Percentiles 10 y 90")
  
my_data %>%
  ggplot(aes(x = Species, y = Sepal.Length)) +
  geom_jitter(width = 0.2, alpha = 0.1) + 
  stat_summary(fun.data = "super_fun",
               color = "blue", 
               geom = "errorbar",
               fun.args = list(lower = 0.25, upper = 0.75)) +
  ggtitle("Rango intercuartilico")
