require(tidyr)
require(dplyr)
require(ggplot2)

setwd("~/DataVisualization/DV_TProject1/01 Data")

file_path <- "StormEvents_details-ftp_v1.0_d2015_c20151021.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

head(df)

df <- sample_n(df, 10000, replace = TRUE)

write.csv(df, paste(gsub(".csv", "", file_path), "10k.csv", sep=""), row.names=FALSE, na = "")
