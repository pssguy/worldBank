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
  #   print(input$hthTable_selected) #1 so it is row
  #   
  #   s = input$hthTable_selected
  #print(s)
  # print(glimpse(info()$tbl))
  # team <- info()$tbl[s,]$Opponents
})

# confirms works
output$rowCheck <- renderText({
  
  wbData()
})