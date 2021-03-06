library(tidyverse)
library(readxl) # para la lectura de ficheros xlsx

# 1� Con "list.files" listamos todos los ficheros en nuestra carpeta, la opci�n pattern nos 
# permite filtrar por una expresi�n concreta, como por ejemplo que acabe en ".xlsx"

ficheros_mensuales <- list.files(pattern = ".xlsx")

# 2� Creamos un bucle for para leer todos los ficheros en caso de que tuvi�semos m�s
for (fichero in ficheros_mensuales) {
  # assign nos permite crear objetos (dataframes) pasando un nombre y lo que queremos asignar
  assign(value = read_xlsx(path = paste("./", fichero, sep = "")), # el contenido del objeto
         x = paste(fichero) # el nombre del objeto
         ) 
  
  # 3� si quieres combinar todos los reportes en una �nico dataset, si no, s�lo borra hasta linea 24
  if (fichero == ficheros_mensuales[1]) {
    # la funci�n get devuelve el valor de un objeto (x) pas�ndole el nombre como argumento
    ficheros_combinados <- get(x = fichero[1])
  } else {
    ficheros_combinados <- bind_rows(ficheros_combinados,
                                     get(x = fichero)
                                    )
  }
}

# Espero ahorrarte tiempo ;) !