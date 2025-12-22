# Section 3 - Selecting and Transforming Data

library(dplyr)
library(ggplot2) # for "midwest" dataset

# ---SYNTAX---
# * Select helpers (to select columns by criteria): 
#    * contains("chars")
#    * starts_with("chars")
#    * ends_with("chars")
#    * last_col(): selects last column in the table
#    * matches("regex")
#    ...etc.
# * ?select_helpers: see help page for more info ^
#
# * select(col1, col3:col6, col7_alias = col7...): returns the selected columns
#    * col3:col6 : select all columns between col3 and col6
#    * -col_to_remove: remove specified column from results
#    * col7_alias = col7: changes col7's column name before displaying 
#
# * rename(new_col_alias = col_name): changes column name before displaying
#
# * relocate(col_to_move, {.before|.after} = ref_col):
#   moves a column to different display order 
#    * .before = ref_col: insert column right before ref_col
#    * .after = ref_col: insert column right after ref_col

# Examples: 

?select_helpers 

# Select state, county, and population counts 
midwest %>%
  select(state, county, poptotal, popwhite:popother)

# Select all columns except unique county identifier and category
midwest %>%
  select(-PID, -category)

# Select state, county, and all columns that start with "pop" for population
# counts
midwest %>%
  select(state, county, starts_with("pop"))

# Select state, county, and total area of county (pretend we assume units in the 
# "area" column refer to land area and that we know what the units are...)
midwest %>%
  select(state, county, total_land_area = area)

# Display the number of counties in each state, renaming "n" column for clarity
midwest %>%
  # Count the number of counties in each state
  count(state) %>%
  # Rename the "n" column to "num_counties" for clarity
  rename(num_counties = n)

# Change column order around
midwest %>%
  # Move PID column to the end
  relocate(PID, .after = last_col()) %>%
  # Move inmetro column before poptotal column
  relocate(inmetro, .before = poptotal)

# ---SUMMARY OF USAGE---
# When to use selection/transformation verbs: 
# * select(): to keep only specific columns
# * relocate(): to move columns/change column order
# * mutate(): to perform calculations on columns, putting results in existing
#   or new column
# * rename(): to change column names

# A table showing what each verb can do 
verb <- c("select()", "relocate()", "mutate()", "rename()")
keeps_all_columns_by_default <- c(FALSE, TRUE, TRUE, TRUE)
subsets_columns <- c(TRUE, FALSE, TRUE, FALSE)
reorders_columns <- c(TRUE, TRUE, FALSE, FALSE)
renames_columns <- c(TRUE, FALSE, FALSE, TRUE)
calculates_on_columns <- c(FALSE, FALSE, TRUE, FALSE)
creates_new_columns <- c(FALSE, FALSE, TRUE, FALSE)

verb_actions <- data.frame(verb, keeps_all_columns_by_default, subsets_columns, 
                           reorders_columns, renames_columns, 
                           calculates_on_columns, creates_new_columns)

verb_actions