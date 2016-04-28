## offline update of cache of all indices

library(readr)
library(wbstats)
library(dplyr)


new_cache <- wbcache() # takes a while so offline ## large list - if not wb_cachelist is used # wbcache can have 
indicators <- tbl_df(new_cache$indicators) #16630 late April 2016
write_csv(indicators,"data/indicators.csv")


countries <-wbcountries(lang = c("en", "es", "fr", "ar", "zh"))

write_csv(countries,"data/countries.csv")