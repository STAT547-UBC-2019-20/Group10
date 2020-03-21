# Wildfire in Australia 
This GitHub repository is for all group activities done by *Monica Li* and *Stanley Nam* (Group 10) for STAT 547. Our topic is the wildfire in Australia and New Zealand. 

Here are the links for each milestone
* [Milestone 1](https://stat547-ubc-2019-20.github.io/Group10/docs/milestone1.html)
* [Milestone 2](https://stat547-ubc-2019-20.github.io/Group10/docs/milestone2.html)
* [Final Report](https://stat547-ubc-2019-20.github.io/Group10/docs/finalReport.html)
* [Final Report.pdf](https://stat547-ubc-2019-20.github.io/Group10/docs/finalReport.pdf)


## Usage

### Usage instructions for running scripts individually
    
    To replicate this analysis, clone this repo and navigate to the root folder of this project in your terminal, ensure the following packages are installed:
    - ggplot2
    - tidyverse
    - docopt
    - testthat
    - corrplot
    - effects
    
    and then type in the following commands:
   
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
    > make images/effectSize.png images/scan-daynight.png images/track-daynight.png data/models.rda
    >
    > make docs/finalReport.html docs/finalReport.pdf
    >
    > make tests


## Dashboard Proposal
### Dashboard description
The visualization that the app provides is two folds: a map that represents a snapshot of fire location at a given time and graphs that report the result of whether the intensity of fire differs by day or night. This app will be based on the fire observation data from the satellite. There will be radio buttons to select either ‘timeline view’ or ‘analysis view’
For the timeline view, there will be a snapshot of the Australian map with fire spots. The user may select a specific date and either day or night to show how much the fire has spread over the map. The colour and size of a single point on the map represents the intensity of the observed fire. The brighter dots are the higher core fire temperatures are. Points are bigger if the observed fire they represent has higher frp values. A slider will be used to specify the date and a dropdown menu for the day/night. For example, the user may select 2019-08-01 using the slider, and ‘day’ from the dropdown menu. This will result in a map of fire distributed over Australia as of the day of Aug 1, 2019.
For the ‘analysis view,’ the app will show the effect size of the day/night factor on the intensity of the fire. Two graphs for each linear model of day/night against another factor will be presented. Besides, a set of three graphs for each individual effect size will also be provided on the same screen.

### Usage scenarios
Jessica is a decision-maker at Fire and Rescue Services, interested in a way to effectively distribute limited resources in an unlikely event of a massive wildfire. The latest data from the Australian forest fire can give her a lesson. From the dataset, she wants to understand the change of the location and geographic scope of wildfire over time, because it will be more efficient to concentrate manpower to a critical moment right before a massive spread of fire. She also needs to know if it is better to concentrate the fire-fighting power in the day or night because maintaining full capacity over 24-hours is both unrealistic and detrimental to the long-term morale of firefighters. In order to effectively extinguish wildfire, it is reasonable to concentrate when the fire is more accessible (i.e., lower temperature). In short, she wants to [compare] the distribution of wildfire between dates and between day and night. She also requires [statistical data] to easily understand the difference between day and night regarding the intensity of the fire.
When Jessica logs in the app, she will easily compare how the scope of fires changes between two dates by specifying each date on the slider. She can also compare the day and night by changing day or night from the dropdown menu. If she moves on to the ‘analysis view’ by selecting it on the radio button, she will see graphs from regression analyses. Jessica may notice that “fire temperature is significantly lower during the night”, and thus make a decision that fire-fighting power should be focused on night time if an event of widespread wildfire happens in her area.

### Dashboard sketch


## Acknowledgements

We acknowledge the use of data products from the Land, Atmosphere Near real-time Capability for EOS (LANCE) system operated by NASA's Earth Science Data and Information System (ESDIS) with funding provided by NASA Headquarters.
