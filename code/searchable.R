##


searchData <- eventReactive(input$searchWB,{

req(input$searchValue)

print(input$searchValue) # eg poverty
searchValue <- input$searchValue


df<- wbsearch(pattern = searchValue, fields = c("indicator", "indicatorDesc"),
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
   select(indicator,indicatorDesc) %>% 
                         DT::datatable(class='compact stripe hover row-border order-column',rownames=TRUE,selection='single',options= list(paging = TRUE, searching = TRUE,info=FALSE))
})


## now get data for selected table

wbData <- reactive({
  
  if(is.null(input$tableChoice_rows_selected)) return()
  
  
  s = as.integer(input$tableChoice_rows_selected)
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