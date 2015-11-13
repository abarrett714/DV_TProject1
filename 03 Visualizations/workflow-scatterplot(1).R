#CrosstabWorkflow
require(tidyr)
require(dplyr)
library(lubridate)
require(ggplot2)
require(gridExtra)
require(jsonlite)
require(RCurl)

dfs <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select EVENT_TYPE, DAMAGE_CROPS, DAMAGE_PROPERTY, END_TIME, BEGIN_TIME from STORMEVENTS where DAMAGE_CROPS is not null and DAMAGE_PROPERTY is not null"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jdg3666', PASS='orcl_jdg3666', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

dfnew <- dfs %>% select(EVENT_TYPE, DAMAGE_CROPS, DAMAGE_PROPERTY, END_TIME, BEGIN_TIME) %>% filter(DAMAGE_PROPERTY > 0, DAMAGE_CROPS > 0) %>% mutate (TOTAL_TIME = (abs(END_TIME - BEGIN_TIME)) / 100) %>% filter(TOTAL_TIME > 0)

head(dfnew)

require(extrafont)
crop <- ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Crop and Property Damage across Disasters less than 24 hours') +
  labs(x="Total Time of Disaster", y=paste("Crop Damage")) +
  layer(data=dfnew, 
        mapping=aes(as.numeric(TOTAL_TIME), y=as.numeric(as.character(DAMAGE_CROPS)), color=EVENT_TYPE), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

property <- ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  labs(title='Crop and Property Damage across Disasters less than 24 hours') +
  labs(x="Total Time of Disaster", y=paste("Crop Damage")) +
  layer(data=dfnew, 
        mapping=aes(as.numeric(TOTAL_TIME), y=as.numeric(as.character(DAMAGE_PROPERTY)), color=EVENT_TYPE), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )
grid.arrange(crop, property)
