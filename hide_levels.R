library(tidyverse)
library(ggpubr)
set.seed(125)
my_data <-
  data.frame("Fruit" = rep(c("apple","banana","strawberry",NA), 
                           c(20,10,34,15)),
             "Sold_by" = sample(x = c("Stella","Peter","Mark"), 
                                size = 79, replace = T),
             "Price" = sample(x = seq(1,3,0.1), size = 79, replace = T))

data_to_plot <- my_data %>%
                 ggplot(aes(x = Sold_by, fill = Fruit)) 
Fig1 <- data_to_plot +  geom_bar()
Fig1
#Mark seems to sell more "NA" fruits, but also it's the best seller
Fig2 <- data_to_plot + 
          geom_bar(position = "fill") +
          scale_y_continuous(labels = scales::percent) +
        ylab("percentage")
Fig2
# How we can get rid off "NA" category, but save these percentages and proportions
Fig3 <- Fig2 + 
          scale_fill_manual(breaks = c("apple","banana","strawberry"),  
                            values = c("chartreuse3","darkgoldenrod2","pink"))
Fig3
# It seems we need to change the order of the levels
my_data$Fruit <- my_data$Fruit %>% 
  factor() %>% 
  addNA(ifany = T) %>%
  fct_relevel(NA)
# Now we can finally represent our desired plot
Fig4 <- my_data %>%
  ggplot(aes(x = Sold_by, fill = Fruit)) +
  geom_bar(position = "fill") +
  scale_fill_manual(breaks = c("apple","banana","strawberry"),  
                    values = c("chartreuse3","darkgoldenrod2","pink")) +
  scale_y_continuous(labels = scales::percent) +
  ylab("percentage")

ggpubr::ggarrange(
            ggarrange(plotlist = list(Fig1,Fig2),
                  ncol = 2,
                  nrow = 1, 
                  align = "h",
                  legend = "bottom",
                  common.legend = T,
                  labels = c("Fig1","Fig2"),
                  font.label = list(size = 10)),
            ggarrange(plotlist = list(Fig3,Fig4),
            nrow = 1,
            ncol = 2,
            legend = "bottom",
            common.legend = T,
            labels = c("Fig3","Fig4"),
            font.label = list(size = 10))
        )
