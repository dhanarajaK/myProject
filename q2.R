library(dplyr)
library(lubridate)

df <- read.csv("MT-clean.csv", stringsAsFactors = FALSE)
df %>% glimpse

round_func = function(x, d=2) sprintf(paste0("%1.",d,"f"), x) 

ans1 <- nrow(df %>% filter(driver_gender == "M" )) / nrow(df)

round_func(ans1, 10)

narrTAndoutT = nrow(df %>% filter(out_of_state == TRUE, is_arrested == TRUE))
noutT = nrow(df %>% filter(out_of_state == TRUE))
narrTAndoutF = nrow(df %>% filter(out_of_state == FALSE, is_arrested == TRUE)) 
noutF = nrow(df %>% filter(out_of_state == FALSE))

narrTgivenoutT = narrTAndoutT / noutT
narrTgivenoutF = narrTAndoutF / noutF

DLRPlus = narrTgivenoutT / narrTgivenoutF
round_func(DLRPlus, 10)

ef <- read.csv("VT-clean.csv", stringsAsFactors = FALSE)

mt <- df %>% group_by(is_arrested) %>% tally()
vt <- ef %>% group_by(is_arrested) %>% tally()

round_func(chisq.test(mt, vt)$statistic, 10)

ans3 <- nrow(df %>% filter(grepl("Speeding", violation)))/ nrow(df)

round_func(ans3, 10)

mtdui <- nrow(df %>% filter(grepl("DUI", violation)))/ nrow(df) 
vtdui <- nrow(ef %>% filter(grepl("DUI", violation)))/ nrow(ef)

round_func(mtdui/vtdui, 10)

df$stop_year = year(as.Date(df$stop_date, format = "%Y-%m-%d", na.exclude))
df1 <- df %>% select(stop_year, vehicle_year) %>% group_by(stop_year) %>% summarise(avg = mean(as.numeric(vehicle_year), na.rm = TRUE))

model <- lm(avg ~ stop_year, data = df1, na.action = na.omit)

round_func(predict(model, newdata = data.frame(stop_year = c(2020))), 10)

f <- summary(model)$fstatistic
round_func(pf(f[1],f[2],f[3],lower.tail=F), 10)

