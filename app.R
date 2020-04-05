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

div_side <- htmlDiv(
  list(
    dccMarkdown("
    **Use this app to get insight from Australian wildfire**
    
    **Two tabs: Map and Analysis. You can plot interactively on both.**
    
    'Map' is for the temporal development and overall status of the fires.
    Specify a certain date using the slide bar, or select 'All' from the dropdown to 
    plot the overall status.
    
    'Analysis' is for linear regression analysis with different predictors.
    You can plot a linear model and see the effect sizes of each factor there. 
    In the 'linear model' section, a linear model will be plotted as you select 
    variables and intensity.
    On the 'effect size' section, a graph (or set of them) will show you the effect 
    size of each factor. Select the predictor and intensity variable of your interest. 
    
    **Here is a brief description of the variables**
    
    Two types of variables in this dataset are observatory and intensity variables.
    'Scan', 'Track', and 'is_day' are observatory variables specifying the information 
    about an observation of fire from the satellite.
    
    'Scan' and 'Track' are for the specification of the satellite, and 'is_day' is about
    the time of the day when the observation occurred. (whether during the day or not)
    
    There are three intensity variables. 
    'Brightness' is the brightness of the fire core, measured in Kelvin.
    'Brightness_t31' is the channel 31 brightness temperature, also measured in Kelvin.
    'Frp' is for Fire Raditive Power, a representation of the fire intensity in MW.
    I hope you have fun. :)
    [Data source](https://www.kaggle.com/carlosparadis/fires-from-space-australia-and-new-zeland)"),
    htmlBr()
  ), style = list('background-color'='lightgrey', 
                  'columnCount'=1, 
                  'white-space'='pre-line')
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
      # title bar
      div_header,
      
      # under the title bar -- contain side bar (description and data source), and main bar (two tabs)
      htmlDiv(
        list(
          # Side bar
          div_side,
          # main bar -- the two tabs
          div_tabs
        ), style=list('display'='flex')
      )
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

# 4. Run app, change for deploy online
app$run_server(host = '0.0.0.0', port = Sys.getenv('PORT', 8050))

#app$run_server(debug = TRUE)