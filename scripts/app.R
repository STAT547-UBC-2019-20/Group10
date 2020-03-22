# Your solution here

# Author: Xuemeng Li
# Date: March 21, 2020

"This script is the main file that creates a Dash app.

Usage: app.R
"

# 1. Load libraries
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)


# 2. Create Dash instance
app <- Dash$new()

# 3. Specify App layout
app$layout(
  htmlDiv(
    list(
      htmlH1('Austrilia Wildfire Analysis'),
      dccRadioItems(
        options =list(
          list(label = "Map", value = "Map"),
          list(label = "Analysis", value = "Analysis" )
        ),
        value = "Map"
      ),
      dccDropdown(
        options=list(
          list(label = "Day", value = "Day"),
          list(label = "Night", value = "Night")
        ),
        value = "Day"
      ),
      htmlImg(src = "https://disasterphilanthropy.org/wp-content/uploads/2019/11/Map-of-Australia-Fires_Dec-62019-e1575686810851.png")
    )
  )
)


# 4. Run app
app$run_server(debug = TRUE)