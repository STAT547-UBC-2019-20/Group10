# Wildfire in Australia 
This GitHub repository is for all group activities done by *Monica Li* and *Stanley Nam* (Group 10) for STAT 547. Our topic is the wildfire in Australia and New Zealand. 

Here are the links for each milestone
* [Milestone 1](https://stat547-ubc-2019-20.github.io/Group10/docs/milestone1.html)

* [Final Report](https://stat547-ubc-2019-20.github.io/Group10/finalReport.html)
* [Final Report.pdf](https://stat547-ubc-2019-20.github.io/Group10/finalReport.pdf)


## Usage

### Usage instructions for running scripts individually
1. Clone this repo

2. Ensure the following packages are installed:
    - ggplot2
    - tidyverse
    - docopt
    - testthat
    - corrplot
    - effects

3. Run the following scripts (in order) with the appropriate arguments specified  
    - scripts/load_data.R   
    - scripts/clean_data.R  
    - scripts/plot_grams.R  
    - scripts/analysis.R   
    - scripts/knit_report.R 
    - tests/test.R          
    
    To replicate this analysis, navigate to the root folder of this project in your terminal, and type in the following commands:
   
    > #### # Download data
    > Rscript scripts/load_data.R --data_url='https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv'
    > 
    > #### # Wrangle/clean/process your data 
    > Rscript scripts/clean_data.R --path_raw='data/fire_archive_M6_96619.csv' --path_result='data/cleaned_data.csv'
    >
    > #### # EDA script to analyse the data and export images 
    > Rscript scripts/plot_grams.R --data_path='data/cleaned_data.csv'
    >
    > #### # Logistic regressions
    > Rscript scripts/analysis.R --data_path='data/fire_archive_M6_96619.csv'
    >
    > #### # Knit the final report
    > Rscript scripts/knit_report.R --rmd_path='docs/finalReport.Rmd'
    >
    > #### # Test with testthat, checking the required inputs are all generated for kniting the report
    > Rscript tests/tests.R

    
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
    > make images/effectSize.png images/scan-daynight.png images/track-daynight.png models.rda
    >
    > make finalReport.html finalReport.pdf
    >
    > make tests
  
    
## Acknowledgements

We acknowledge the use of data products from the Land, Atmosphere Near real-time Capability for EOS (LANCE) system operated by NASA's Earth Science Data and Information System (ESDIS) with funding provided by NASA Headquarters.
