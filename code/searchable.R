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
 #  print(searchData()$searchValue)
 # df<- wbsearch(pattern = searchData()$searchValue, fields = c("indicator", "indicatorDesc"),
 #           extra = TRUE) # have not got latest cache
 # 
 searchData() %>%
   select(indicatorID,indicator,indicatorDesc) %>% 
                         DT::datatable(class='compact stripe hover row-border order-column',rownames=TRUE,selection='single',options= list(paging = TRUE, searching = TRUE,info=FALSE,
                                                                                                                                           columnDefs = list(list(visible=FALSE, targets=list(1)))))
})

#options=list(columnDefs = list(list(visible=FALSE, targets=columns2hide)))

## now get data for selected table

wbData <- reactive({
  
  if(is.null(input$tableChoice_rows_selected)) return()
  
  
  s = as.integer(input$tableChoice_rows_selected)
  
  id <- searchData()[s,]$indicatorID
  df <- wb(indicator = id,  POSIXct = TRUE) # with true a data fied is added for jan 1 eg 2014-01-01 and granuality annual
  
  print(glimpse(df))
  print(df$iso2c)
  print(unique(df$country))
  
  write_csv(df,"data/problems.csv")
  
  test <- df %>% 
   select(-iso2c) %>% # appears as this is sometimes not shown
    left_join(countries) %>% 
    filter(!is.na(long))
  
  print(glimpse(test))
  
  info=list(id=id,df=df,test=test)
  return(info)
  
})

# confirms works
output$rowCheck <- renderText({
  
  wbData()$id
})

output$resultTable <- DT::renderDataTable({
  
  req(wbData()$test)
  print("wbData()$test")
  print(glimpse(wbData()$test))
  
  wbData()$test %>% 
    select(country,date,value)%>%
                         DT::datatable(class='compact stripe hover row-border order-column',rownames=FALSE,options= list(paging = TRUE, searching = TRUE,info=FALSE))
  
})