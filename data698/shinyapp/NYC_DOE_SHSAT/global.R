library(maps)
library(maptools)
library(leaflet)
library(sf)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)



# Years that are available for the NYC data
Year <- c(2016, 2017, 2018, 2019, 2020, 2021)

# Coordinates for NYC 
NYCLongitude <- -73.935242
NYCLatitude <- 40.730610

# NYC DOE School District Map Information
districts <- read_sf('schooldistricts.geojson')
districts$school_dist  <- as.numeric(districts$school_dist)

# Orders the geojson by school_dist
districts <- districts[with(districts, order(school_dist)), ]

# Color Palette
pal <- colorQuantile("YlGn", NULL, n = 3)

# School Information
school_info <- read_csv('2018-2021_school_information.csv')

# School offers have the offers for middle schools
school_offers <- read_csv('school_offers.csv')

# Convert Postcode to string
school_offers$Postcode <- as.character(school_offers$Postcode)

# Drop rows that have totalstudents == NA
school_info <- school_info %>% drop_na(totalstudents )  


# DF for Barplot
bar_plot_df <- school_offers %>%
  filter(!is.na(`2016_student_count`)) %>%
  filter(!is.na(`2016_testers_count`)) %>%
  filter(!is.na(`2016_offers_count`)) %>%
  filter(!is.na(`2017_student_count`)) %>%
  filter(!is.na(`2017_testers_count`)) %>%
  filter(!is.na(`2017_offers_count`)) %>%
  filter(!is.na(`2018_student_count`)) %>%
  filter(!is.na(`2018_testers_count`)) %>%
  filter(!is.na(`2018_offers_count`)) %>%
  filter(!is.na(`2019_student_count`)) %>%
  filter(!is.na(`2019_testers_count`)) %>%
  filter(!is.na(`2019_offers_count`)) %>%
  filter(!is.na(`2020_student_count`)) %>%
  filter(!is.na(`2020_testers_count`)) %>%
  filter(!is.na(`2020_offers_count`)) %>%
  filter(!is.na(`2021_student_count`)) %>%
  filter(!is.na(`2021_testers_count`)) %>%
  filter(!is.na(`2021_offers_count`)) %>%
  group_by(district) %>%
  summarise(sc_2016 = sum(`2018_student_count`),
            tc_2016 = sum(`2018_testers_count`),
            oc_2016 = sum(`2018_offers_count`),
            sc_2017 = sum(`2018_student_count`),
            tc_2017 = sum(`2018_testers_count`),
            oc_2017 = sum(`2018_offers_count`),
            sc_2018 = sum(`2018_student_count`),
            tc_2018 = sum(`2018_testers_count`),
            oc_2018 = sum(`2018_offers_count`),
            sc_2019 = sum(`2019_student_count`),
            tc_2019 = sum(`2019_testers_count`),
            oc_2019 = sum(`2019_offers_count`),
            sc_2020 = sum(`2020_student_count`),
            tc_2020 = sum(`2020_testers_count`),
            oc_2020 = sum(`2020_offers_count`),
            sc_2021 = sum(`2021_student_count`),
            tc_2021 = sum(`2021_testers_count`),
            oc_2021 = sum(`2021_offers_count`))

bar_plot_df <- as.data.frame(bar_plot_df)

