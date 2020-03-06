# Wildfire in Australia 
This GitHub repository is for all group activities done by *Monica Li* and *Stanley Nam* (Group 10) for STAT 547. Our topic is the wildfire in Australia and New Zealand. 

Here are the links for each milestone
* [Milestone 1](https://stat547-ubc-2019-20.github.io/Group10/docs/milestone1.html)
* [Final Report (Milestone 2)](https://stat547-ubc-2019-20.github.io/Group10/final_report.html)
* [Final Report (Milestone 2).pdf](https://stat547-ubc-2019-20.github.io/Group10/final_report.pdf)

## Usage
1. Clone this repo

2. Ensure the following packages are installed:
    - ggplot2
    - tidyverse
    - docopt
    - testthat
    - corrplot

3. Run the following scripts (in order) with the appropriate arguments specified

    \# Download data
    > Rscript scripts/load_data.r --data_url=<data_url>
    
  
    \# Wrangle/clean/process your data 
    > Rscript scripts/clean_data.R --path_raw=<path_raw> --path_result=<path_result>
    
  
    \# EDA script to export images
    > Rscript scripts/plot_grams.R --data_path=<data_path> 
    
    
    \# Knit your draft final report
    > Rscript scripts/knit_report.R --rmd_path=<rmd_path>
    
    
    \# For example:
    > Rscript scripts/load_data.r --data_url='https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv'
    >
    > Rscript scripts/clean_data.r --path_raw='fire_archive_M6_96619.csv' --path_result='cleaned_data.csv'
    >
    > Rscript scripts/plot_grams.R --data_path='data/cleaned_data.csv'
    >
    > Rscript scripts/knit_report.R --rmd_path="docs/milestone2.Rmd"
    
    
    
## Acknowledgements

We acknowledge the use of data products from the Land, Atmosphere Near real-time Capability for EOS (LANCE) system operated by NASA's Earth Science Data and Information System (ESDIS) with funding provided by NASA Headquarters.
