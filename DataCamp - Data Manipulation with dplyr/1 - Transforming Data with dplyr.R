# Section 1 - Exploring data with dplyr

# ---SETUP---
# * dplyr = package for data manipulation in the tidyverse collection
#    * install.packages("dplyr"): installs dplyr only
#    * install.packages("tidyverse"): installs entire tidyverse, including dplyr
# * glimpse(my_dataset): shows each variable, its data type, and its first few 
#   values 
# * ?my_dataset: shows help page for dataset with descriptions of columns
# * data(): shows all of R's built-in datasets

library(dplyr)
library(ggplot2) # for midwest dataset

# Will be using the "midwest" dataset from ggplot2 package, containing midwest 
# US population info
glimpse(midwest)

# See help page with column descriptions for "midwest" dataset 
?midwest

# ---SELECTING COLUMNS: SELECT() VERB---
# * select(column1, column2, ...): returns only the specified columns/variables 
#   from dataset

# Example:
midwest_reduced_columns <- midwest %>%
  select(state, county, poptotal, percbelowpoverty, perchsd)

midwest_reduced_columns

# ---ARRANGING ROWS: ARRANGE() VERB---
# * arrange(column1, ...): sorts observations based on specified variable(s)
# * arrange(desc(column1, ...)): sorts observations in descending order

# Example: sort observations by percentage of population who graduated high 
# school in descending order 
midwest_reduced_columns %>%
  arrange(desc(perchsd))

# ---FILTERING ROWS: FILTER() VERB---
# * filter(condition1, ...): extracts observations that meet specified 
#   condition(s)

# Examples: 

# Print counties in Illinois that have a population above 100,000
midwest_reduced_columns %>%
  filter(state == "IL", poptotal > 100000)

# Print counties in Wisconsin whose percentage of population with a high school
# diploma is greater than 80%, sorted in descending order thereof
midwest_reduced_columns %>%
  filter(state == "WI", perchsd > 80) %>%
  arrange(desc(perchsd))

# ---KEEPING/ADDING COLUMNS: MUTATE() VERB---
# * mutate(new_col = col1 */+- some_value): adds/modifies column in dataset
# * mutate(col1, col2, ..., new_col = some_calculation, .keep = ...): selects 
#   existing column(s) and adds new column(s) at same time
#    * .keep = "none": any column not included in mutate() is discarded

# Examples: 

# Add a new column to our reduced dataset with the estimated number of people
# who have a high school diploma 
midwest_reduced_columns %>%
  mutate(pophsd = perchsd / 100 * poptotal)

# From the original "midwest" dataset: 
# - use mutate() verb to: keep only state, county, total population, number of 
#   adults; add column showing percentage of adults from total population
# - filter for counties with total population of at least 10,000
# - arrange counties in descending order of percentage of adults

midwest %>%
  mutate(state, county, poptotal, popadults, 
         percadults = popadults / poptotal, .keep = "none") %>%
  filter(poptotal >= 10000) %>%
  arrange(desc(percadults))