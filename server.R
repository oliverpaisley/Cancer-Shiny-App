library(shiny)
library(ggplot2)
library(dplyr)

cancer_data       <- read.table('BYAREA.TXT', sep = '|', header = TRUE, 
                                stringsAsFactors = FALSE)
cancer_data$COUNT <- as.numeric(cancer_data$COUNT)

# Convert from data.frame to data_frame (to use with dplyr).
cancer_data       <- as_data_frame(cancer_data)

shinyServer(function(input, output) {
  
  output$mainPlot <- renderPlot({
    
    cancer <- cancer_data %>%
      filter(SITE       ==   input$type,  
             AREA       ==   input$area, 
             EVENT_TYPE %in% input$mort,
             SEX        %in% input$gender,
             YEAR       !=   '2007-2011') %>%
      select(YEAR, 
             COUNT, 
             SEX, 
             EVENT_TYPE) %>%
      group_by(YEAR, 
               SEX, 
               EVENT_TYPE) %>%
      summarise(COUNT = sum(COUNT, na.rm = TRUE)) %>%
      mutate(Legend = paste(SEX, EVENT_TYPE))
    
    qplot(YEAR, 
          COUNT, 
          data = cancer, 
          geom = 'line',
          ylab = 'Count',
          xlab = '') + aes(color = Legend, group = Legend)
  })
})