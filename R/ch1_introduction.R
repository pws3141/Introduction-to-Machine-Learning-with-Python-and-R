# Machine Learning with Python
# Ch1: Introduction

source("prereq.R")

# creating a matrix
x <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)
print_text("x = ", x)    

# moving from sparse matrix to CSR representation

# load MatrixExtra: package allowing for sparse matrices
# https://cran.r-project.org/web/packages/MatrixExtra/MatrixExtra.pdf
# library(MatrixExtra)

eye <- diag(4)
print_text("diagonal matrix:", eye)

eye.r <- as.csr.matrix(eye)
options("MatrixExtra.quick_show" = FALSE)
print(eye.r)

# create sparse matrix, COO format
values <- rep(1, times = 4)
row_ix <- col_ix <- 1:4
eye.coo <- sparseMatrix(i = row_ix, j = col_ix, x = values,
                        repr = "T")
print(eye.coo)

# the sparse matrices eye.r and eye.coo should be the same
stopifnot(all(eye.r == eye.coo))

# Section 1.7: classifying Iris species

names(iris) # here are the 'keys'
str(iris) # structure of the dataset

cat(sprintf("\nFeature names:\n\t %s \n", paste(names(iris), collapse='; ')))
    
cat("\nFirst five rows of data:\n")
print(iris[1:5, 1:4])

iris_target <- iris$Species

# iris_target stored as 'factor'
cat("\nSummary of iris target\n")
print(summary(iris_target))

cat("\nTarget levels\n")
print(levels(iris_target))

cat("\nTarget numberical values\n")
iris_targetNum <- as.numeric(iris_target)
print(iris_targetNum)

# Section 1.7.2: training and test data

test_training_split <- function(X, y, training.size = 0.75) {
        # X: dataset
        # y: vector
        # training size: (0, 1)
        # shuffle.test: TRUE to make the test set a random order
        nrow.X <- nrow(X)
        stopifnot(is.vector(y) | is.factor(y),
                  nrow.X == length(y))
        # choose rows randomly
        nrow.training <- floor(training.size * nrow.X)
        nrow.test <- nrow.X - nrow.training
        which.rows <- sample(nrow.X, nrow.training)
        # create training sets
        X.training <- X[which.rows, ]
        y.training <- y[which.rows]
        # create test sets
        # use 'sample' to randomise order of rows
        which.rows_neg <- sample((1:nrow.X)[-which.rows],
                                 size = nrow.test)
        # check that no rows are in both training and test
        stopifnot(!any(which.rows %in% which.rows_neg))
        X.test <- X[which.rows_neg, ]
        y.test <- y[which.rows_neg]
        # output
        res <- list(X.training = X.training, y.training = y.training,
                    X.test = X.test, y.test = y.test)
        res
}

iris_split <- test_training_split(X = iris[, 1:4], y = iris_target)

cat("\nIris training and test set structure:\n")
str(iris_split)

# Section 1.7.3: visualising the data


cat("\nSection 1.7.3: visualising the data...\n")
cat("\tusing pair plots to visualise training set...\n")

## plot pairs 
par(op)
# using 'pairs'
#pairs(iris_split$X.training, col = iris_split$y.training)

# library(GGally)
cat("\tcreating png plot of pairs\n")
ggpairs(iris_split$X.training, aes(colour = iris_split$y.training, alpha = 0.4))
my.dev.print("pairs", prefix = "ch1")


### Section 1.7.4 k-nearest neighbours
cat("\nUsing k-nearest neighbours to predict classification of test set\n")

knn.iris <- knn(train = iris_split$X.training, test = iris_split$X.test, 
                cl = iris_split$y.training, k = 1)

cat("\nTest set predictions:\n")
print(knn.iris)

cat("\nTrue test set classifications:\n")
print(iris_split$y.test)

cat(sprintf("\nTest set score: %.2f \n", mean(knn.iris == iris_split$y.test)))
