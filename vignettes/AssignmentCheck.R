## ---- eval= F------------------------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("agricolamz/AssignmentCheck")

## ------------------------------------------------------------------------
library(AssignmentCheck)

## ---- eval=FALSE---------------------------------------------------------
#  list.files()

## ---- echo= FALSE--------------------------------------------------------
my_files <- c("test_1.Rmd", "test_2.Rmd", "test_3.Rmd", "test_4.Rmd", "test.txt")
my_files

## ---- eval=FALSE---------------------------------------------------------
#  fit <- lm(mpg~cyl, mtcars)
#  test_files(expectations = list(4, fit$coefficients))

## ---- echo=FALSE---------------------------------------------------------
fit <- lm(mpg~cyl, mtcars)
test_files(files = my_files, expectations = list(4, fit$coefficients))

## ------------------------------------------------------------------------
citation("AssignmentCheck")

