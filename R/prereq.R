#### top stuff

PROD <- !exists("PROD")

if (PROD) {

  ## stuff that happens the first time

  ## etc etc

  ## set the seed

  set.seed(1001)
  message("Using specified random seed (1001)")

} else {

  ## stuff that happens NOT the first time

  ## -- I don't usually have anything in here

  ## set the seed

  set.seed(NULL)
  message("Using random random seed")
}

my.Random.seed <- .Random.seed

print_text <- function(text, mat, ...) {
        cat(text, "\n")
        print(mat, ...)
        cat("\n")
}
