library(tidyverse)
library(plotly)
library(effects)

# load the data from which graphs are to be plotted
cleanData <- read_csv(here::here("data", "cleaned_data.csv")) %>% mutate(is_day = factor(is_day))

# functions that draw two graphs
## linear model polotting
### pred : scan, track
### int : brightness, bright_t31,frp
lmPlot <- function(predictor = "scan", intensity = "brightness"){
  g <- ggplot(data = cleanData, aes(x=!!sym(predictor), y=!!sym(intensity), colour=is_day)) + 
    geom_smooth(method="lm") +
    ggtitle(paste0('The linear model of ', predictor, ' and ', intensity, ' by day/night')) +
    theme(plot.title = element_text(hjust = 0.5, size = 16), 
          axis.title=element_text(size=15),
          legend.title = element_text(size=15))
  
  ggplotly(g) %>%
    layout(clickmode = 'event+select')
}

## effect sizes plotting
### parameters : all, scan, track, is_day
### int : brightness, bright_t31,frp
effPlot <- function(predictor = "all", intensity = "brightness"){
  f <- as.formula(paste(intensity, 
                        paste(c("scan", "track", "is_day"), collapse = " + "),
                        sep = " ~ "))
  
  effmodel <- lm(f, data = cleanData)
  
  dfEffModel <- as.data.frame(allEffects(effmodel))
  
  if (predictor != "all") {
    dfEffModel <- dfEffModel[[predictor]]
  }
  
  plots <- lapply(dfEffModel, function(df) {
    if (nrow(df) == 2) { # nrow == 2 then categorical predictor
      g <- ggplot(df, aes_string(x = colnames(df)[1], y = colnames(df)[2], ymin = "lower", ymax = "upper")) +
        geom_point() +
        geom_errorbar()
      ggplotly(g)
    } else {
      g <- ggplot(df, aes_string(x = colnames(df)[1], y = colnames(df)[2])) +
        geom_line() +
        geom_ribbon(aes(ymin = lower, ymax = upper), alpha = .1)
      ggplotly(g)
      
    }
    })
  
  subplot(plots)
}

# create dropdowns
## for linear regression
lm_variableDropdown <- dccDropdown(
  id = "lm_variable",
  options=list(
    list(label = "Scan", value = "scan"),
    list(label = "Track", value = "track")
  ),
  value="scan"
)

lm_intensityDropdown <- dccDropdown(
  id = "lm_int",
  options=list(
    # brightness, bright_t31,frp
    list(label = "Brightness in Kelvin", value = "brightness"),
    list(label = "Channel 31 brightness temperature (Kelvin)", value = "bright_t31"),
    list(label = "Fire Radiative Power (megawatts)", value = "frp")
  ),
  value="brightness"
)

## for effect sizes
eff_predictorDropdown <- dccDropdown(
  id = "eff_predictor",
  options=list(
    list(label = "All", value = "all"),
    list(label = "Day/Night", value = "is_day"),
    list(label = "Scan", value = "scan"),
    list(label = "Track", value = "track")
  ),
  value="all"
)

eff_intensityDropdown <- dccDropdown(
  id = "eff_int",
  options=list(
    # brightness, bright_t31,frp
    list(label = "Brightness in Kelvin", value = "brightness"),
    list(label = "Channel 31 brightness temperature (Kelvin)", value = "bright_t31"),
    list(label = "Fire Radiative Power (megawatts)", value = "frp")
  ),
  value="brightness"
)


# assign graph components to variables
lm_graph <- dccGraph(
  id = 'lm-graph',
  figure = lmPlot()
)

effSize_graph<- dccGraph(
  id = 'effsize-graph',
  figure = effPlot()
)

# assign sidebar and main div to variables
## sidebar
analysis_sidebar <- htmlDiv(
  list(htmlLabel('Linear model'),
       htmlBr(),
       htmlLabel('Select variable'),
       lm_variableDropdown,
       htmlBr(),
       htmlLabel('Select intensity'),
       lm_intensityDropdown,
       htmlBr(),
       htmlLabel('Effect size'),
       htmlBr(),
       htmlLabel('Select predictor'),
       htmlBr(),
       eff_predictorDropdown,
       htmlBr(),
       htmlLabel('Select intensity'),
       eff_intensityDropdown
  ),
  style = list('padding' = 10,
               'flex-basis' = '20%')
)

## maindiv
analysis_maindiv <- htmlDiv(
  list(htmlLabel('Linear model'),
       lm_graph,
       htmlBr(),
       htmlLabel('Effect sizes'),
       effSize_graph
  ),
  style = list('padding' = 10,
               'flex-basis' = '80%')
)

# Assign the whole part as a htmlDiv. This one is to be called when tab2 is clicked in app.R
tab_analysis <- htmlDiv(
  list(
    analysis_sidebar,
    analysis_maindiv
  ),
  style = list('display' = 'flex')
)