# Section 2 - Aggregating Data

library(dplyr)
library(ggplot2) # for midwest dataset

# ---CONCEPTS---
# * aggregating data = taking many observations [rows] and summarizing them into 
#   one

# ---AGGREGATE VERBS---
# * count([col_name], [wt = numeric_col], [sort = TRUE]): counts number of rows
#    * col_name: counts number of observations for each unique value of 
#      col_name (i.e. "group by" this column)
#    * wt = numeric_col: computes sum of values in numeric_col instead of 
#      counting up observations
#    * sort = TRUE: sorts rows from greatest to least count
#
# * group_by(col1, col2, ...): the next verb will calculate FOR EACH VALUE (or 
#   combo thereof if multiple) of given column(s)
#   * FUN ALEX NOTE: think of it as redefining what each row will mean when 
#     aggregated-- e.g. group_by(state) --> each row will represent one state, 
#     not one county
#
# * summarize(new_col_name = summary_func(col_to_aggregate))
#    * Summary functions: sum(), mean(), median(), min(), max(), n() [count]
#    * NOTE!!! removes ONLY the LAST group_by column before piping to next verb;
#      all other column groups are kept 
#
# * slice_min(col_name, n = #): returns rows with the # lowest values in 
#   col_name. use on grouped table
# * slice_max(col_name, n = #): returns rows with the # highest values in 
#   col_name. use on grouped table
#
# * ungroup(): removes all group_by groupings [before piping to next verb]
#
# * arrange([desc()]col_name): sorts on col_name from low to high 
#    * desc(col_name): sort from high to low instead

# Examples: 

# Count number of counties in each state (each row = one county); sort states 
# from most to least counties
midwest %>%
  count(state, sort=TRUE)

# Find total population of each state, sorted in descending
# order
midwest %>%
  count(state, wt = poptotal, sort=TRUE)

# What are the states that have the most people below the poverty line?
midwest %>%
  mutate(popbelowpoverty = percbelowpoverty / 100 * poptotal) %>%
  count(state, wt = popbelowpoverty, sort=TRUE)

# Find the following values: the smallest population, the maximum percent of
# college-educated population, and the mean population density. 
# Then find the counties that had the smallest population and the largest 
# percent of college-educated people. 
summary_example <- midwest %>%
  summarise(min_population = min(poptotal),
            max_college_educated = max(percollege),
            avg_density = mean(popdensity))
# County with smallest population
midwest %>%
  filter(poptotal == summary_example[1, "min_population"] %>%
           pull) # "pull" - googled how to get a value out of a cell from tibble: 
                 # https://stackoverflow.com/questions/70533197/extract-a-single-value-from-a-dataframe-tibble-the-tidy-dplyr-way
# County with largest percent of college-educated people
midwest %>%
  filter(percollege == summary_example[1, "max_college_educated"] %>%
           pull)

# Total number of college-educated people in metro and non-metro areas of each 
# state
midwest %>%
  mutate(popcollege = percollege / 100 * poptotal) %>%
  group_by(state, inmetro) %>%
  summarize(state_metro_popcollege = sum(popcollege)) %>%
  # Then calculate the total population in each state of college-educated people
  summarize(state_popcollege = sum(state_metro_popcollege))

# Find the county in each state with the highest percentage of Asian population
midwest %>%
  group_by(state) %>%
  slice_max(percasian, n=1)

# Find the state with the lowest average percent of people below poverty line
midwest %>%
  group_by(state) %>%
  # Calculate average percentage below poverty for each state
  summarize(avg_percbelowpoverty = mean(percbelowpoverty)) %>%
  # Find state with lowest percentage of people below poverty line 
  slice_min(avg_percbelowpoverty, n=1)

# Compare number of states with more people in metro counties vs. more people in
# non-metro counties 
midwest %>%
  # Group by state, metro
  group_by(state, inmetro) %>%
  # For each state/metro combo, tally up the total number of people who live
  # there 
  summarize(population = sum(poptotal)) %>%
  # Each state should now have two rows (one metro and one non-metro); extract 
  # the row with the higher population 
  slice_max(population, n=1) %>%
  # Each state should now have one row left representing the higher of its total
  # metro/non-metro population; tally up how many are labeled as in metro vs.
  # not in metro 
  ungroup() %>%
  count(inmetro) 
  # Expected: all states have more people in metro than non-metro counties
  