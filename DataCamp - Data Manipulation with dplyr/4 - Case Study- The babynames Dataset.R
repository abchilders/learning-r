# Section 4 - Case Study: The babynames Dataset

# install "babynames" dataset for this case study
#install.packages("babynames")

library(babynames)
library(dplyr)
library(ggplot2)

# ---NOTES---
# * x %in% my_vector: binary operator, returns logical vector-- TRUE if x found
#   in my_vector. Use to filter for multiple column names
#
# * "grouped mutate" = use group_by() and mutate() together to perform 
#    calculations within each group (year, name, etc.)
#    * ungroup() when done - best practice, prevents slowing down next operation
#
# * "window function" = expects a vector, performs some aggregation that relies
#   on all values, returns a vector of the same length 
#    * lag(my_vector): shifts each element back by 1 (index = index++)
#    * my_vect - lag(my_vect): compares consecutive steps; returns difference 
#      between my_vect[i-1] and my_vect[i] (previous and current elements)
#       * Use to see changes in value across rows


# ---CASE STUDY EXAMPLES---


# Find most common names of 1990
babynames %>%
  # Filter for year 1990
  filter(year == 1990) %>%
  # Sort number column in descending order
  arrange(desc(n))


# Find the most common name in each year
babynames %>%
  group_by(year) %>%
  # Get the single row with the highest number of babies with given name
  slice_max(n)


# Plot how many babies were named Steven, Thomas, or Matthew over time
selected_names <- babynames %>%
  # filter for specific names 
  filter(name %in% c("Steven", "Thomas", "Matthew")) %>%
  # then total counts for each name, each year, across all sexes
  group_by(year, name) %>%
  summarize(total_n = sum(n))

ggplot(selected_names, aes(x = year, y = total_n, color = name)) + 
  geom_line()


# Find the year in which each name was the most common
babynames %>%
  # For each year, calculate the fraction of people (out of total number of 
  # babies recorded that year) born with the same name
  group_by(year) %>%
  mutate(year_total = sum(n)) %>%
  ungroup() %>%
  mutate(fraction = n / year_total) %>%
  # Find the year that each name is the most common
  group_by(name) %>%
  slice_max(fraction, n=1)


# Add a column showing each name's frequency relative to other years on a scale
# of 0-1 (min-max normalization), where 1 = the maximum number of babies to whom
# the name was given in a single year-- 
# So divide the count for each name, each year, by the maximum ever count for 
# that name (so every name's frequency peaks at 1)
babynames_normalized <- babynames %>%
  # For each name: 
  # (a) For each year, total counts across all sexes 
  # (b) Calculate total number of times each name has been used (just for fun)
  # (c) Find the observation with the largest count
  group_by(name, year) %>%
  summarise(n = sum(n)) %>%
  # This "mutate" should act on a table that is now only grouped by name; 
  # the "summarise" verb "peeled off" the last group (year) 
  mutate(name_total = sum(n), name_max = max(n)) %>%
  ungroup() %>%
  # Then normalize all name counts by dividing n/max(n)
  mutate(fraction_max = n / name_max)

# Now we can see that, for example, the name "Abe" was at 17.9% of its peak
# in the year 1880 (n/max(n) == 50/280 == 0.179/1 == 17.9/100)
babynames_normalized %>%
  filter(name == "Abe", year == 1880)

# Visualize the normalized popularity of the names Steven, Thomas, and Matthew
# over time 
# 1.) Filter for specific names
names_filtered <- babynames_normalized %>%
  filter(name %in% c("Steven", "Thomas", "Matthew"))
# 2.) Visualize
ggplot(names_filtered, aes(x = year, y = fraction_max, color = name)) + 
  geom_line() 


# Analyze jumps in popularity of names from year to year
# 1.) Calculate each name's popularity within each year 
babynames_fraction <- babynames %>%
  # Get total number of babies born each year 
  group_by(year) %>%
  mutate(year_total = sum(n)) %>%
  # For each name/sex combo, calculate fraction of babies born that year of that
  # name and sex
  # ALEX QUESTION: I don't understand how this can be different than the "prop"
  # variable, meaning I don't understand what "prop" really is-- it seems to add 
  # up to a different number each year that is >1 and changes slowly over 
  #time... 
  ungroup() %>%
  group_by(name, sex) %>%
  # Using DataCamp's variable naming, but "fraction" == "popularity"
  mutate(fraction = n / year_total)

# 2.) Add a ratio column that, for each name/sex, contains the ratio of each 
# its popularity that year to its popularity the previous year
babynames_ratio <- babynames_fraction %>%
  group_by(name, sex) %>%
  mutate(ratio = fraction / lag(fraction))

# 3.) Find (relatively common) names that had large jumps in popularity in 
# consecutive years
test <- babynames_ratio %>%
  # Find largest jump in popularity from previous year for each name
  slice_max(ratio, n=1) %>%
  # Sort in descending order of popularity change
  arrange(desc(ratio)) %>%
  # Filter out names that were given to very few people (removes rows where 
  # popularity jumps wildly due to very small n)
  filter(fraction >= 0.001)

# 4.) Bonus: interpret data! e.g. notice a jump in popularity of "Grover" in 
# 1884; Grover Cleveland was elected as U.S. President in 1884
  