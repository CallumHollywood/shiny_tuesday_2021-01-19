

library(shiny)
library(shinyjs)
library(shinythemes)
library(tidyverse)
library(rAmCharts4)

source("scripts/land_page.R")
source('scripts/profile_mod.R')


###########
# UI
###########

ui <- fluidPage(
  title = "Shiny Tuesday 2021-01-19",
  theme = shinytheme("superhero"),
  useShinyjs(),
  uiOutput("main_ui")
)


