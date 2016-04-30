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
library(leaflet)
library(rgdal)
library(dplyr) # looks like another package might include plyr so moved to bottom

countries <-read_csv("data/countries.csv")
print(glimpse(countries))

maps <- readOGR(dsn=".",
                layer = "ne_50m_admin_0_countries", 
                encoding = "UTF-8",verbose=FALSE)

# problem with legend may be due to putting here
#pal <- colorBin(colorRamp(c("#ffffff", "#2166ac"), interpolate="spline"),domain=NULL)

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