library(tidyverse)
# This will load "patchwork" package or installed it in case you don't have it.
if("patchwork" %in% installed.packages()) {
  library(patchwork)
} else {
  install.packages("patchwork")
  library(patchwork)
}

# Create the base plot
base_plot <- ToothGrowth %>% ggplot(aes(x = len, fill = supp)) +
                             geom_density(alpha = 0.5) +
                             ggtitle("default_theme")
# These are the base themes of ggplot2              
base_themes <- (ls("package:ggplot2") %>% grep(pattern = "^theme_.*", value = T))[c(1:3,5:8,13)]
base_themes

# The for loop iterate over the base_themes, and create a plot titled with the theme
for (iteration in 1:length(base_themes)){
  # Create the plot adding the theme
  plot <- base_plot + get(base_themes[iteration])() + ggtitle(base_themes[iteration])
  # assign serves to export the plot created to the external environment (outside the loop)
  assign(x = paste(base_themes[iteration], "_plot", sep = ""),
         value = plot)
  # When we finish the iteration we will plot them using "patchwork" package
  if (iteration == length(base_themes)) {
    parse(text = grep(pattern = "_plot", x = ls(), value = T) %>%
                 str_flatten(collapse = "+")) %>%
    eval()
  }
}

