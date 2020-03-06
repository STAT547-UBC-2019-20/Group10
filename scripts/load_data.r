# author: Stanley Nam
# date: 2020-03-05

"This script loads in a dataset and saves it in the 'data' directory. This script takes the raw data URL as the variable argument.

Usage: load_data.R <data_url>
" -> doc

library(docopt)

opt <- docopt(doc)

main <- function(data_url){
  target_dir = ""
  load_from_url (data_url, target_dir)
}

#' load data from the URL to raw data 'data_url'
#' 
#' @param data_url is a string. The URL path to the raw data
#' @param target_dir is a string. The path to the destination where the file is saved.
#' @examples
#' load_from_url('https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv')
load_from_url <- function (data_url, target_dir) { 
  print(data_url)
}  

main(opt$data_url)