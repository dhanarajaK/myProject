library(ggplot2)
library(dplyr)

dest <- read.csv("destinations.csv", stringsAsFactors = FALSE)
train <- read.csv("train.csv", stringsAsFactors = FALSE)

t <- tbl_df(train)
t %>% glimpse()

g = ggplot(data = t, aes(x = factor(hotel_cluster), color = is_booking)) + geom_histogram()
g
factor(t$hotel_cluster)
