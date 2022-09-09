#### top stuff

PROD <- !exists("PROD")

if (PROD) {

        ## stuff that happens the first time
        if(isFALSE("MatrixExtra" %in% rownames(installed.packages()))) {
                install.packages("MatrixExtra", repos = "https://cloud.r-project.org")
        }
        library(MatrixExtra)
        if(isFALSE("GGally" %in% rownames(installed.packages()))) {
                install.packages("GGally", repos = "https://cloud.r-project.org")
        }
        library(GGally)
        if(isFALSE("class" %in% rownames(installed.packages()))) {
                install.packages("class", repos = "https://cloud.r-project.org")
        }
        library(class) #knn

        ### set plotting requirements{{{
        ## https://iwihktw.wordpress.com/2019/08/15/setting-up-your-script-file/

        ## sort out the graphics windows
        my.dev.print <- function(name, prefix = "foo1") {
          if (PROD) {
            fname <- paste0(prefix, "_", name, ".png")
            dev.print(png, fname,
              width = par("din")[1], height = par("din")[2],
              units = "in", pointsize = 12, res = 144,
              bg = "transparent")
            message("Figure written to ", fname)
          }
          invisible(NULL)
        }

        graphics.off()
        dev.new(width = 5.5, height = 4) # in inches
        acrossthetop <- dev.cur()

        ## sort out par
        par(mar = c(4, 4, 3, 1), mgp = c(2, 0.7, 0), cex.lab = 0.8,
          cex.axis = 0.8, cex.main = 1, font.main = 1, las = 1)
        op <- par(no.readonly = TRUE)
        invisible(dev.off())
#}}}


        print_text <- function(text, mat, ...) {
                cat(text, "\n")
                print(mat, ...)
                cat("\n")
        }

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
