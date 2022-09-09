# Summary of code needed for knn prediction in R
# using 'sample' instead of 'test_training_split' to create training and test set
# removed requirement for random order of rows of training and test sets

# set seed and load packages
source('prereq.R')

iris.nrow <- nrow(iris)
# sort data into training and test
# training size 75% of data
cat("Sorting data into training and test sets\n")
row_indicies <- sample(1:2, replace = TRUE, 
                       size = iris.nrow, prob = c(0.75, 0.25))
iris_training <- iris[row_indicies == 1, ]
iris_test <- iris[row_indicies == 2, ]

# run knn
cat("Using k-nearest neighbours to predict classification of test set\n")

knn.iris <- knn(train = iris_training[, 1:4], test = iris_test[, 1:4],
                cl = iris_training$Species, k = 1)

cat("\nTest set predictions:\n")
print(knn.iris)

cat("\nTrue test set classifications:\n")
print(iris_test$Species)

cat(sprintf("\nTest set score: %.2f \n", mean(knn.iris == iris_test$Species)))
