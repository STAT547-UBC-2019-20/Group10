#Author: Xuemeng Li and Stanley Nam
#Date: March 13, 2020

.PHONY: all clean tests

all: docs/finalReport.html docs/finalReport.pdf

# download data
data/fire_archive_M6_96619.csv : scripts/load_data.R
	Rscript scripts/load_data.R --data_url="https://github.com/STAT547-UBC-2019-20/data_sets/raw/master/fire_archive_M6_96619.csv"

# clean data
data/cleaned_data.csv : data/fire_archive_M6_96619.csv scripts/clean_data.R
	Rscript scripts/clean_data.R --path_raw="data/fire_archive_M6_96619.csv" --path_result="data/cleaned_data.csv"

# eda
images/correllgram.png images/geogram.png : data/cleaned_data.csv scripts/plot_grams.R
	Rscript scripts/plot_grams.R --data_path="data/cleaned_data.csv"

# logistic regression 
images/effectSize.png images/scan-daynight.png images/track-daynight.png data/models.rda : data/fire_archive_M6_96619.csv
	Rscript scripts/analysis.R --data_path="data/fire_archive_M6_96619.csv"
	
# testthat
tests : tests/tests.R
	Rscript tests/tests.R
	
# knit report
docs/finalReport.html docs/finalReport.pdf : images/correllgram.png images/geogram.png images/effectSize.png images/scan-daynight.png images/track-daynight.png data/models.rda docs/finalReport.Rmd scripts/knit_report.R
	Rscript scripts/knit_report.R --rmd_path="docs/finalReport.Rmd"
	
clean:
	rm -f data/*
	rm -f images/*
	rm -f docs/*.md
	rm -f *.html
