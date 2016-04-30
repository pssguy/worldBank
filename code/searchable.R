##


searchData <- eventReactive(input$searchWB,{

req(input$searchValue)

print(input$searchValue) # eg poverty
searchValue <- input$searchValue


df<- wbsearch(pattern = searchValue, fields = c("indicator", "indicatorDesc","indicatorID"),
              extra = TRUE) # have not got latest cache
# info=list(searchValue=searchValue)
# return(info)

})

output$tableChoice <- DT::renderDataTable({
 
 searchData() %>%
   select(indicatorID,Indicator=indicator,Description=indicatorDesc) %>% 
                         DT::datatable(class='compact stripe hover row-border order-column',rownames=TRUE,selection='single',options= list(paging = TRUE, searching = TRUE,info=FALSE,
                                                                                                                                           columnDefs = list(list(visible=FALSE, targets=list(1)))))
})


## now get data for selected table

wbData <- reactive({
  
  if(is.null(input$tableChoice_rows_selected)) return()
  
  
  s = as.integer(input$tableChoice_rows_selected)
  
  id <- searchData()[s,]$indicatorID
  df <- wb(indicator = id,  POSIXct = TRUE) 
  # print(unique(df$country))
  # 
  # write_csv(df,"data/problems.csv")
  
  test <- df %>% 
   select(-iso2c) %>% # appears as this is sometimes not shown
    left_join(countries) %>% 
    filter(!is.na(long))
  
  print(glimpse(test))
  
  latest<- max(test$date)
  
  info=list(id=id,df=df,test=test,latest=latest)
  return(info)
  
})


output$resultTable <- DT::renderDataTable({

  req(wbData()$test)
  

  wbData()$test %>%
    mutate(value=round(value,1)) %>% 
    select(country,date,value)%>%
                         DT::datatable(class='compact stripe hover row-border order-column',rownames=FALSE,options= list(paging = TRUE, searching = TRUE,info=FALSE))

})

output$resultTitle <- renderText({
  req(wbData()$test)
  unique(wbData()$test$indicator)
  
})

output$resultPlot <- renderPlotly({
  
  req(wbData()$test)
  worst <- wbData()$test %>% 
    filter(date==wbData()$latest) %>% 
    arrange(value) %>% 
    select(country,value) %>% 
    head(10) %>% 
    select(country) %>% 
    unlist(use.names = FALSE)
  
  wbData()$test %>% 
    filter(country %in% worst) %>% 
    #arrange(value) %>% # legend then reflects worst currently - but then lines go squwiff
    arrange(date) %>%
    group_by(country) %>% 
    plot_ly(x=date,y=value,color=country,mode="markers+lines") %>% 
    layout(hovermode = "closest",
           xaxis=list(title=" "),
           yaxis=list(title="Value (see Indicator description for details")
    )
  
})

output$resultMap <- renderLeaflet({
  
  req(wbData()$test)
  
  mostRecent <- wbData()$test %>% 
                filter(date==wbData()$latest)
  
  countries2 <- sp::merge(maps, 
                          mostRecent, 
                          by.x = "iso_a2", 
                          by.y = "iso2c",                    
                          sort = FALSE)
  
  countries2$value <- round(countries2$value,1)
  
  
  country_popup <- paste0("<strong>Country: </strong>", 
                          countries2$country, 
                          "<br>",
                          countries2$date,
                          "<br>",
                          countries2$value)
  
  leaflet(data = countries2) %>% #leaflet supports matrices,data.frames and spatial objects from sp package
    setView(0,0,zoom=1) %>% 
    addTiles() %>%
    addPolygons(fillColor = ~pal(value), 
                fillOpacity = 0.8, 
                color = "#BDBDC3", 
                weight = 1,
                popup = country_popup
    ) %>% 
    addLegend(pal = pal, 
              values = ~countries2$value, 
              position = "bottomright", 
              title = " ") #%>% 
           
    #mapOptions(zoomToLimits="first")
})