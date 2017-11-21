setwd("~/Documents/NikolayLab/SingleCellRNASeq/Classification/TensorFlow/")

library(shiny)
library(shinydashboard)
library(tensorflow)
source("source/model_prediction.R")


shinyAppDir("shiny_GERAS_Tf/",options = "launch.browser")

