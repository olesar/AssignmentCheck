## ---- eval= F------------------------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("agricolamz/AssignmentCheck")

## ------------------------------------------------------------------------
library(AssignmentCheck)

## ------------------------------------------------------------------------
setwd("/home/agricolamz/_DATA/OneDrive1/_Work/github/markdown_check/tests")
fit <- lm(mpg~cyl, mtcars)
test_files(expectations = list(4, fit$coefficients))

## ------------------------------------------------------------------------
citation("AssignmentCheck")

