# Section 1 - Intro to Basics 

# ---BASIC ARITHMETIC--- 
# Arithmetic operators:
# + (addition)
# - (subtraction)
# * (multiplication)
# / (division)
# ^ (exponent)
# %% (modulo)

# Introductory examples:
3 + 4
6 + 12

# Arithmetic examples: 
5 + 5 # expected: 10
5 - 5 # expected: 0
3 * 5 # expected: 15
(5 + 5)/2 # expected: 5
2^5 # expected: 32
28 %% 6 # expected: 4

# ---VARIABLES---

# <- (variable assignment operator)
# var_name (prints the value of this variable, or of an expression)

# Examples: 
my_var <- 4
my_apples <- 5
my_oranges <- 6

my_apples # expected: 5
my_apples + my_oranges # expected: 11
my_fruit <- my_apples + my_oranges
my_fruit # expected: 11

# ---DATA TYPES---
# numeric: decimal values (e.g. 4.5)
# integer: whole numbers (e.g. 4)
# logical: Boolean values (TRUE, FALSE)
# character: string values ("some text")

# class(my_var): prints the class (i.e. data type) of the variable

# Examples: 
my_numeric <- 42
my_character <- "universe"
my_logical <- FALSE

class(my_numeric) # expected: numeric
class(my_character) # expected: character
class(my_logical) # expected: logical

# ---USEFUL TIPS---
# highlight line(s) of the script to run and press ctrl+enter to run just those
# to run a whole script at once, press ctrl+shift+enter
# can type commands directly in the console to run too