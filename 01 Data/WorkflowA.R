#CrosstabWorkflow
require(tidyr)
require(dplyr)
library(lubridate)
setwd("~/DataVisualization/DV_TProject1/01 Data")

file_path <- "StormEvents_details-ftp_v1.0_d2015_c2015102110k.reformatted2.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

head(select(df, BEGIN_TIME))

df2 <- df %>% select(., EVENT_TYPE, STATE, DAMAGE_CROPS, DAMAGE_PROPERTY, BEGIN_TIME, END_TIME) %>% filter(., DAMAGE_CROPS != 0 | DAMAGE_PROPERTY != 0) %>% mutate(., DAMAGE_KPI = (DAMAGE_CROPS+ DAMAGE_PROPERTY) / (END_TIME - BEGIN_TIME)) %>% filter(., DAMAGE_KPI > 500)

head(df2)

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Damage From Natural Disasters') +
  labs(x=paste("COLOR"), y=paste("CLARITY")) +
  layer(data=df2, 
        mapping=aes(x=EVENT_TYPE, y=STATE, fill = DAMAGE_KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(), 
        position=position_identity()
  )

layer(data=df, 
      mapping=aes(x=COLOR, y=CLARITY, fill=KPI), 
      stat="identity", 
      stat_params=list(), 
      geom="tile",
      geom_params=list(alpha=0.50), 
      position=position_identity()
)