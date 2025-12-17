# Section 3 - Grouping and Summarizing 

library(gapminder)
library(dplyr)

# ---FUN NOTES---
# * If you see a warning when loading a package that says...
# "The following objects are masked from 'package:stats'"
# ...it means that those built-in R functions were overwritten by the package

# ---THE "SUMMARIZE" VERB---
# * summarize(new_col1 = aggregate_func(variable1), 
#             new_col2 = aggregate_func(variable2), 
#             ...))
#   performs an aggregate calculation on the piped-in dataset, returns a single 
#   row with the result
# * Aggregate functions: 
#    * mean(variable_name)
#    * median(variable_name)
#    * min(variable_name)
#    * max(variable_name)
#    * sum(variable_name)

# Examples: 

# Find the median life expectancy across all gapminder observations
gapminder %>%
  summarize(medianLifeExp = median(lifeExp))

# Find the median life expectancy and maximum GDP per capita in the year 1957
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))

# ---THE "GROUP_BY" VERB---
# * group_by(variable1, variable2, ...): groups together dataset rows by [unique
#   combinations of] given variable(s); tells the next verb to act on each group 
#   individually (instead of the whole dataset) 
#    * group_by(var1, var2, ...) %>% summarize(...): returns one row per group
#      containing aggregate value

# Examples: 

# For each year, find median life expectancy and maximum GDP per capita
gapminder %>% 
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita of each continent in 
# the year 1957
gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# For each continent and each year, find median life expectancy and maximum GDP
# per capita
gapminder %>%
  group_by(continent, year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# ---VISUALIZING SUMMARIZED DATA---
# * ggplot(...) +  
#     expand_limits(y = 0): starts y axis at 0
# * dataframe_to_plot <- my_dataset %>% filter()...etc etc: puts result of
#   operations/aggregations on dataset into new variable to be plotted

# Examples: 

# Create a scatter plot showing change in worldwide median life expectancy over 
# time; start y-axis at 0 for clarity
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp))

ggplot(by_year, aes(x = year, y = medianLifeExp)) + 
  geom_point() + 
  expand_limits(y = 0)

# Create scatter plot showing change in median GDP per capita of each continent
# over time 
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, 
                              color = continent)) +
  geom_point() + 
  expand_limits(y = 0)

# Create scatter plot comparing median GDP and median life expectancy of each 
# continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), 
            medianGdpPercap = median(gdpPercap))

ggplot(by_continent_2007, aes(x = medianLifeExp, y = medianGdpPercap, 
                              color = continent)) + 
  geom_point()

