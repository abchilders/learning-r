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
# mean(my_vector): expects a vector, returns the average of the vector's values
# A > B: "greater than" comparison operator - returns logical value

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

# Average daily profit overall
mean(total_daily)

# Check if you realized higher gains in poker than roulette
total_poker > total_roulette

# ---SELECTING (ACCESSING) VECTOR ELEMENTS---
# my_vector[#]: access by index number (***1-BASED, NOT 0)
# my_vector[vector_of_indices]: returns vector containing elements at specified 
#   indices
#   * my_vector[c(#, #, ...)]
#   * my_vector[c(#:#)]
# my_vector[name]: access by element name
# 
# num_a:num:b : expects two natural numbers, returns a vector of all natural 
#   numbers between num:a and num:b
#
# You can use comparison operators on a vector - expects a vector. For each
#   element in the vector, applies the comparison criteria and returns a logical
#   value; returns a vector containing those logical values.
# < less than 
# > greater than 
# <= less than or equal to 
# >= greater than or equal to 
# == equal to 
# != not equal to
#
# my_vector[some_vector >/</==/etc some_value]: returns a vector containing only
#   the elements where the logical expression is true for each element in
#   some_vector
#   * HINT: the logical expression can itself be a vector, e.g. 
#   my_vector[selection_vector]

# Examples: 
poker_wednesday <- poker_vector[3] # 3rd element of poker 

# Identical ways to select poker winnings for Tues-Thurs only
poker_midweek <- poker_vector[c(2, 3, 4)] 
poker_midweek <- poker_vector[c(2:4)]
poker_midweek <- poker_vector[c("Tuesday, Wednesday, Thursday")]

# Create a vector showing on which days we won money in poker-- should show TRUE 
# for each day that earnings were net positive
selection_vector <- poker_vector > 0 
selection_vector # Expected: TRUE FALSE TRUE FALSE TRUE, i.e. won money on M,W,F

# Create a vector that only contains data for the days on which we won money in 
# poker
poker_winning_days <- poker_vector[selection_vector]
poker_winning_days
poker_winning_days <- poker_vector[poker_vector > 0] # identical to above
poker_winning_days
