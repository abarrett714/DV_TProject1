require(tidyr)
require(dplyr)
require(ggplot2)
require(utils)
require("jsonlite")
require("RCurl")

setwd("~/DataVisualization/DV_TProject1/01 Data")

file_path <- "StormEvents_details-ftp_v1.0_d2015_c2015102110k.reformatted.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

#df <- df %>% 
  
  require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Stars') +
  labs(x="Constellation", y=paste("Magnitude (relative to vega)")) +
  layer(data=df2, 
        mapping=aes(as.character(CON), y=as.numeric(as.character(MAG)), color=CON), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )