# Section 1 - Joining Tables

# ABOUT EXAMPLE TABLES: 
# (view schema at https://rebrickable.com/downloads/ )
# sets - LEGO sets (sold in stores)
# themes - product lines grouped around a theme (brand, concept, etc.)
# parts - pieces in a lego set (gears, bricks, etc.)

# Load necessary packages
library(readr)
library(dplyr)
library(stringr)

# Load datasets
parts <- read_csv("parts.csv")
part_categories <- read_csv("part_categories.csv")

# ---INNER JOIN---
# * table_x %>% 
#     inner_join(table_y, 
#              by = c("col_from_x" = "col_from_y"), 
#              suffix = c("_x", "_y")): 
#   joins two tables together on a column from each table that overlaps
#    * suffix(): optional. when each table brings a column with the same name, 
#      differentiates them by adding  _x to the column name from table_x and 
#      _y to the column from table_y

# Examples: 

# Look at the parts and part_categories datasets-- notice that they share data
# in part_cat_id and id (id is actually part_categories' "primary key",
# part_cat_id is a "foreign key" in parts referencing part_categories)
head(parts)
head(part_categories)

# Join parts and part_categories on that column 



Great! This is the same join as the last exercise, but the order of the tables is reversed. For an inner_join, either direction will yield a table that contains the same information! Note that the columns will appear in a different order depending on which table comes first. 

suffix()-- does prefix() also exist?
  
  