# author: Stanley Nam
# date: 2020-03-13

"This script runs logistic regressions on the .csv file specified by the user and exports the result.

Usage: analysis.R --data_path=<data_path>
" -> doc

library(docopt)
library(tidyverse)
library(effects)
library(ggplot2)
library(testthat)

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
  cleanData <- read_csv(data_path) %>% mutate(is_day = factor(is_day))
  
  # test if all the columns needed for analysis exist.
  test_that("Testing that required variables are in the data file", {
    expect_that(all(c("brightness", "scan", "track", "is_day") %in% colnames(cleanData)), is_true())
  })
  
  model <- lm(brightness ~ scan + track + is_day, data = cleanData)
  model_n <- lm(brightness ~ scan + track, data = cleanData)
  signific <- anova(model_n, model, test ="Chisq")
  save(model, model_n, signific, file = here::here("data", "models.rda"))
  
  ggplot(data = cleanData, aes(x=scan, y=brightness, colour=is_day)) + 
    geom_smooth(method="lm") +
    ggtitle('The linear model of scan and brightness by day/night') +
    theme(plot.title = element_text(hjust = 0.5, size = 16), 
          axis.title=element_text(size=15),
          legend.title = element_text(size=15)) +
    ggsave('images/scan-daynight.png', height=6, width=6)
  
  ggplot(data = cleanData, aes(x=track, y=brightness, colour=is_day))+geom_smooth(method="lm") +
    ggtitle('The linear model of track and brightness by day/night') +
    theme(plot.title = element_text(hjust = 0.5, size = 16), 
          axis.title=element_text(size=15),
          legend.title = element_text(size=15)) +
    ggsave('images/track-daynight.png', height=6, width=6)
  
  png(here::here("images","effectSizes.png"))
  plot(allEffects(model))
  dev.off()
  
}

main(opt$data_path)