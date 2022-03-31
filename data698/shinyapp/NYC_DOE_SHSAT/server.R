#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    mapPlot <- reactive({
      
      tempYear <- input$mapYear
      
      # Store the records for school_info with the corresponding year
      schoolsYear <- school_info[school_info$year == tempYear, ]
      
      sc <- paste(toString(tempYear), 'student', 'count', sep="_")
      tc <- paste(toString(tempYear), 'testers', 'count', sep="_")
      oc <- paste(toString(tempYear), 'offers', 'count', sep="_")
      
      # Store the Year offers
      schooloffersYear <-  subset(school_offers, select = c('dbn', 'district', 'Postcode', 'Borough', 'url', 'Latitude', 'Longitude', sc, tc, oc))

      by_district <-  schooloffersYear %>% 
            filter(!is.na(!!!as.name(sc))) %>%
            filter(!is.na(!!!as.name(tc))) %>%
            filter(!is.na(!!!as.name(oc))) %>%
            group_by(district) %>%
            summarise(total_students = sum(!!!as.name(sc)),
                      total_testers = sum(!!!as.name(tc)),
                      total_offers = sum(!!!as.name(oc)))
      
      m <- data.frame(by_district)
      m$proportion <- (m$total_offers / m$total_testers)
      temp <- select(m, c(district, proportion, total_students, total_testers))
      
      districts_number <- districts$school_dist
      districts_number <- data.frame(districts_number)
      temp2 <- merge(districts_number, temp, by.x = 'districts_number', by.y='district')
      
      district_popup <- paste0("<strong>School District: </strong>", temp2$districts_number, "<br>", 
                               "<strong>Proportion of Offers: </strong>", format(round(temp2$proportion, 4), nsmall = 4), "<br>",
                               "<strong>Total Middle School Students: </strong>", temp2$total_students, "<br>",
                               "<strong>Total Test Takers: </strong>", temp2$total_testers, "<br>",
                               "<strong>Proportion of Test Takers: </strong>", format(round(temp2$total_testers / temp2$total_students, 4), nsmall = 4) )
      
      map <- leaflet() %>%
        addTiles() %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        setView(lng = NYCLongitude, lat = NYCLatitude, zoom = 10) %>%
        addPolygons(data=districts, fillColor=~pal(temp2$proportion), color="darkgrey", weight=1, popup=district_popup) %>%
        addLegend("bottomright", pal = pal, values = temp2$proportion,
                title = "Proportion of Offers",
                opacity = 1
         )
      
      return(map)
      
      
    })


    
barPlot <- reactive({
  tempYear <- input$mapYear
  
  sc <- paste("sc", toString(tempYear), sep="_")
  tc <- paste("tc", toString(tempYear), sep="_")
  oc <- paste("oc", toString(tempYear), sep="_")
  
  
  barplot <- ggplot(data=bar_plot_df, aes(x=district)) + 
    geom_bar(aes_string(y=sc), stat="identity", position ="identity", alpha=.8, fill='#e0ecf4') +
    geom_bar(aes_string(y=tc), stat="identity", position="identity", alpha=.8, fill='#9ebcda') + 
    geom_bar(aes_string(y=oc), stat="identity", position="identity", alpha=.8, fill='#8856a7') + 
    theme_classic() +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(x = "District", y = "Value") +
    ggtitle(paste0("Bar Plot of Districts in ", tempYear))
  
  
  return(barplot)
  
  
  
  
  
})

    
    output$nycmap <- renderLeaflet({
      withProgress(message = 'Calculations in progress',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:5) {
                       incProgress(1/5)
                       Sys.sleep(0.25)
                     }
                   })
      mapPlot()

    })
    
    
    output$distPlot <- renderPlot({
      barPlot()
      
      
      
    })

    
    
    
})
