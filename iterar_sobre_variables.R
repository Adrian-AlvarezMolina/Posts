library(tidyverse)
datasets::Titanic
# Convertimos los datos de Titanic en un s�lo dataframe
Titanic <- reshape2::melt(Titanic) %>%
  uncount(value) %>% 
  as_tibble()
# Creamos una lista donde guardaremos los plots para verlos luego con ggpubr:
lista_plots <- NULL
# En el bucle vamos a agrupar por esa variable, y graficaremos en un gr�fico de barras 
# el n�mero de niveles de esa variable (Class, Sex, Age o Survived)
for (variable_elegida in colnames(Titanic)) {
  datos_grafico <- Titanic %>%
  # ��Aqu� est� la magia!! -> usar dentro de un doble corchete la variable iterada "variable_elegida"
    group_by(grupo = Titanic[[variable_elegida]]) %>%
    summarise(n_observaciones = n())
  # con assign guardamos los plots fuera del bucle
  # cambiandoles el nombre (argumento x) en funcion de la variable
  assign(x = paste(variable_elegida, "plot", sep = "_"),
         value = datos_grafico %>%
           # El eje X y los colores ir�n en funci�n de la variable elegida
                  ggplot(aes(x = grupo, fill = grupo,
                             y = n_observaciones)) +
                  geom_col() +
           # para que las etiquetas est�n del eje X y la leyenda est�n acordes a la variable
                  scale_fill_hue(name = variable_elegida) +
                  xlab(variable_elegida)
           )
  # Guardamos el plot que se ha generado en nuestra lista
  lista_plots[[variable_elegida]] <- eval(expr(get(paste(variable_elegida,"plot", sep = "_"))))
}
ggpubr::ggarrange(plotlist = lista_plots)
