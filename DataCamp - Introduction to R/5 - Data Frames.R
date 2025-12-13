# Section 5 - Data Frames 

# ---CREATING DATA FRAMES---
#
# * data frame = a dataset, stored as a 2D array/table, where each column is a 
#   variable and each row is an observation (instance/entity/etc.)
#    * like a matrix BUT each column can contain different data types
# * data.frame(vector1, vector2, ...): creates a data frame from vectors
#    * expects ordered vectors of identical lengths where each vector represents 
#      one variable, and the elements are ordered observations

# Example: 

# Vectors representing each variable of the data to enter
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", 
          "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", 
          "Gas giant")
# Diameter relative to the Earth's diameter
diameter <- c(0.382, 0.949, 1, 0.532, 
              11.209, 9.449, 4.007, 3.883)
# Rotation across the sun relative to that of the Earth
rotation <- c(58.64, -243.02, 1, 1.03, 
              0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from these vectors 
planets_df <- data.frame(name, type, diameter, rotation, rings)

# ---GETTING ACQUAINTED WITH A NEW DATA FRAME--- 
# (you might get one to analyze from statistical software, for example)
#
# * head(my_data_frame): shows the first few observations
# * tail(my_data_frame): shows the last few observations
# * str(my_data_frame): shows the structure of the data frame: total number of 
#   observations (rows), total number of variables (columns), list of variable 
#   names, data type of each variable, first few observations

# Examples: 
head(planets_df) # should see first few rows
tail(planets_df) # should see last few rows
str(planets_df) # should see summary of data set structure and contents

# ---SELECTING FROM DATA FRAMES---
#
# * my_data_frame[row(s), col(s)]: selects elements from data frame
#    * leaving row/col blank = select all rows/cols
# * my_data_frame[row(s), "variable_name"]: selects values from given rows in 
#   the variable_name column 
# * my_data_frame$variable_name: select entire variable_name column
# subset(my_df, some_logical_condition): select only the parts of the dataset 
# for which some_logical_condition is true

# Examples: 

# Print data for Mars, which is in the fourth row
planets_df[4, ]

# Print all values in the "diameter" column of planets_df
planets_df[ , "diameter"]
planets_df$diameter # should be identical to above 

# Print all columns for planets that have rings
# (All three ways should have the same output)
# planets_df$rings returns a logical vector, this is used to select rows
planets_df[planets_df$rings, ] 
subset(planets_df, rings)
subset(planets_df, rings == TRUE) # easiest to read


# ---SORTING DATA FRAMES---

# * order(my_vector): sorts elements from lowest to highest and returns original 
#   indices in that order 
# * you can then sort data frames on a specific column by using the results of 
#   order() as the row indices: 
#   my_data_frame[order(my_data_frame$variable_name), ]

# Examples: 

# Get the indices of planets sorted by least to greatest diameter
positions <- order(planets_df$diameter)
# Then print planets in order from least to greatest diameter
planets_df[positions, ]
# Could even just print the names in order from smallest to largest
planets_df[positions, "name"]
