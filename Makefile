#Author: Xuemeng Li and Stanley Nam
#Date: March 13, 2020

.PHONY: all clean

all: finalReport.html finalReport.pdf

# download data
data/fire_archive_M6_96619.csv : scripts/load_data.r
	Rscript scripts/load_data.r --data_url="https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv"

# clean data
data/cleaned_data.csv : data/fire_archive_M6_96619.csv scripts/clean_data.r
	Rscript scripts/clean_data.r --path_raw="data/fire_archive_M6_96619.csv" --path_result="data/cleaned_data.csv"

# eda
images/correllgram.png images/geogram.png : data/cleaned_data.csv scripts/plot_grams.R
	Rscript scripts/plot_grams.R --data_path="data/cleaned_data.csv"

# logistic regression 


# knit report
finalReport.html finalReport.pdf : images/correllgram.png images/geogram.png docs/finalReport.Rmd scripts/knit_report.R
	Rscript scripts/knit_report.R --rmd_path="docs/finalReport.Rmd"
	
clean:
	rm -f data/*
	rm -f images/*
	rm -f docs/*.md
	rm -f *.html
