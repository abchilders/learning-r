# Section 3 - Matrices

# Scenario: analyzing the box office numbers of the Star Wars franchise

# ---CREATING A MATRIX---
#
# matrix = a collection of elements of the same data type (numeric, character,
#   or logical) arranged into a fixed number of rows and columns. Think 
#   two-dimensional array.
#
# matrix(data_vector, byrow = TRUE/FALSE, nrow = num_rows, 
#   dimnames = list(row_names, col_names)): 
#   Creates a matrix with the following specifications--
#   data_vector - a list of elements to be added into the matrix
#   byrow - TRUE if you want to fill the matrix row-by-row, FALSE if you want 
#     to fill it column-by-column
#   nrow - the number of rows in the matrix
#   dimnames [OPTIONAL] - row and column names 
#
# To name a matrix: 
# rownames(my_matrix) <- row_names_vector
# colnames(my_matrix) <- column_names_vector

# Examples: 
# A matrix with 3 rows containing the numbers 1-9, filled row-wise
matrix(1:9, byrow = TRUE, nrow = 3) 

# Combining vectors into a matrix: 
# Box office numbers of Star Wars movies (in millions)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Combine all box office numbers into one vector
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct matrix of box office figures from 1D vector 
original_star_wars_matrix <- matrix(box_office, byrow = TRUE, nrow = 3)

# Naming a matrix: 
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")
colnames(original_star_wars_matrix) <- region
rownames(original_star_wars_matrix) <- titles

original_star_wars_matrix # Expected: matrix w/ box office figures by movie and region

# You could also create and name a matrix at the same time: 
phantom_menace <- c(474.5, 552.5)
attack_clones <- c(310.7, 338.7)
revenge_sith <- c(380.3, 468.5)
prequel_titles <- c("The Phantom Menace", 
                    "Attack of the Clones", 
                    "Revenge of the Sith")
prequel_star_wars_matrix <- matrix(c(phantom_menace, attack_clones, revenge_sith),
                                   byrow = TRUE,
                                   nrow = 3,
                                   dimnames = list(prequel_titles, region))

# ---MERGING MATRICES---
#
# cbind(matrix1, matrix2): merges matrices and/or vectors together by column
#   (i.e. appends arguments as new columns)
# rbind(matrix1, matrix2): merges matrices and/or vectors together by row
#   (i.e. appends arguments as new rows)

# Examples: 
# Append total worldwide box office figures to box office matrix as new column
# (will explain rowSums() below)
cbind(original_star_wars_matrix, rowSums(original_star_wars_matrix)) 

# Create matrix that merges box office data from both original trilogy and 
# prequel trilogy 
all_wars_matrix <- rbind(original_star_wars_matrix, prequel_star_wars_matrix)

# ---SELECTING MATRIX ELEMENTS---
#
# my_matrix[row_indices, column_indices]: returns a matrix containing elements 
#   at the specified rows and columns. 
# You can leave either one blank to select all elements of a row/column.
#   my_matrix[1, 2]: first row, second column
#   my_matrix[1:3, 2:4]: rows 1, 2, 3 and columns 2, 3, 4
#   my_matrix[,1]: all elements of the first column 
#   my_matrix[1,]: all elements of the first row 

# Examples: 
# Get the average non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
mean(non_us_all)

# Get the average non-US revenue for the first two movies only
non_us_some <- all_wars_matrix[1:2, 2]
mean(non_us_some)

# ---CALCULATING DATA IN MATRICES---
#
# rowSums(my_matrix): expects a matrix, returns a vector containing the totals
#   for each row of the matrix 
# colSums(my_matrix): expects a matrix, returns a vector containing the totals
#   for each column of the matrix 
# +, -, /, *, etc. perform element-wise calculations on matrix elements 
#   my_matrix1 * my_matrix2: creates a matrix where each element is the product
#     of the corresponding elements in my_matrix1 and my_matrix2
#   NOTE: this is NOT standard matrix multiplication!!! Use %*% for that.

# Examples: 

# Calculate worldwide box office figures
worldwide_vector <- rowSums(all_wars_matrix)
worldwide_vector

# Total revenue for US and non-US box offices
total_revenue_vector <- colSums(all_wars_matrix)
total_revenue_vector

# Print an estimate of how many people saw each movie (or rather how many
# tickets were bought), assuming the price of each ticket was 5 dollars
TICKET_PRICE = 5 
visitors <- all_wars_matrix / 5
visitors 

# Print an estimate of how many people saw each movie (or rather how many 
# tickets were bought), using a given matrix of ticket prices for each movie
# release 
ticket_prices_matrix <- matrix(c(5.0, 5.0, 
                                 6.0, 6.0, 
                                 7.0, 7.0, 
                                 4.0, 4.0, 
                                 4.5, 4.5, 
                                 4.9, 4.9),
                               byrow = TRUE,
                               nrow = 6,
                               dimnames = list(c(titles, prequel_titles), region))
# for each element (box office figure) in the matrix showing all box offices for 
# all movies, divide that element by the ticket price for the corresponding 
# movie and region
visitors <- all_wars_matrix / ticket_prices_matrix
visitors 

# Print average number of US visitors 
us_visitors <- visitors[,1]
mean(us_visitors)

# ---USEFUL WORKSPACE COMMANDS---
#
# ls(): print contents of the workspace (e.g. variables created)
# more at https://www.datacamp.com/doc/r/workspace


