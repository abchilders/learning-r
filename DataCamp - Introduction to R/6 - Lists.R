# Section 6 - Lists

# ---CREATING A LIST---
# * list = ordered array that can contain objects of many different types
# (matrices, vectors, data frames, lists, etc.)
# * list(component1, component2, ...): creates a list
# * list(name1 = component1, name2 = component2, ...): creates a list with 
#   named components 
#    * names(my_list) <- c(name1, name2, ...) will also name elements

# Examples: 

# Vector with numerics from 1-10
my_vector <- 1:10 
# Matrix with numerics from 1-9
my_matrix <- matrix(1:9, ncol = 3)
# Data frame with the first 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]
# Create a list with these three objects as elements
my_list <- list(vec = my_vector, 
                mat = my_matrix, 
                df = my_df)
my_list

# Creating a list to represent the movie "The Shining"
# Set up the elements to add
mov <- "The Shining"
act <- c("Jack Nicholson", "Shelley Duvall", "Danny Lloyd", "Scatman Crothers", 
         "Barry Nelson")
scores <- c(4.5, 4.0, 5.0)
sources <- c("IMDb1", "IMDb2", "IMDb3")
comments <- c("Best Horror Film I Have Ever Seen", 
                  "A truly brilliant and scary film from Stanley Kubrick", 
                  "A masterpiece of psychological horror")
rev <- data.frame(scores, sources, comments)
avg_rev <- mean(scores)
# Then create the list
shining_list <- list(title = mov, actors = act, reviews = rev, 
                     avg_review = avg_rev)

# ---SELECTING ELEMENTS---
# * my_list[[index/"name"]]: selects [[index]]th element or element named 
#   "name"
# * my_list$name: selects element named "name" from list

# Examples: 

# Print vector representing actors in "The Shining"
shining_list$actors 
shining_list[["actors"]] # equivalent 

# Print the second element of the vector representing the movie's actors
shining_list[["actors"]][[2]]
