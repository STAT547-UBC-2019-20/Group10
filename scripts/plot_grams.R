
# author: Monica Li
# date: 2020-03-05

"This script creates a correllogram and geometric diagram for the wildfire data that generated and cleaned in task 2.2, save the output image in image folder

Usage: plot_grams.R --data_path=<data_path> 
" -> doc 

library("tidyverse")
if (!requireNamespace("corrplot")) install.packages("corrplot")
library(corrplot)
library(docopt)

opt <- docopt(doc)

main <- function (data_path) {
  message(paste0("Drawing the correlogram and geometric diagram from: ", data_path))
  plot_correllogram (data_path)
  plot_geogram (data_path)
  message(paste0("Successful! Both grams have been saved in folder images/"))
}

#' plot a correllogram from input dataset
#' 
#' @param data_path is a string. The path to the wranggled and cleaned data
#' @examples
#' plot_correllogram ('data/fire_archive_M6_96619.csv')
plot_correllogram <- function (data_path) {
  wildfire_data <- read_csv(data_path)
  
  # Remove following out when part 2 is ready
  ## Drop the non-numeric variable colums
#  wildfire_correlations <-
#    wildfire_data %>%
#    select(-acq_date, -acq_time, -satellite, -instrument, -daynight, -type, -version)
  
  # Convert the numeric colums to 'double' type
  wildfire_correlations <- wildfire_data
  wildfire_correlations[1:8] <- sapply(wildfire_correlations[1:8], as.double)
  wildfire_correlations <- cor(wildfire_correlations[1:8])
  
  wildfire_correlations <- round(wildfire_correlations,2)
  png(filename='images/correllgram.png')
  corrplot(wildfire_correlations, 
           type="upper", 
           method="color", 
           tl.srt=45,
           addCoef.col = "blue",
           diag = FALSE,
           title="Correllogram for the numeric columns in wildfire dataset",
           mar=c(0,0,2,0)) 
  dev.off()
}

#' plot a geometric diagram for the input dataset
#' 
#' @param data_path is a string. The path to the wranggled and cleaned data
#' @examples
#' plot_geogram ('data/fire_archive_M6_96619.csv')
plot_geogram <- function (data_path) {
  
  wildfire_data <- read_csv(data_path)
  Map_data <- wildfire_data %>%
    select(latitude, longitude, frp, brightness) 
  
  ggplot() + 
    geom_point(data=Map_data,aes(x=longitude,y=latitude, size = frp, color=brightness), alpha = 0.5) +
    xlab ("Longitude, degree(East as positive)") +
    ylab ("Latitude, degree(North as positive)") +
    ggtitle('Brightness and Radiation Power vs. Geometric info') +
    theme(plot.title = element_text(hjust = 0.5, size = 14), legend.title = element_text(size=12))+
    ggsave('images/geogram.png', width = 8, height = 5)
  
}

main(opt$data_path)  