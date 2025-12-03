# Section 2 - Vectors

# Scenario: You have played poker and roulette each weekday in the last week.
# You want to keep track of how much you have won/lost each day and analyze
# the results. 

# ---CREATING A VECTOR---
# vector = a 1D array; can store numeric, character, or logical data
#   ...or all of the above at the same time 
# my_vector <- c(value, value, value) <-- creates a vector
  # c(): the "combine function." expects a list of elements, returns a vector

# Examples:
numeric_vector <- c(1, 10, 49)
character_vector <- c("a", "b", "c")
boolean_vector <- c(TRUE, FALSE, TRUE)

# Your poker winnings from Monday to Friday
poker_vector <- c(140, -50, 20, -120, 240)

# Your roulette winnings from Monday to Friday
roulette_vector <- c(-24, -50, 100, -350, 10)


# ---NAMING A VECTOR---
# A "name" can be given to each element's position in a vector. Then, each 
# element can accessed by either its numeric position in the vector or by its 
# name.
#   ***(think of it as a column heading)

# names(my_vector) <- vector_of_names: sets the names of my_vector to the list
#   of names given in vector_of_names 
  # names(my_vector): expects a vector, returns the names of the vector
