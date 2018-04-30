library(ggplot2)
library(dplyr)

dest <- read.csv("destinations.csv", stringsAsFactors = FALSE)
train <- read.csv("train.csv", stringsAsFactors = FALSE)

t <- train %>% sample_frac(0.1)

# Top 10 hotel clusters that had hits
top10hotelclusters = train %>% 
  group_by(hotel_cluster) %>% 
  summarize(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  select(hotel_cluster) %>% slice(1:10)

# Extracting the datasets to top 10 hotel clusters that had hits
t10hotelclusters <- train %>% filter(hotel_cluster %in% unlist(top10hotelclusters))

# Plotting histogram of hotel clusters versus Posa Continent against bookings
g = ggplot(data = t10hotelclusters, aes(x = factor(hotel_cluster), fill = factor(posa_continent))) + geom_bar()
g + facet_wrap(~is_booking, scales = "free", labeller = label_both) + 
  theme_classic() + 
  labs(y = "Count", x = "Top 10 hotel cluster Ids", title = "Distribution of top 10 hotel clusters with respect to booking and POSA Continent")

t10dest <- train %>%   
  group_by(srch_destination_id) %>% 
  summarize(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  select(srch_destination_id) %>% slice(1:10)

# Extracting the datasets to top 10 search destinations that had hits
t10data <- train %>% filter(srch_destination_id %in% unlist(t10dest))

# Plotting histogram of top 10 searched destinations versus Posa Continent against bookings
h = ggplot(data = t10data, aes(x = factor(srch_destination_id), fill = factor(posa_continent))) + geom_bar()
h + facet_wrap(~is_booking, scales = "free", labeller = label_both) + 
  theme_classic() + 
  labs(y = "Count", x = "Top 10 search destination Ids", title = "Distribution of top 10 search destinations with respect to booking and POSA Continent")

