library(tidyverse); library(palmerpenguins); library(cowplot); library(magick)
# Prepare the data to plot ------------------------------------------------

my_data <- penguins
# Data can contain rows with missing values, so we will discard them just to facilitate the visualization
rows_without_NA <- apply(X = my_data, MARGIN = 1,
                         FUN = function(x) {sum(!is.na(x))}) == 8
my_data_without_NA <- my_data[rows_without_NA,]

count_values      <- table(my_data_without_NA$species)
percentage_values <- (table(my_data_without_NA$species) /
                        nrow(my_data_without_NA) * 100) %>%
  round()
my_data_without_NA %>% count(species) %>%
  mutate(n = n / sum(n) * 100)


# Plot some penguins ------------------------------------------------------

theme_set(theme_cowplot())

bar_plot <- my_data_without_NA %>%
              ggplot(aes(x = species)) +
              geom_bar() +
              ylab("Number of penguins") +
              ggtitle("Frequence and type of Penguins in palmerpenguins dataset", 
                      subtitle = "Knowing who are behind the numbers") +
              scale_y_continuous(n.breaks = 5, 
                                 breaks = seq(0,200,50), 
                                 labels = c(0,50,100,150,200),
                                 limits = c(0,400) ) +
              theme(plot.title = element_text(hjust = 0.5),
                    plot.subtitle = element_text(hjust = 0.5),
                    axis.text = element_text(size = 20)) 
bar_plot
path_to_png <- 
  "/Users/Adrian/Desktop/Analiza tus datos/Imágenes y scripts de posts"

example_plot <- 
  ggdraw() +
  draw_image(image = (paste(path_to_png, "/", "adelie_image.jpg", sep = "")),                 x = -0.26,
             y = 0.15,
             scale = 0.5) +
  draw_image(image = (paste(path_to_png, "/", "Chinstrap-penguin.jpg", sep = "")),                 x = 0.025,
             y = 0.15,
             scale = 0.5) +
  draw_image(image = (paste(path_to_png, "/", "gentoo_penguin.jpg", sep = "")),                 x = 0.310,
             y = 0.15,
             scale = 0.5) +
  draw_plot(bar_plot)

png(filename = paste(path_to_png, "/", "penguins_plot.png", sep = ""), 
    height = 1000,
    width = 1500)
example_plot
dev.off()

  