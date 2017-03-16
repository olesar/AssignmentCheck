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
#  readLines("test_1.Rmd")

## ---- echo= FALSE--------------------------------------------------------
my_files <- c(
  system.file("extdata", "test_1.Rmd", package = "AssignmentCheck"),
  system.file("extdata", "test_2.Rmd", package = "AssignmentCheck"),
  system.file("extdata", "test_3.Rmd", package = "AssignmentCheck"),
  system.file("extdata", "test_4.Rmd", package = "AssignmentCheck")
)
readLines(my_files[1])

## ---- eval=FALSE---------------------------------------------------------
#  make_expectations("test_1.Rmd")

## ---- echo= FALSE--------------------------------------------------------
make_expectations(my_files[1])

## ---- eval=FALSE---------------------------------------------------------
#  fit <- lm(mpg~cyl, mtcars)
#  test_files(expectations = list(4, fit$coefficients))

## ---- echo=FALSE---------------------------------------------------------
fit <- lm(mpg~cyl, mtcars)
show <- test_files(files = my_files, expectations = list(4, fit$coefficients))
show <- cbind.data.frame(show[,-5], file_name = c("test_1.Rmd", "test_2.Rmd", "test_3.Rmd", "test_4.Rmd"))
show

## ---- eval=FALSE---------------------------------------------------------
#  test_files(expectations = make_expectations("test_1.Rmd"))

## ---- echo=FALSE---------------------------------------------------------
show <- test_files(files = my_files, expectations = make_expectations(my_files[1]))
show <- cbind.data.frame(show[,-5], file_name = c("test_1.Rmd", "test_2.Rmd", "test_3.Rmd", "test_4.Rmd"))
show

## ---- eval=FALSE---------------------------------------------------------
#  test_files(expectations = make_expectations("test_1.Rmd", group = TRUE))

## ---- echo=FALSE---------------------------------------------------------
show <- test_files(files = my_files, expectations = make_expectations(my_files[1]), group = TRUE)
show <- cbind.data.frame(show[,-6], file_name = c("test_1.Rmd", "test_2.Rmd", "test_3.Rmd", "test_4.Rmd"))
show

## ---- eval=FALSE---------------------------------------------------------
#  result <- test_files(expectations = make_expectations("test_1.Rmd"))
#  mistaken_tasks(result, write_file = FALSE)

## ---- echo=FALSE---------------------------------------------------------
show <- test_files(files = my_files, expectations = make_expectations(my_files[1]))
mistaken_tasks(show, write_file = FALSE)

## ------------------------------------------------------------------------
citation("AssignmentCheck")

