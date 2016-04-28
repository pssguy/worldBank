

dashboardPage(skin="yellow",
  dashboardHeader(title = "World Bank"),
  
  dashboardSidebar(title = "World Bank",
    includeCSS("custom.css"),

    
    sidebarMenu(
      menuItem("Searchable", tabName = "searchable"),
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
      box(width=10,collapsible=TRUE,
      textInput("searchValue", label="Enter Search term e.g. Electricity", value="poverty"),

      actionButton("searchWB","Go"),
      
      DT::dataTableOutput("tableChoice")
      ),
      box(width=2,
          textOutput("rowCheck"))
      # selectInput("indicator","Enter search term e.g. electricity",choices=indicatorChoice),
      # actionButton("searchWB","Go"),
      # textOutput("check")
      #DT::dataTableOutput("choicesTable")
    )#,
   # tabItem("info",includeMarkdown("info.md"))
    
  ))
)
