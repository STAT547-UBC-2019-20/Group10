# Author: Xuemeng Li
# Date: March 21, 2020

"This script is the main file that creates a Dash app.

Usage: app.R
"

# 1. Load libraries
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(tidyverse))

## Functions and Tabs
source(here::here("scripts", "dash_analysisTab.R"))
source(here::here("scripts", "dash_mapTab.R"))

## Assign components to variables
heading_title <- htmlH1('Austrilia Wildfire Analysis')
heading_subtitle <- htmlH2('Observe satellite data interactively')

## Specify layout elements
div_header <- htmlDiv(
  list(
    heading_title,
    heading_subtitle
  ),
  style = list(
    backgroundColor = '#8691F2', 
    textAlign = 'center',
    color = 'white',
    margin = 5,
    marginTop = 0
  )
)

div_tabs <- htmlDiv(
  list(
  dccTabs(id="tabs", value='tab-1', children=list(
    dccTab(label='Map', value='tab-1'),
    dccTab(label='Analysis', value='tab-2')
  )),
  htmlDiv(id='tabs-content')
))

# 2. Create Dash instance
app <- Dash$new()

# 3. Specify App layout
app$layout(
  htmlDiv(
    list(
      div_header,
      div_tabs
    )
  )
)

## App Callbacks

# Switch between tabs
app$callback(
  output('tabs-content', 'children'),
  params = list(input('tabs', 'value')),
  function(tab){
     if(tab == 'tab-1'){
       return(htmlDiv(
         tab_map
       ))}
     else if(tab == 'tab-2'){
       return(htmlDiv(
         tab_analysis
       ))}
   }
)


# Update the slider for map and date
app$callback(
  output(id = 'slider_label', property = 'children'),
  params = list(input(id = 'map_slider', property = 'value')),
  function (slider_value) {
    sprintf('Date: %s', as.Date(slider_value, origin = "2019-08-10"))
  }
)

app$callback(
  output(id = 'map_graph_by_date', property = 'figure'),
  params = list(input(id = 'map_slider', property = 'value')),
  function(input_date){
    select_date <- date_data %>% slice(input_date)
    make_plot(select_date)
  }
)

# Updte the map between all and sliding
app$callback(
  output(id = 'map_maindiv', property = 'children'),
  params = list(input(id = 'map_dropdown', property = 'value')),
  function (dropdown_value) {
    if (dropdown_value == '1'){
      return(htmlDiv(
        list(
          htmlH2('Fire on each day on map'),
          map_markdown,
          htmlH4(id = 'slider_label'),
          graph,
          slider
        ))
      )
    } else if (dropdown_value == '2'){
      return(htmlDiv(
        list(
          htmlH2('Fire over all time'),
          htmlImg(src = "https://github.com/STAT547-UBC-2019-20/Group10/raw/master/images/geogram.png",
                 style=list( "max-width" = "80%", height = "auto", "margin-left" = "auto", "margin-right" = "auto", display = "block"))
        )
      ))
    }
  }
)

# Update analysis graphs
app$callback(
  output(id = 'lm-graph', property = 'figure'),
  params = list(input(id = 'lm_variable', property = 'value'),
                input(id = 'lm_int', property = 'value')),
  function(predictor, intensity){
    lmPlot(predictor, intensity)
  }
)

# Update effect size graphs
app$callback(
  output(id = 'effsize-graph', property = 'figure'),
  params = list(input(id = 'eff_predictor', property = 'value'),
                input(id = 'eff_int', property = 'value')),
  function(predictor, intensity){
    effPlot(predictor, intensity)
  }
)

# 4. Run app
app$run_server(debug = TRUE)