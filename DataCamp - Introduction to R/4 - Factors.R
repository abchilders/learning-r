# Section 4 - Factors 

# ---USEFUL NOTES---
# * ?factor: enter into the console to open help page about the factor() function

# ---CREATING FACTORS---
# * factor = a statistical data type that stores categorical variables 
# * categorical variable = has a discrete, *finite set* of possible values 
#   (data falls into a limited number of categories)
#     * nominal categorical variable = categories are NOT ordered
#     * ordinal categorical variable = categories are ordered [can be compared]
# * continuous variable = has an infinite set of possible values
# * factor levels = the categories to which a factor's element values can be set

# * factor(my_vector): converts a vector into a factor
#   * orders levels alphabetically by default
# * factor(my_vector, ordered = TRUE, levels = c("lvl1", "lvl2", ...)): 
#   converts a vector into an ORDINAL factor with the levels given low to high
# * levels(my_factor) <- c("name1", "name2", ...): changes the names of a 
#   factor's levels
#   * check the order of the levels first before renaming in the same order: 
#     labels(my_factor)
#   * identifying levels of a factor enables R to show the number of elements 
#     belonging to each level/category in it

# Examples: 
flavor_vector <- c("choc", "vanl", "choc", "choc", "strb")
factor_flavor_vector <- factor(flavor_vector)
factor_flavor_vector
# Altering level names for clarity after collecting data
levels(factor_flavor_vector) <- c("Chocolate", "Strawberry", "Vanilla")
factor_flavor_vector

nominal_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
factor_nominal_vector <- factor(nominal_vector)
factor_nominal_vector # Notice how order of levels doesn't matter

ordinal_vector <- c("High", "Low", "High", "Low", "Medium")
factor_ordinal_vector <- factor(ordinal_vector, 
                                order = TRUE,
                                levels = c("Low", "Medium", "High"))
factor_ordinal_vector # Notice how levels are shown in order lowest to highest

# ---USING FACTORS---

# summary(my_var): displays summary of variable contents 

# Comparison: By default, R returns NA when you try to compare values in a 
# factor. But meaningful comparisons ARE possible with *ordered* factors (as 
# opposed to nominal factors)

# Examples:
summary(flavor_vector)
summary(factor_flavor_vector)

# This factor is nominal, elements cannot be compared
factor_flavor_vector[1] > factor_flavor_vector[2] # Expected: NA

# Performance evaluations of five people
# This factor is ordinal, so you can compare its elements
speed_vector <- c("medium", "slow", "slow", "medium", "fast")
# Convert speed_vector to ordered factor vector
factor_speed_vector <- factor(speed_vector, 
                              ordered = TRUE, 
                              levels = c("slow", "medium", "fast"))
# Is person 2 faster than person 5? 
person2 <- factor_speed_vector[2]
person5 <- factor_speed_vector[5]
person2 > person5 # Expected: FALSE