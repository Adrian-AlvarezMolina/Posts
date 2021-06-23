library(tidyverse)
library(rstatix) # statistical tests
library(ggpubr) # adding brackets with p-values
my_data <- iris 
         
# 1º boxplot creation
default_boxplot <-
my_data %>%
  ggplot(aes(x = Species, y = Sepal.Length, color = Species)) +
  geom_boxplot() +
  theme(panel.background = element_blank())

default_boxplot
# 2º Calculate t.test
boxplot_stats <-
t_test(data = my_data, formula = Sepal.Length ~ Species) %>%
  add_xy_position() # This helps to allocate the brackets in the boxplot

boxplot_stats
# 3º Add the t.test results
default_boxplot +
  stat_pvalue_manual(data = boxplot_stats,
                     label = "p = {p.adj}")
# Alternative label for p-values
default_boxplot +
  stat_pvalue_manual(data = boxplot_stats,
                     label = "{p.adj.signif}")
