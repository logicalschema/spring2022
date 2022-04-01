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

    # Application title
    titlePanel(title=span(img(src="https://sps.cuny.edu/sites/all/themes/cuny/assets/img/header_logo.png"), 
                          br(),
                          h3("NYC Specialized High Schools Offers Ratio by District: 2018-2021")
                          )),


    # Sidebar with a select input for map year
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = 'mapYear',
                      label = h4('Year'),
                      choices = Year,
                      selected = 2021)
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
             plotOutput("distPlot")
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
    )

    
    
))
