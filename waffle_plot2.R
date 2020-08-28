library(tidyverse)
library(waffle)
library(palmerpenguins)
library(extrafont)
library(ggwaffle)
library(emojifont)

# Prepare the data to plot ------------------------------------------------

my_data <- penguins
# Data can contain rows with missing values, so we will discard them just to facilitate the visualization. In the next way we filter all the rows that has at least one NA value
my_data_without_NA <- na.omit(my_data)
# But in case you want to discard just the rows which has an NA value only in one specific column, like species, you can do it in a different way:
my_data_without_NA <- my_data[!is.na(my_data$species),]

# We want to plot the number of different species in our dataset
count_values      <- table(my_data_without_NA$species)
percentage_values <- (table(my_data_without_NA$species) /
                           nrow(my_data_without_NA) * 100) %>%
                     round()
my_data_without_NA %>% count(species) %>%
                      mutate(n = n / sum(n) * 100)

# Plot the waffle chart of whole dataset --------------------------------

# When you have the data in a long format (one line per observation), it's useful convert that format with "waffle_iron", making easier to do the waffle plot
waffle_iron(my_data_without_NA, aes_d(group = species))

Whole_sample_waffle <- 
  waffle_iron(my_data_without_NA, aes_d(group = species)) %>%
  # With waffle_iron the levels are convert to numbers, but we want to recover the original levels
  mutate(group = levels(my_data_without_NA$species)[group]) %>%
  # Instead of plot a dot/square, I choosed to draw a penguin from "emojifont" package
  mutate(label = emoji("penguin")) %>%
  ggplot(aes(x, y, color = group)) +
  # In this step is where we ask ggplot to write the text of the "label" field, a penguin
  geom_text(aes(label = label), size = 5) +
  # theme_waffle helps to remove the x and y scales, remove the background, etc.
  theme_waffle() +
  ggtitle("Whole penguin population") +
  xlab("") +
  ylab("")
Whole_sample_waffle

# Plot the waffle chart for 100 penguins ----------------------------------

# Commonly waffle charts helps to see proportion, and 100 subjects is a easy number to see them.
# As we haven't got now a long format dataset we will create one (telling the x and y positions), and we will introduce the number of species depending on the whole dataset propotion
hundred_penguins <- 
           data.frame(x = rep(1:10,10),
           y = rep(1:10, each = 10),
           # introducing the species
           specie = rep(x = levels(my_data_without_NA$species), 
                        (count_values/sum(count_values) * 100) %>% round() %>% as.vector()),
           label = emoji("penguin"))

hundred_penguins_waffle <- 
  hundred_penguins %>% 
    ggplot(aes(x, y, color = specie)) +
    geom_text(aes(label = label), size = 10) +
    theme_waffle() +
    ggtitle("100 penguins") +
    xlab("") +
    ylab("")
hundred_penguins_waffle

# Plotting waffle chart for 10 penguins ----------------------------------

ten_penguins <- 
  data.frame(x = 1:10,
             y = 1,
             specie = rep(x = levels(my_data_without_NA$species), 
                          (count_values/sum(count_values) * 10) %>% round() %>% as.vector()),
             label = emoji("penguin"))
# See proportion with 10 penguins seems easier<

ten_penguins_waffle <- 
  ten_penguins %>% 
  ggplot(aes(x, y, color = specie)) +
  geom_text(aes(label = label), size = 10) +
  theme_waffle() +
  ggtitle("10 penguins") +
  xlab("") +
  ylab("")
ten_penguins_waffle

# Waffle chart with one specimen of the less frequent specie --------------
# We have simple and good proportions 2:1:2, but could be cases where we can't see the less frequent specie if we take just 10 individuals, so we can represent the necessary ammount of penguins to detect one of the less frequent specie (Chinstrap).

prop_relative_Chinstrap <- (count_values/min(count_values)) %>%  round()

minimum_penguins <- data.frame(x = 1:sum(prop_relative_Chinstrap),
                               y = 1,
                               specie = names(prop_relative_Chinstrap) %>%
                                        rep(prop_relative_Chinstrap),
                               label = emoji("penguin"))
minimum_penguins_waffle <- 
  minimum_penguins %>% 
  ggplot(aes(x, y, color = specie)) +
  geom_text(aes(label = label), size = 10) +
  theme_waffle() +
  ggtitle(paste(sum(prop_relative_Chinstrap), "penguins", sep = " ")) +
  xlab("") +
  ylab("")
minimum_penguins_waffle

# Grid plot -----------------------------------------------------

ggpubr::ggarrange(
  Whole_sample_waffle, hundred_penguins_waffle, 
  ggpubr::ggarrange(
    ten_penguins_waffle, minimum_penguins_waffle,
    ncol = 1, nrow = 2,
    legend = "none"
  ),
  ncol = 3, nrow = 1,
  common.legend = T,
  legend = "left")

ggpubr::ggarrange(
  ten_penguins_waffle, minimum_penguins_waffle,
  ncol = 1, nrow = 2,
  legend = "none"
)

ggpubr::ggarrange(
    Whole_sample_waffle, hundred_penguins_waffle,
    ggpubr::ggarrange(
      plotlist = list(ten_penguins_waffle, minimum_penguins_waffle),
      nrow = 2, ncol = 1,
      common.legend = T),
    ncol = 2, nrow = 1,
    common.legend = T)

