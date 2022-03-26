library("xlsx")
library("tidyverse")
library("psych")
library("cluster") 
library("magrittr") 
library("purrr")
library("factoextra")


##Loading data set and renaming
df <- read.xlsx("Concrete_Data.xls",  sheetIndex = 1)
colnames <- c("cement", "blast_furnace", "fly_ash", "water", 
              "superplast", "coarse_agg", "fine_agg", "age_day", "c_strength")
names(df) <- colnames


##Understanding data
str(df)
summary(df)

## Drop Na values if exist
df <-na.omit(df)


##Visuzalization 
plot(df)
describe(df)


##Normalization
normalize <- function(x) {((x-min(x)) / (max(x) - min(x)))} 
df<-as.data.frame(lapply(df, normalize))

## Cor plot
install.packages("corrplot") 
library(corrplot)
cor(df)
corrplot(cor(df), method = "circle")



## Data Cleaning

df <- df[ , ! names(df) %in% c("coarse_agg", "fine_agg", 
                               "blast_furnace","fly_ash")]




#Finding optimal k value
wss <- function(k) {
  kmeans(df, k, nstart = 10 )$tot.withinss
}
# Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")