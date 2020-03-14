# author: Stanley Nam
# date: 2020-03-13

"This script runs logistic regressions on the .csv file specified by the user and exports the result.

Usage: analysis.R --data_path=<data_path>
" -> doc

library(docopt)
library(dplyr)
library(effects)
library(ggplot2)

opt <- docopt(doc)

main <- function (data_path) {
  message(paste0("Generating logistic regression model with: ", data_path))
  analysis (data_path)
  message(paste0("Successful! The model is saved as 'model.rds' in root and plots of effect size is saved in images/"))
}

#' logistic regression.
#' 
#' @param data_path is a string. The path to the data
#' @examples
#' analysis ('data/fire_archive_M6_96619.csv')
analysis <- function(data_path){
  raw <- read.csv(data_path, header = T)
  model <- lm(brightness ~ scan + track + daynight, data = raw)
  model_n <- lm(brightness ~ scan + track, data = raw)
  signific <- anova(model_n, model, test ="Chisq")
  save(model, model_n, signific, file = here::here("models.rda"))
  
  ggplot(data = raw, aes(x=scan, y=brightness, colour=daynight))+geom_smooth(method="lm")+
    ggsave('images/scan-daynight.png')

  ggplot(data = raw, aes(x=track, y=brightness, colour=daynight))+geom_smooth(method="lm") +
    ggsave('images/track-daynight.png')
  
  png(here::here("images","effectSizes.png"))
  plot(allEffects(model))
  dev.off()
  
}

main(opt$data_path)
