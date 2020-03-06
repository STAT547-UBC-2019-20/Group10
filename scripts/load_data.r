# author: Stanley Nam
# date: 2020-03-05

"This script loads in a dataset and saves it in the 'data' directory. This script takes the raw data URL as the variable argument.

Usage: load_data.R --data_url=<data_url>
" -> doc

library(readr)
library(docopt)

opt <- docopt(doc)

main <- function(data_url){
  print(paste0("Downloading data file from: ", data_url))
  load_from_url (data_url, target_dir)
  print(paste0("Successful! The file lives in ", here::here("data")))
}

#' load data from the URL to raw data 'data_url'
#' 
#' @param data_url is a string. The URL path to the raw data
#' @param target_dir is a string. The path to the destination where the file is saved.
#' @examples
#' load_from_url('https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv')
load_from_url <- function (data_url, target_dir) { 
  target_dir <- here::here("data","fire_archive_M6_96619.csv")
  downloaded_csv <- read_csv(data_url)
  write_csv(downloaded_csv,target_dir)
}  

main(opt$data_url)