require(tidyr)
require(dplyr)
library(lubridate)
setwd("~/DataVisualization/DV_TProject1/01 Data")

file_path <- "StormEvents_details-ftp_v1.0_d2015_c2015102110k.reformatted.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

df <- df %>% mutate(., BEGIN_MIN = BEGIN_TIME %% 100, BEGIN_HOUR = BEGIN_TIME %/% 100, BEGIN_MIN = BEGIN_MIN / 60, BEGIN_TIME = BEGIN_HOUR + BEGIN_MIN)

df <- df %>% mutate(., END_MIN = END_TIME %% 100, END_HOUR = END_TIME %/% 100, END_MIN = END_MIN / 60, END_TIME = END_HOUR + END_MIN)

head(select(df, BEGIN_TIME, END_TIME))
head(df)

write.csv(df, paste(gsub(".csv", "", file_path), ".reformatted2.csv", sep=""), row.names=FALSE, na = "")

#view(df)

#df2 <- select(df, BEGIN_TIME, BEGIN_HOUR, BEGIN_MIN)
#head(df2)

#df2 <- df2 %>% mutate(., BEGIN_MIN = BEGIN_MIN / 60)
#df2 <- df2 %>% mutate(., BEGIN_TIME = BEGIN_HOUR + BEGIN_MIN)
#head(df2)
