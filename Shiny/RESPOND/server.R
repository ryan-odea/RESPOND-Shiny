if(!require(pacman)) install.packages(pacman)
pacman::p_load(shiny,
               shinythemes,
               shinydashboard,
               shinyWidgets,
               tidyverse,
               sf,
               maps,
               leaflet,
               RColorBrewer)


shinyServer(function(input, output) {
  output$leafletMap <- renderLeaflet({
    #County shape file pull via maps:map()
    counties <- st_as_sf(maps::map("county", plot = FALSE, fill = TRUE)) %>% 
      subset(., grepl("massachusetts", .$ID)) %>%
      mutate(ID = str_to_title(str_extract(ID, '[^,]*$')))
    
    #Label Dataframe creation and Joining, passed to HTML
    countyData <- data.frame(name = counties$ID,
                             rand = runif(14, 0, 1))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g",
      countyData$name, countyData$rand) %>%
      lapply(htmltools::HTML)
    
    #Binned colors definition
    bins <- c(seq(0, 1, by = 0.2))
    pal <- colorBin("YlOrRd", 
                    domain = countyData$rand,
                    bins = bins)
    
    #Map Creation
    leaflet(counties,
            options = leafletOptions(minZoom = 7.8,
                                     maxZoom = 7.8,
                                     zoomControl = FALSE,
                                     dragging = FALSE)) %>% 
      addPolygons(fillColor = ~pal(countyData$rand),
                  weight = 2,
                  opacity = 1,
                  color = "black",
                  dashArray = 3,
                  fillOpacity = 0.8,
                  highlightOptions = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 1,
                    bringToFront = TRUE
                  ),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto"
                  )) %>% 
      addLegend(pal = pal, values = ~countyData$rand,
                title = "Opiod Deaths", position = "bottomleft")
  }) 

})
