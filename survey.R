## survey project in R

# load library; these are already installed on personal computer, but will need to be installed if on different computer
library(ggplot2)
library(dplyr)

#download data
download.file("http://files.figshare.com/2236372/combined.csv",  "data/portal_data_joined.csv")
# import that file
surveys <- read.csv('data/portal_data_joined.csv')

## determine the research question, what variables to look at, how to analyze and visualize the data (figures)
