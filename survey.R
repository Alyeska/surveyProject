## survey project in Rc

# load library; these are already installed on personal computer, but will need to be installed if on different computer
library(ggplot2)
library(dplyr)

#download data
download.file("http://files.figshare.com/2236372/combined.csv",  "data/portal_data_joined.csv")
# import that file
surveys <- read.csv('data/portal_data_joined.csv')

### Compare the genus Reithrodontomys

## Filter out the Reithrodontomys genus from survey data and desired variables
Rei <- surveys %>%
  filter(genus == "Reithrodontomys") %>%
  select(species, year, sex, weight, hindfoot_length) %>%
  filter(!sex == "") %>% # filter out empty and "na" cells
  filter(!is.na(weight)) %>%
  filter(!is.na(hindfoot_length))


## How does the female distribution change over time for species R. megalotis?
# select only females and years
RMfem <- Rei %>%
  filter(species == "megalotis") %>%
  select(year, sex) %>%
  filter(sex == "F")
  
# create histogram
pdf("figures/RMfemaleHistogram.pdf")
qplot(year, data = RMfem, ylab = "Frequency", xlab = "Year", binwidth = 1, geom="histogram")
dev.off()


## Is there a relationship between species and weight?
# select the weight and filter out R. sp.
weight <- Rei %>%
  filter(!species == "sp.") %>%
  select(species, weight, hindfoot_length)

# create scatterplot
pdf("figures/swScatter.pdf")
ggplot(data = weight, aes(x = hindfoot_length, y = weight)) + geom_point()




#ggsave

