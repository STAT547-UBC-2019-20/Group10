# author: Stanley Nam
# date: 2020-03-05

"This script loads a .csv file, removes unused columns, and then saves the result as a new .csv file. This script takes two argumenst: the path to the raw data and the path where the result should be saved.

Usage: clean_data.R --path_raw=<path_raw> --path_result=<path_result>
" -> doc

library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(path_raw, path_result){
  checked_pathes <- path_check(path_raw, path_result)
  path_raw <- checked_pathes[1]
  path_result <- checked_pathes[2]
  print(path_raw)
  print(path_result)
  cleaned_data <- remove_columns(path_raw)
  
  save_clean_data(cleaned_data, path_result)
}

#' sanity check on pathes before loading / saving a file.
#' 1. if the user simply gave a filename without any folder name specified, assume that the user refers to a file under
#' 'data' folder, and change the variable accordingly.
#' 2. overwriting on the raw data file is unbearable. so if the raw data path and result data path are the same, 
#' add '_cleaned' suffix to the result path.
#' 3. if the specified raw data file does not exist, raise error.
#' @param path_raw is a string. the path to the raw data. only a file name or a full path expected
#' @param path_result is a string. the destination path where the result should be saved. only a file name or a full path expected
#' @examples
#' path_check('abc.csv', 'efg.csv')
#' path_check('C:/Users/STAT547/data/abc.csv', 'C:/Users/STAT547/data/efg.csv')
path_check <- function(path_raw, path_result){
  pathes <- c(path_raw, path_result)
  
  for (i in 1:length(pathes)){
    if (!grepl("\\\\|/", pathes[i])){
  }
    pathes[i] <- paste0(here::here("data"), "/", pathes[i])
  }
  
  if (pathes[1] == pathes[2]){
    no_ext <- unlist(strsplit(pathes[2], ".csv"))
    ext <- ".csv"
    pathes[2] <- paste0(no_ext,"_cleaned",ext)
  }
  
  if(!file.exists(pathes[1])){
    stop("There is no raw file by the path you entered. Please try again.")
  }
    return(pathes)
}

#' sanity check on pathes before loading / saving a file.
#' 1. if the user simply gave a filename without any folder name specified, assume that the user refers to a file under
#' 'data' folder, and change the variable accordingly.
#' 2. overwriting on the raw data file is unbearable. so if the raw data path and result data path are the same, 
#' add '_cleaned' suffix to the result path.
#' 3. if the specified raw data file does not exist, raise error.
#' @param path_raw is a string. the path to the raw data. only a file name or a full path expected
#' @param path_result is a string. the destination path where the result should be saved. only a file name or a full path expected
#' @examples
#' path_check('abc.csv', 'efg.csv')
#' path_check('C:/Users/STAT547/data/abc.csv', 'C:/Users/STAT547/data/efg.csv')
remove_columns <- function(path_raw){
  return()
}

#' sanity check on pathes before loading / saving a file.
#' 1. if the user simply gave a filename without any folder name specified, assume that the user refers to a file under
#' 'data' folder, and change the variable accordingly.
#' 2. overwriting on the raw data file is unbearable. so if the raw data path and result data path are the same, 
#' add '_cleaned' suffix to the result path.
#' 3. if the specified raw data file does not exist, raise error.
#' @param path_raw is a string. the path to the raw data. only a file name or a full path expected
#' @param path_result is a string. the destination path where the result should be saved. only a file name or a full path expected
#' @examples
#' path_check('abc.csv', 'efg.csv')
#' path_check('C:/Users/STAT547/data/abc.csv', 'C:/Users/STAT547/data/efg.csv')
save_clean_data <- function(cleaned_data, path_result){
  return()
}

main(opt$path_raw, opt$path_result)