#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tags$head(includeHTML(("analytics.html")),
    tags$head(tags$link(rel = "icon", type="image/x-icon", href = "favicon.ico"))
              ),

    

    # Application title and top row
    title = "NYC Middle School SHSAT Offers Ratio by District: 2016-2021",
    fluidRow(
      column(4,
            tags$a(
              href="https://sps.cuny.edu/",
              img(src="https://sps.cuny.edu/sites/all/themes/cuny/assets/img/header_logo.png", 
                align="left", 
                style="padding: 2em; max-width: 100%; height: auto", 
                title="CUNY SPS Logo"
                )
              ),
      ),
      column(8,
             h2("NYC Middle School SHSAT Offers Ratio by District: 2016-2021",
                style="padding: 20px 25px 20px"),

      ),
    ),
  

    # Sidebar with a select input for map year
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = 'mapYear',
                      label = h4('Year'),
                      choices = Year,
                      selected = 2021),
          p("Select a year to modify the map and bar graphs in order to see how a district performed."),
          
          p("All of the public middle schools were combined. Total students represents the total reported by middle schools in the district.  
             The total testers represents the total reported numbers for middle schools in the district who reported SHSAT test takers.  
             The total offers represents the total number of offers for specialized high schools received at the middle schools for the district."
            )
          
          ),
        

        # Show a plot of the generated distribution
        mainPanel(
            leafletOutput('nycmap', width = '100%', height = '600'),
        )
    ),
    
    br(),
    tags$hr(),
    
    fluidRow(
      column(10,
             plotlyOutput("distPlot")
      ),
      column(2,
             tags$ul(class="legend",
               tags$li(style="color:#e0ecf4;list-style-type:square;font-size:20pt",
                 tags$span(style="color:black;font-size:10pt", "Total Students")
               ),
               tags$li(style="color:#9ebcda;list-style-type:square;font-size:20pt",
                 tags$span(style="color:black;font-size:10pt", "Total Testers")
               ),
               tags$li(style="color:#8856a7;list-style-type:square;font-size:20pt",
                 tags$span(style="color:black;font-size:10pt", "Total Offers")
               )
               
             ),
             
      )
    ),
    
    fluidRow(
      column(12, style="background-color:#1D3A83;padding:25px;",
             tags$p("Links", style="color:white"),
             tags$ul(class="legend",
                     tags$li(style="color:white",
                             tags$a(href="https://logicalschema.shinyapps.io/NYC_DOE_SHSAT/", style="color:white", "Home")
                     ),
                     tags$li(style="color:white",
                             tags$a(href="https://sslee-specializedhs.azurewebsites.net/", style="color:white", "Individual Middle Schools (Python App)")
                     ),
                     tags$li(style="color:white",
                             tags$a(href="https://github.com/logicalschema/spring2022/tree/main/data698", style="color:white", "GitHub Page")
                     )
                     
             ),
             
        
        
      )
    )

    
    
))
