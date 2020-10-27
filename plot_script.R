library(tidyverse)
library(ggpattern) #Package which inspire the post

my_data <- palmerpenguins::penguins

grey_scale <- my_data %>%
  ggplot(aes(x = island, fill = island)) +
  geom_bar() +
  scale_fill_grey(start = 0.2, end = 0.6) +
  theme_classic() +
  ylab("Number of penguins") +
  xlab("Island") +
  ggtitle(label = "Grey scale") +
  theme(axis.text = element_text(color = "black", size = 14),
        axis.title = element_text(color = "black", size = 18, face = "bold"),
        legend.text = element_text(color = "black", size = 14),
        legend.title = element_text(color = "black", size = 18, face = "bold"),
        legend.position = "bottom",
        plot.title = element_text(color = "black", size = 22, hjust = 0.5))

grob_annotation <- ggplotGrob(ggplot() + 
                                annotate(geom = "text",
                                         label = "Sequential grey scale suggest\nthat it may exist some ordinal\nrelation among islands ...",
                                         x = 1,
                                         y = 1,
                                         color = "darkred") +
                                theme_void())
final_grey_plot <-
  grey_scale +
  annotation_custom(grob = grob_annotation,
                               xmin = -1.75,
                               ymax = -80)


# plot with patterns ------------------------------------------------------
pattern_density = c(0.2,0.1,0.2),
pattern_spacing = c(0.05,0.03,0.05)

pattern_scales <-
my_data %>%
  ggplot(aes(x = island, 
             pattern = island, 
             pattern_density = island,
             pattern_spacing = island)) +
  geom_bar_pattern(,
                   fill = "grey90",
                   color = "black",
                   pattern_fill = "grey50") +
  scale_pattern_density_manual(values = c(0.1,0.05,0.4)) +
  scale_pattern_spacing_manual(values = c(0.05,0.05,0.05)) +
  theme_classic() +
  ylab("Number of penguins") +
  xlab("Island") +
  ggtitle(label = "Pattern scale") +
  theme(axis.text = element_text(color = "black", size = 14),
        axis.title = element_text(color = "black", size = 18, face = "bold"),
        legend.text = element_text(color = "black", size = 14),
        legend.title = element_text(color = "black", size = 18, face = "bold"),
        legend.position = "bottom",
        plot.title = element_text(color = "black", size = 22, hjust = 0.5))

pattern_grob <- ggplotGrob(ggplot() + 
                             annotate(geom = "text",
                                      label = "In counterpart, pattern scale\n does not suggest any kind\nof ordinal relation",
                           x = 1, 
                           y = 1,
                           color = "green4") +
                             theme_void())
  
final_pattern_plot <-
  pattern_scales +
  annotation_custom(grob = pattern_grob,
                                   xmin = -1.75,
                                   ymax = -80)
