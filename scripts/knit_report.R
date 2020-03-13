# author: Monica Li
# date: 2020-03-05

"This script knit the draft of our final report to an HTML file and a PDF file 

Usage: knit_report.R --rmd_path=<rmd_path>
" ->  doc

library(docopt)
library(rmarkdown)

opt <- docopt(doc)

main <- function(rmd_path) {
  message(paste0("Knit the report from: ", rmd_path))
  knit_report(rmd_path)
  message(paste0("Successful! Report in html and pdf has been generated and saved in the root of repo!"))
}


#' knit the draft to HTML and PDF files
#' 
#' @param rmd_path is a string. The path to the rmd file to be wrapped
#' @examples
#' knit_report ("docs/milestone2.Rmd")
knit_report <- function(rmd_path) {
  render (
    input=rmd_path, 
    output_format=c("html_document", "pdf_document"),
    output_file = c("finalReport","finalReport"),
    output_dir = "."
  )
}

main(opt$rmd_path) 