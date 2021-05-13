# Librería con muchas paletas de colores
library(paletteer)

# Librería para visualizar las paletas de color y elegirlas
library(gt)

# Paletter contiene varias librerías, cada una de ellas con
# sus propias paletas

paletteer_packages

# Las divide en función de si los colores se han preparado
# para variables continuas

head( paletteer::palettes_c_names, n = 2 )

# Variables discretas

head( paletteer::palettes_d_names, n = 2 )

# Vamos a fijarnos un poco en qué información tienen las
# paletas

# package nos dice el paquete donde está la paleta
# palette es el nombre para cargar la paleta
# length es el número de colores distintos que hay
# type: puede ser secuencial si tus factores tienen un orden,
#       o cualitativa cuando tus factores no tienen orden
paletteer::palettes_d_names[1:10, ]

# Podemos ver los colores que tiene, para eso tenemos que 
# escribir "paquete_de_paleta::nombre_paleta"
paletteer::paletteer_d(palette = "awtools::a_palette")

paletteer_d("basetheme::brutal")

# Pero para algunas paquetes de paletas discretas hay una forma
# muuuuucho mejor de explorar gracias a la librería "gt"
gt::info_paletteer(color_pkgs = "awtools")

# Si quieres una paleta para variable continua recuerda
# en vez de paletter_d, sería paletter_c.
# Se autocompletan los nombres con tabulador
# Y como son continuas puedes especificar tu rango de valores
paletteer_c("viridis::viridis", n = 20)

# Y para los fans de juego de tronos aquí va un bonus

install.packages("gameofthrones")
library(gameofthrones)
library(ggplot2)
paletteer_c("gameofthrones::baratheon", n = 20)

ggplot(data = iris,
       aes(x = Sepal.Length, y = Sepal.Width,
           color = Sepal.Length/Sepal.Width)) +
  geom_point() +
  scale_color_paletteer_c(name = "Ratio longitud/anchura\ndel sépalo", palette = "gameofthrones::baratheon")
