# Section 2 - Data visualization
# (creating scatterplots with ggplot2)

# ---CONCEPTUAL STUFF---
# * if working with subset, consider assigning it to its own variable: <- 
# * scatterplot = graph that shows relationship between two variables by putting
#   one on x axis and one on y axis; each observation is plotted as a point
#    * aesthetic = a visual dimension of a graph that can be used to communicate
#      information
# * when points are spread somewhat randomly across a graph-- "Notice the points 
#   are more spread out on the x-axis. This makes it easy to see that there isn't 
#   a correlation between population and life expectancy."
# * faceting = dividing a larger plot into smaller sub-plots to see graphs for
#   individual value of a variable

# ---CREATING A SCATTERPLOT(S)---
# 1.) library(ggplot2): loads package 
# 2.) ggplot(my_data_frame, aes(x = x_variable, y = y_variable, 
#            color = some_categorical_variable, size = some_numeric_variable)) + 
#        geom_point() + 
#        scale_x_log10() + 
#        scale_y_log10() + 
#        facet_wrap(~ variable_to_divide_on)
#    * color and size: optional, but are ways to show relationships w/ even more
#      variables at once
#    * +: adds a layer to the graph
#    * geom_point(): "geom" = adding some geometric object to the graph,
#      "point" = it's a scatter plot (one point = one observation)
#    * scale_x_log10(): OPTIONAL, displays x-axis on logarithmic scale. Good if
#      variable is spread over several orders of magnitude
#    * scale_y_log10(): OPTIONAL, displays y-axis on logarithmic scale. "
#    * facet_wrap(~ variable_to_divide_on): OPTIONAL, divides scatterplot into 
#      subplots, categorizing by given variable 
#       * "~" means "by"

# Examples: 

# Install packages if not already installed:
# install.packages("gapminder")
# install.packages("dplyr")
# install.packages("ggplot2")

# Load all needed packages
library(gapminder) # the dataset
library(dplyr) # for filtering the data 
library(ggplot2) # for visualizing the data

# Create subset of data to visualize 
gapminder_1952 <- gapminder %>%
                    filter(year == 1952)

# Display scatter plot showing relationship between population and GDP per 
# capita
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) + 
  geom_point()

# Display scatter plot showing relationship between population and life 
# expectancy
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point()

# Scatter plot showing relationship between population and life expectancy, but 
# put x-axis on logarithmic scale (possible x values occur over several orders 
# of magnitude, otherwise most are crowded to one side of scale)
# Points spread out --> no correlation between x and y
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

# Scatter plot comparing population and GDP per capita, with both axes on a 
# logarithmic scale 
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) + 
  geom_point() + 
  scale_x_log10() + 
  scale_y_log10()

# Scatter plot comparing population, life expectancy, continent, and GDP per 
# capita
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, 
                           size = gdpPercap)) +
  geom_point() + 
  scale_x_log10()

# Create subgraph for each continent, all comparing population and life 
# expectancy
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ continent)

# Create subgraphs of entire gapminder dataset, divided by year, showing 
# GDP per capita, life expectancy, continent, and population
# (shows how global statistics changed over time)
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, 
                      size = pop)) +
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ year)