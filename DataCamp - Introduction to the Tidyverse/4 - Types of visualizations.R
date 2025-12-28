# Section 4 - Types of visualizations 

library(gapminder)
library(dplyr)
library(ggplot2)

# ---NOTES--- 
# * bonus ggplot layers:
#    * expand_limits(y = 0): starts y-axis at 0
#    * scale_y_log10(): display y-axis on logarithmic scale
#    * labs(x = "x-axis label", 
#           y = "y-axis label", 
#           fill = "color legend label", 
#           title = "insert title here", 
#           subtitle = "insert subtitle here", 
#           caption = "insert caption below plot", 
#           alt = "add alt text to plot"): add text/labels to graph
#    * ggtitle("insert title here")
#    * xlab("x-axis label")
#    * ylab("y-axis label")
# * cool cheat sheets:
#    * tidyverse (dplyr, ggplot2): https://media.datacamp.com/legacy/image/upload/v1676302697/Marketing/Blog/Tidyverse_Cheat_Sheet.pdf
#    * ggplot2: https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf 

# ---LINE PLOTS--- 
# * used for: showing change over time
# * axes: two numeric variables
# * ggplot(...) + geom_line(): creates line plot

# Examples:

# Create a line plot showing the change in median GDP per capita over time 
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

ggplot(by_year, aes(x = year, y = medianGdpPercap)) + 
  geom_line() +
  expand_limits(y = 0)

# Create a line plot showing the change in median GDP per capita, by continent, 
# over time
by_year <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

ggplot(by_year, aes(x = year, y = medianGdpPercap, color = continent)) + 
  geom_line() +
  expand_limits(y = 0)

# ---BAR PLOTS---
# * used for: comparing numeric values across several discrete categories
#    * displays one bar per category (read: 1 numeric value per 1 category)
# * axes: x = categorical variable, y = numeric variable
# * ggplot(...) + geom_col(): creates bar plot
#    * numeric axis always starts at 0 

# Example: Create a bar plot showing median GDP per capita by continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) + 
  geom_col()

# ---HISTOGRAMS---
# * used for: describing the distribution of a one-dimensional numeric variable
# * axes: x = a single numeric variable 
#   (then y = the count/frequency of each value thereof)
# * ggplot(...) + geom_histogram(binwidth = #, bins = #): creates histogram
#    * binwidth = # --> each bar (or "bin") in the histogram encompasses # 
#      possible values (years, population totals, etc.) of the numeric variable
#    * bins = #: limits the number of bars on the histogram
#       * fewer bins = broader view of graph's general shape 
#    * may need to add scale_x_log10() layer to make graph readable

# Example: Create a histogram showing the distribution of countries' population
# counts in 1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

ggplot(gapminder_1952, aes(x = pop)) + 
  geom_histogram(bins = 40) + 
  scale_x_log10() # comment out this line to see the difference in readability


# ---BOXPLOTS---
# * used for: comparing the distribution of a numeric variable among several 
#   categories
#    * (like a histogram but can compare among categories)
#    * (read: many numerical values per 1 category)
# * axes: x = categorical variable, y = a numeric variable
# * ggplot(...) + geom_boxplot(): creates boxplot
# * HOW TO READ A BOXPLOT: 
#    * black line in middle = median 
#    * top and bottom of box = 75th and 25th percentile (50% of the 
#      distribution, i.e. numeric values observed in the given category, are 
#      inside the box)
#    * "whiskers" (lines going up and down from box) = remaining values observed
#    * dots = outliers

# Example: create a boxplot comparing GDP per capita among continents in 1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Look for median, 75th/25th percentile, whiskers, and outliers
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) + 
  geom_boxplot() + 
  scale_y_log10() + 
  labs(title="Comparing GDP per capita in 1952 across continents")
