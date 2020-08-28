library(tidyverse)
library(palmerpenguins)
library(cowplot)
library(magick)
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

path_to_adelie_image <- 
  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Adelie_Penguin.jpg/429px-Adelie_Penguin.jpg"
path_to_gentoo_image <- 
  "https://upload.wikimedia.org/wikipedia/commons/9/95/Gentoo_Penguin_at_Cooper_Bay%2C_South_Georgia.jpg"
path_to_chinstrap_image <- 
  "https://cdn.britannica.com/08/152708-050-23B255B3/Chinstrap-penguin.jpg"

example_plot <- 
  ggdraw() +
  draw_image(image = path_to_adelie_image,  
             x = -0.26,
             y = 0.15,
             scale = 0.5) +
  draw_image(image = path_to_chinstrap_image,
             x = 0.025,
             y = 0.15,
             scale = 0.5) +
  draw_image(image = path_to_gentoo_image,
             x = 0.310,
             y = 0.15,
             scale = 0.5) +
  draw_plot(bar_plot)
# Can take some second to visualize the plot in R
example_plot

# Save the plot -----------------------------------------------------------
# Modify the path to save the image where you want
path_to_png <- "/Users/Adrian/Desktop"

png(filename = paste(path_to_png, "/", "penguins_plot2.png", sep = ""), 
    height = 1000,
    width = 1500)
example_plot
dev.off()

  
