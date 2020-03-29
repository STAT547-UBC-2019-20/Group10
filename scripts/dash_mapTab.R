# Load data 
Data <- read_csv(here::here("data", "fire_archive_M6_96619.csv"))
date_data <- Data %>%
  select(acq_date) %>%
  unique()

map_data <- Data %>%
  select(latitude, longitude, frp, brightness, acq_date) 

# Plot funciton 
first_date <- date_data %>% slice(1)

make_plot <- function(input_date = first_date){
  
  select_data <- filter(map_data, acq_date == input_date)
  
  select_data <- select_data %>% select(-acq_date)
  
  # make the plot!

  p <- ggplot() +
    geom_point(data=select_data,aes(x=longitude,y=latitude, size = frp, color=brightness), alpha = 0.5) +
    xlab ("Longitude, degree(East as positive)") +
    ylab ("Latitude, degree(North as positive)") +
    ggtitle('Brightness and Radiation Power vs. Geometric info') +
    theme(plot.title = element_text(hjust = 0.5, size = 14), legend.title = element_text(size=12))

  ggplotly(p)
  
}

graph <- dccGraph(
  id = 'map_graph_by_date',
  figure = make_plot()
)
# Dash Components

dropdown_list <- dccDropdown(
  options=list(
    list(label = "Day", value = "1"),
    list(label = "Night", value = "2")
  ),
  value = "Day"
)

slider <- dccSlider(
  id = 'map_slider',
  min = 1,
  max = 61,
  marks = list(
    "1" = list('label' = as.Date(1, origin = "2019-08-10")),
    "11" = list('label' = as.Date(11, origin = "2019-08-10")),
    "21" = list('label' = as.Date(21, origin = "2019-08-10")),
    "31" = list('label' = as.Date(31, origin = "2019-08-10")),
    "41" = list('label' = as.Date(41, origin = "2019-08-10")),
    "51" = list('label' = as.Date(51, origin = "2019-08-10")),
    "61" = list('label' = as.Date(61, origin = "2019-08-10"))
  ),
  value = 1
)



tab_map <- htmlDiv(
  list(
    htmlH3('Fire over time'),
    htmlLabel(id = 'slider_label'),
    graph,
    slider,
    htmlH3('Fire all the time'),
    htmlImg(src = "https://github.com/STAT547-UBC-2019-20/Group10/raw/master/images/geogram.png", 
            style=list( "max-width" = "80%", height = "auto", "margin-left" = "auto", "margin-right" = "auto", display = "block"))
    
  )
)