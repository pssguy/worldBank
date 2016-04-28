# load libraries
library(wbstats)

library(readr)
library(shiny)
library(shinydashboard)
library(DT)
# library(XML)
# library(stringr)
# library(markdown)
# library(ggvis)
# library(rcdimple)
library(plotly)
#library(explodingboxplotR)
library(dplyr) # looks like another package might include plyr so moved to bottom

##load current list of indicators - reg updated off line

# indicators <- read_csv("data/indicators.csv")
# 
# print(glimpse(indicators))
# 
# indicators %>% 
#   DT::datatable(class='compact stripe hover row-border order-column',rownames=FALSE,options= list(paging = FALSE, searching = FALSE,info=FALSE))
# 
# indicatorChoice <- indicators$indicatorID
# names(indicatorChoice) <- indicators$indicatorDesc
# 
# print(indicatorChoice)