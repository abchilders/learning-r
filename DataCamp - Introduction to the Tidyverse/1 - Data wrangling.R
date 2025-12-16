# Section 1 - Data wrangling

# ---CONCEPTS--- 
# * "the tidyverse" = a collection of data science tools in R for transforming
#   and visualizing data
#    * cheat sheet courtesy of DataCamp: 
#      https://www.datacamp.com/cheat-sheet/tidyverse-cheat-sheet-for-beginners

# ---LOADING PACKAGES---
# * packages = tools that aren't hard-built into R, but created by other 
#   programmers
# * library(packageName) = loads package into R

# Examples: 

# NOTE: had to manually install gapminder myself before using
# install.packages("gapminder")
# install.packages("dplyr")

# Load gapminder package - its dataset tracks economic and social indicators 
# (GDP, life expectancy, etc.) of countries over time
library(gapminder)

# Load dplyr package - provides tools for transforming data (filter, sort, etc.)
library(dplyr)

# View the gapminder data frame
gapminder

# ---MANIPULATING DATA WITH DPLYR---
# * "verbs" = steps/functions used to transform data (filter, arrange, etc.)
#    * each returns a new dataset, doesn't alter the original
# * %>%: pipe operator - feeds data into verbs that do something to it
# * filter(condition1, condition2, ...): filters observations into subset
# * arrange(variable_name): sorts dataset in ascending order on given column
#    * arrange(desc(variable_name)): sorts in descending order
# * mutate(column_name = ...): creates or modifies a column in dataset
# * Usage all together: 
#   my_dataset %>%
#      verb1(...) %>%
#      verb2(...)

# Examples:

# Filter the gapminder dataset to show only observations from the year 1957
gapminder %>%
  filter(year == 1957)

# Filter to see observation for China in the year 2002
gapminder %>%
  filter(year == 2002, country == "China")

# Sort gapminder dataset by life expectancy (ascending)
gapminder %>%
  arrange(lifeExp)

# See observations from the year 1957, sorted in descending order of population
gapminder %>%
  filter(year == 1957) %>%
  arrange(desc(pop))

# Change life expectancy column to display data in months, not years
gapminder %>%
  mutate(lifeExp = 12 * lifeExp)

# Get observations from the year 2007, with a new column showing life expectancy
# in months, and all sorted in descending order by life expectancy in months 
gapminder %>%
  filter(year == 2007) %>%
  mutate(lifeExpMonths = 12 * lifeExp) %>%
  arrange(desc(lifeExpMonths))
  