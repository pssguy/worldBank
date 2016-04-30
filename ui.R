

dashboardPage(skin="yellow", title = "World Bank",
  dashboardHeader(title = "World Bank"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
   

    
    sidebarMenu(
      menuItem("Searchable", tabName = "searchable", icon = icon("search")),
      
      inputPanel(
      
      textInput("searchValue", 
                label="Enter a term of interest. The resulting table can be further searched    
                Click on row of required indicator and after a few seconds a table of all the data,
                a chart showing up to ten least-developed nations from latest data, and map of countries covered by indicator
                will appear",
                placeholder="Enter term e.g. Poverty")
     
      ),
      actionButton("searchWB","Go"),
      menuItem("Info", tabName = "info",icon = icon("info")),
      
      
      tags$hr(),
      menuItem(text="",href="https://mytinyshinys.shinyapps.io/dashboard",badgeLabel = "All Dashboards and Trelliscopes (14)"),
      tags$hr(),
      
      tags$body(
        a(class="addpad",href="https://twitter.com/pssGuy", target="_blank",img(src="images/twitterImage25pc.jpg")),
        a(class="addpad2",href="mailto:agcur@rogers.com", img(src="images/email25pc.jpg")),
        a(class="addpad2",href="https://github.com/pssguy",target="_blank",img(src="images/GitHub-Mark30px.png")),
        a(href="https://rpubs.com/pssguy",target="_blank",img(src="images/RPubs25px.png"))
      )
    )
  ),
  
  dashboardBody(tabItems(
    tabItem(
      "searchable",
      fluidRow(column(width=12,
      box(width=12,collapsible=TRUE,solidHeader = TRUE,status = 'success',title="Click Required Indicator for Results  Collapse box for easier viewing of outputs",
         
      
      DT::dataTableOutput("tableChoice")
      ))),
     
     fluidRow(column(width=12,
                     h2(textOutput("resultTitle"))
     )),
      fluidRow(column(width=2,
      box(width=12,title="All Data",
        DT::dataTableOutput("resultTable")
      )),
      column(width=5,
      box(width=12,title="Extreme Countries - Add/Remove countries by clicking legend",
          inputPanel(
          radioButtons("extreme",label = "Extreme Countries",choices=c("Bottom","Top"),inline= TRUE),
          radioButtons("incZero",label = "Include Zero values",choices=c("No","Yes"),inline= TRUE)
          ),
          plotlyOutput("resultPlot")
      )),
      column(width=5,
      box(width=12,title="Map of latest Data Pan/Zoom and click for details",
        leafletOutput("resultMap")
      )))
     
    ),
    tabItem("info",includeMarkdown("info.md"))
    
  ))
)
