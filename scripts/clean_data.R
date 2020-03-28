# author: Stanley Nam
# date: 2020-03-05

"This script loads a .csv file, removes unused columns, and then saves the result as a new .csv file. This script takes two argumenst: the path to the raw data and the path where the result should be saved.

Usage: clean_data.R --path_raw=<path_raw> --path_result=<path_result>
" -> doc

suppressPackageStartupMessages(library(tidyverse)) # "shut up, tidyverse"
library(docopt)

options(readr.num_columns = 0)

opt <- docopt(doc)

main <- function(path_raw, path_result){
  checked_pathes <- path_check(path_raw, path_result) # check and validate two pathes
  path_raw <- checked_pathes[1]
  path_result <- checked_pathes[2]
  
  print(paste0("Raw data path: ", path_raw))          # printout the final pathes
  print(paste0("Clean data path: ", path_result))
  
  cleaned_data <- remove_columns(path_raw)            # remove columns 
  
  save_clean_data(cleaned_data, path_result)          # save the result of the preprocessing
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
#' path_check('data/abc.csv', 'data/efg.csv')
path_check <- function(path_raw, path_result){
  pathes <- c(path_raw, path_result)
  pathes <- gsub("\\\\","/", pathes)
  
  for (i in 1:length(pathes)){
    path <- pathes[i]
    if (!grepl("/", path)){
      pathes[i] <- paste0(here::here("data"), "/", path)
    } else if (grepl("data/", path)){
      sep_path <- unlist(strsplit(path, "/"))
      clean_path <- paste0(sep_path[grep("data",sep_path):length(sep_path)], collapse = "/")
      pathes[i] <- here::here(clean_path)
    } else {
      if (!file.exists(path)){
        pathes[i] <- here::here(path)
      }
    }
  }
  
  if (pathes[1] == pathes[2]){
    no_ext <- unlist(strsplit(pathes[2], ".csv"))
    ext <- ".csv"
    pathes[2] <- paste0(no_ext,"_cleaned",ext)
  }
  print(pathes)
  if(!file.exists(pathes[1])){
    stop("There is no raw file by the path you entered. Please try again.")
  }
    return(pathes)
}

#' removes unused columns
#' this function removes following columns: acq_date, acq_time, satellite, instrument, daynight, type, version
#' however, the value of daynight column gets re-coded as a new column named 'is_day'
#' @param path_raw is a string. the path to the raw data. This parameter is internally sanitized.
#' @examples
#' remove_columns(path_raw)
remove_columns <- function(path_raw){
  raw_csv <- read_csv(path_raw)
  return_tibble <- raw_csv %>%
    mutate(is_day = factor(ifelse(daynight == "D", 1, 0))) %>%
    select(-acq_date, -acq_time, -satellite, -instrument, -daynight, -type, -version)
  return(return_tibble)
}

#' saves cleaned data to the designated path and prints a message so that the user knows all are good :)
#' @param cleaned_data the cleaned data, passed by remove_columns()
#' @param path_result is a string. the destination path where the result should be saved. sanity checked by path_check()
#' @examples
#' path_check(cleaned_data, path_result)
save_clean_data <- function(cleaned_data, path_result){
  write_csv(cleaned_data, path_result)
  print(paste0("Successful! Unused columns removed. Cleaned data is saved as ", path_result))
}

main(opt$path_raw, opt$path_result)
