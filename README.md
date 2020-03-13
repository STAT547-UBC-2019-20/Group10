# Wildfire in Australia 
This GitHub repository is for all group activities done by *Monica Li* and *Stanley Nam* (Group 10) for STAT 547. Our topic is the wildfire in Australia and New Zealand. 

Here are the links for each milestone
* [Milestone 1](https://stat547-ubc-2019-20.github.io/Group10/docs/milestone1.html)
* [Final Report (Milestone 2)](https://stat547-ubc-2019-20.github.io/Group10/final_report.html)
* [Final Report (Milestone 2).pdf](https://stat547-ubc-2019-20.github.io/Group10/final_report.pdf)

## Usage

### Usage instructions for running scripts individually
1. Clone this repo

2. Ensure the following packages are installed:
    - ggplot2
    - tidyverse
    - docopt
    - testthat
    - corrplot

3. Run the following scripts (in order) with the appropriate arguments specified  
    - scripts/load_data.r  # Download data
    - scripts/clean_data.r # Wrangle/clean/process your data 
    - scripts/plot_grams.R # EDA script to export images 
    - scripts/knit_report.R # Knit the draft report
    
    To replicate this analysis, navigate to the root folder of this project in your terminal, and type in the following commands:
    > Rscript scripts/load_data.r --data_url='https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv'
    >
    > Rscript scripts/clean_data.r --path_raw='data/fire_archive_M6_96619.csv' --path_result='data/cleaned_data.csv'
    >
    > Rscript scripts/plot_grams.R --data_path='data/cleaned_data.csv'
    >
    > Rscript scripts/knit_report.R --rmd_path="docs/finalReport.Rmd"
    
### Usage instructions for GNU MAKE
A makefile has been created for this project, to use the makefile, please clone the repository, navigate to the root folder of this project in your terminal, and type in the following commands:

- Clean up the project repository:
    > make clean
    
- Generate the final outputs of the data analysis pipeline
    > make all
    
- Generate the individual output
    > make data/fire_archive_M6_96619.csv
    >
    > make data/cleaned_data.csv 
    >
    > make images/correllgram.png images/geogram.png 
    >
    > make finalReport.html finalReport.pdf
  
    
## Acknowledgements

We acknowledge the use of data products from the Land, Atmosphere Near real-time Capability for EOS (LANCE) system operated by NASA's Earth Science Data and Information System (ESDIS) with funding provided by NASA Headquarters.
