library(tidyverse)
path <- "/Users/Adrian/Desktop/Analiza tus datos/Imágenes y scripts de posts/dist_mat.txt"
# utils package doesn't work for this case.
bad_loading1 <- read.delim(file = path)
# As the first row of the file contains just one column, the file is not loaded properly
bad_loading2 <- read_tsv(file = path, col_names = F)
bad_loading3 <- read_table2(file = path, col_names = F)

# If we read the file as a text, and then separate the characters will be easier
read_file(file = path) %>% str_remove_all(pattern = "\\r")
good_loading <- read_file(file = path) %>%
                  str_remove_all(pattern = "\\r") %>%
                  str_split(pattern = "\\n", simplify = T) %>%
                  t() %>%
                  str_split(pattern = "\\t", simplify = T ) %>%
                  # Next line of code transform the character columns to numeric columns
                  apply(X = ., MARGIN = 2, FUN = function(x) {x <- as.numeric(x)})
good_loading
