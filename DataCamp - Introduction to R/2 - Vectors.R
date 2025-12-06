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

# Examples: Assigning the days of the week as names to your gambling winnings
#   so that you know on which days you earned what
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# ---CALCULATIONS WITH VECTORS--- 
# A_vector + B_vector: returns a vector containing element-wise sums (A[1]+B[1], 
#   A[2]+B[2], etc.)
# sum(my_vector): expects a vector, returns the sum of all elements of the
#   vector 
# A > B: compares A and B; returns TRUE if A > B and FALSE if not

# Examples:
A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)
total_vector <- A_vector + B_vector 
total_vector # Expected: 5 7 9 

# Calculate daily profit from gambling
total_daily <- poker_vector + roulette_vector
total_daily # Expected: 116 -100 120 -470 250

# Total winnings for the week from poker, roulette, and overall
total_poker <- sum(poker_vector)
total_roulette <- sum(roulette_vector)
total_week <- total_poker + total_roulette
total_week # Expected: -84

# Check if you realized higher gains in poker than roulette
total_poker > total_roulette

