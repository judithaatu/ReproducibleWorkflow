
# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("here", "dplyr", "gt", "ggplot2") 
)

# Other files that are needed
tar_source("functions.R")

# data file
list(
  tar_target(
    name = penguins_data,
    command = datasets::penguins),
  
  # data processing
  tar_target(
    name = penguins_prepped,
    command = penguin_prep(data = penguins_data)),

  # analysis
  tar_target(
    name = model,
    command = fit_model(data = penguins_prepped,
                        response = "flipper_len",
                        predictor = "species")),

  # figure
  tar_target(
    name = my_favorite_figure,
    command = make_figure(data = penguins_prepped)),

  # quarto document
  tar_quarto(
    name = Manuscript,
    path = "Manuscript.qmd")
  )

