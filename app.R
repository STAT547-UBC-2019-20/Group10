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

## Assign components to variables
heading_title <- htmlH1('Austrilia Wildfire Analysis')

dropdown_list <- dccDropdown(
  options=list(
    list(label = "Day", value = "Day"),
    list(label = "Night", value = "Night")
  ),
  value = "Day"
)

## Specify layout elements
div_header <- htmlDiv(
  list(
    heading_title
  ),
  style = list(
    backgroundColor = '#008420', 
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
       return(htmlDiv(list(
         htmlImg(src = "https://github.com/STAT547-UBC-2019-20/Group10/raw/master/images/geogram.png", 
                 style=list( "max-width" = "80%", height = "auto", "margin-left" = "auto", "margin-right" = "auto", display = "block"))
       )))}
     else if(tab == 'tab-2'){
       return(htmlDiv(
         tab_analysis
       ))}
   }
)

# Update analysis graphs
app$callback(
  output(id = 'lm-graph', property = 'figure'),
  params = list(input(id = 'lm_variable', property = 'value'),
                input(id = 'lm_int', property = 'value')),
  function(){
    lmPlot(predictor, intensity)
  }
)

# 4. Run app
app$run_server(debug = TRUE)