library(tidyverse)
library("readxl")


# xls files
my_data <- read_excel("Concrete_Data.xls")

for(i in 1:length(names(my_data))){
  name <- names(my_data)[i]
  endi <- unlist(gregexpr(" ", name))[1] - 1
  names(my_data)[i] <- substr(name, 1, endi)
}

head(my_data)

cor(my_data, method = "pearson")