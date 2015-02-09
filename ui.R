# ui.R

library(shiny)
library(dplyr)

cancer_data <- read.table('BYAREA.TXT', sep = '|', header = TRUE,
                          stringsAsFactors = FALSE)

# These give us the values of the given variables.
types   <- unique(cancer_data$SITE)
areas   <- unique(cancer_data$AREA)
genders <- unique(cancer_data$SEX)
mort    <- unique(cancer_data$EVENT_TYPE)

shinyUI(
  fluidPage(
      
    fluidRow(
      column(3, selectInput("type", label = h3("Cancer Type"), choices = types, selected = 1)),
      
      column(3, selectInput("area", label = h3("Area"), choices = areas, selected = 1)),
      
      column(3, checkboxGroupInput("mort", label = h3("Incidence or Mortality"), choices = mort, selected = 1)),
      
      column(3, checkboxGroupInput("gender", label = h3("Gender"), choices = genders, selected = 1))
    ),
    
    mainPanel(
      plotOutput("mainPlot")  
    )
  )
)
