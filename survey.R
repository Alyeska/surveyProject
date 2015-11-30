### survey project in R

# load library; these are already installed on personal computer, but will need to be installed if on different computer (install after #)
#install.packages("ggplot2") # visualization package
#install.packages("gapminder") # dataset
library(ggplot2)
library(dplyr)

# download data if not on personal computer (download after #)
#download.file("http://files.figshare.com/2236372/combined.csv",  "data/portal_data_joined.csv")
# import that file
surveys <- read.csv('data/portal_data_joined.csv')


### Compare the species of genus Reithrodontomys, and how these species could be interacting and competing with each other.


## Filter out the Reithrodontomys genus from survey data and desired variables
Rei <- surveys %>%
  filter(genus == "Reithrodontomys") %>%
  select(species, year, sex, weight) %>%
  filter(!sex == "") %>% # filter out empty and "na" cells
  filter(!is.na(weight)) %>%
  filter(!species == "sp.") # filter out R. sp.


## Is there a relationship between species and weight?
# select weight
weight <- Rei %>%
  select(species, weight)

# create box-and-whiskers
pdf("figures/swBoxplot.pdf")
ggplot(data = weight, aes(x = species, y = weight)) + geom_boxplot()
dev.off()


## Is there a difference between species counts by year
# create line chart for the three species
pdf("figures/syLine.pdf")
ggplot(Rei, aes(year), color = species) + geom_freqpoly(binwidth = 1) + facet_grid(~ species)
dev.off()

# Statistical test
#ANOVA
aovWS <- aov(weight ~ species, data = Rei) # fit model
aovWS # look at fit
summary(aovWS) # summarize and show results


## How does the female distribution change over time for R. megalotis (species ID = RM)?
# select only females and years
RMfem <- Rei %>%
  filter(species == "megalotis") %>%
  select(year, sex) %>%
  filter(sex == "F")

# create histogram
pdf("figures/RMfemaleHistogram.pdf")
qplot(year, data = RMfem, ylab = "Frequency", xlab = "Year", binwidth = 1, geom="histogram")
dev.off()

