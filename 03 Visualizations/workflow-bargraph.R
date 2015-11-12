require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

dfs <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from STORMEVENTS"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mew2795', PASS='orcl_mew2795', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#df <- df %>% group_by(Begin_Yearmonth, Death_Direct) %>% summarize(sum_Deaths_Direct = sum(Deaths_Direct), sum_Deaths_Indirect = sum(Deaths_Indirect)) %>% mutate(ratio = sum_Deaths_Direct / sum_Deaths_Indirect) %>% mutate(kpi = ifelse(ratio <= KPI_Low_Max_value, '03 Low', ifelse(ratio <= KPI_Medium_Max_value, '02 Medium', '01 High'))) %>% rename(BEGIN_YEARMONTH=Begin_Yearmonth, DEATHS_DIRECT=Deaths_Direct, SUM_DEATHS_DIRECT=sum_Deaths_Direct, SUM_DEATHS_INDIRECT=sum_Deaths_Indirect, RATIO=ratio, KPI=kpi)
dfs1 <- select(dfs, BEGIN_YEARMONTH, DEATHS_DIRECT, DEATHS_INDIRECT, DAMAGE_PROPERTY) #%>% filter(DEATHS_DIRECT != 0)


 ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  facet_wrap(~BEGIN_YEARMONTH, ncol = 1) +
  labs(title='StormEvents Barchart\ndeaths_direct, avg(deaths_direct), ') +
  labs(x=paste("Begin Yearmonth"), y=paste("Deaths Direct")) +
  layer(data=dfs1, 
        mapping=aes(x=BEGIN_YEARMONTH, y=(DEATHS_DIRECT)), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(colour="blue"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=dfs1, 
        mapping=aes(x=BEGIN_YEARMONTH, y=DEATHS_DIRECT, label=(DEATHS_DIRECT)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=0.5), 
        position=position_identity()
  ) +
  layer(data=dfs1, 
        mapping=aes(yintercept = DEATHS_DIRECT), 
        geom="hline",
        geom_params=list(colour="red")
  )

 