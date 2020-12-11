library(tidyverse); library(palmerpenguins); library(ggpubr)
# Prepare some data
my_data <- penguins %>% 
              na.exclude() 
# We will represent the weight of each different species of penguins
data_to_plot <- my_data %>% 
                  group_by(species) %>%
                  summarise(number_of_penguins = n(),
                            average_weight = mean(body_mass_g),
                            standard_dev = sd(body_mass_g))
# Create a basic bar-plot
bar_plot <- data_to_plot %>%
              ggplot(aes(x = species, y = average_weight)) + 
              geom_col() + ggtitle("Bar plot") +
              theme_bw()
# Add error bars
default_error_bar <- bar_plot + 
                      geom_errorbar(aes(ymin = average_weight - standard_dev,
                                        ymax = average_weight + standard_dev)) +
                      ggtitle("Default error bars")
# You can modify the width, size, color, and opacity among others.
customized_error_bar <- bar_plot +
                        geom_errorbar(aes(ymin = average_weight - standard_dev,
                                          ymax = average_weight + standard_dev),
                                      width = 0.5,
                                      size = 1.5,
                                      color = "darkred",
                                      alpha = 0.7) +
                        ggtitle("Customized error bars")

ggarrange(plotlist = list(bar_plot, default_error_bar, customized_error_bar), 
          nrow = 3)
