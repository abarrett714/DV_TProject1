#CrosstabWorkflow
require(tidyr)
require(dplyr)
library(lubridate)
setwd("~/DataVisualization/DV_TProject1/01 Data")

file_path <- "StormEvents_details-ftp_v1.0_d2015_c2015102110k.reformatted2.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

head(select(df, BEGIN_TIME))
