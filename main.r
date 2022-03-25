library("xlsx")

##Loading data set and dropping column 9
df <- read.xlsx("Concrete_Data.xls",  sheetIndex = 1)
df <- df[-9]
