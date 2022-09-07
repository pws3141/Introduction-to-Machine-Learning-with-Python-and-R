# Machine Learning with Python
# Ch1: Introduction

source("prereq.R")

# creating a matrix
x <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)
print_text("x = ", x)    

# moving from sparse matrix to CSR representation

# load MatrixExtra: package allowing for sparse matrices
# https://cran.r-project.org/web/packages/MatrixExtra/MatrixExtra.pdf
#install.packages("MatrixExtra", repos = "https://cloud.r-project.org")
library(MatrixExtra)

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

