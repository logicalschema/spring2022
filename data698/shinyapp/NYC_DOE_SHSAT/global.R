library(maps)
library(maptools)
library(leaflet)
library(sf)
library(tidyverse)
library(dplyr)
library(ggplot2)



# Years that are available for the NYC data
Year <- c(2018, 2019, 2020, 2021)

# Coordinates for NYC 
NYCLongitude <- -73.935242
NYCLatitude <- 40.730610

# NYC DOE School District Map Information
districts <- read_sf('schooldistricts.geojson')
districts$school_dist  <- as.numeric(districts$school_dist)

# Color Palette
pal <- colorQuantile("YlGn", NULL, n = 3)

# School Information
school_info <- read_csv('2018-2021_school_information.csv')

# School offers have the offers for middle schools
school_offers <- read_csv('school_offers.csv')

# Convert Postcode to string
school_offers$Postcode <- as.character(school_offers$Postcode)

# Remove from columns that are not needed
school_offers <- subset(school_offers, select = -c(`name`, `telephone`, `address`, `2016_student_count`, `2016_testers_count`,`2016_offers_count`,`2017_student_count`,`2017_testers_count`,`2017_offers_count`))


# Drop rows that have totalstudents == NA
school_info <- school_info %>% drop_na(totalstudents )


