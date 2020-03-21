# Author: Xuemeng Li
# Date: March 14, 2020

library(testthat)
context("Test the output files through make pipeline")

testthat::test_that("All required files through the pipeline are generated",{
  expect_equal(file.exists(here::here("images", "correllgram.png")), TRUE)
  expect_equal(file.exists(here::here("images", "effectSizes.png")), TRUE)
  expect_equal(file.exists(here::here("images", "geogram.png")), TRUE)
  expect_equal(file.exists(here::here("images", "scan-daynight.png")), TRUE)
  expect_equal(file.exists(here::here("images", "track-daynight.png")), TRUE)
  expect_equal(file.exists(here::here("data", "cleaned_data.csv")), TRUE)
  expect_equal(file.exists(here::here("data", "fire_archive_M6_96619.csv")), TRUE)
  expect_equal(file.exists(here::here("data", "models.rda")), TRUE)
}
)