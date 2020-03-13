# author: Stanley Nam
# date: 2020-03-13

"This script runs logistic regressions on the .csv file specified by the user and exports the result.

Usage: analysis.R --data_path=<data_path>
" -> doc

library(docopt)
library(dplyr)
library(effects)

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
  model <- glm(brightness ~ scan + track + daynight, data = raw, family = "binomial")
  model_n <- glm(brightness ~ scn + track, data = raw, family = "binomial")
  signific <- anova(model_n, model, test ="Chisq")
  plots <- plot(allEffects(model_HLA))
  png(here::here("images","effectSize.png"))
  saveRDS(model, model_n, signific, file = here::here("models.rds"))
}

main(opt$data_path)