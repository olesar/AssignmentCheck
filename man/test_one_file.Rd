% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/test_one_file.R
\name{test_one_file}
\alias{test_one_file}
\title{Test all tasks in rmarkdown file}
\usage{
test_one_file(expectations, file, keyword_prefix = "### ", group = FALSE)
}
\arguments{
\item{expectations}{an expected values.}

\item{file}{an rmarkdown file or an r charactor vector.}

\item{keyword_prefix}{a common part of all keywords. By default is "### ".}

\item{group}{logical. If TRUE, function searches first line with the "group:" argument and returns it in the summary.}
}
\description{
This function takes a file, searches all kye_words using key_word_prefix argument and then tests associated with all keywords r chunks. Then function compare the results with the expected value and return a dataframe containing file name, author, check results and number of corrected answers.
}
\examples{
fit <- lm(mpg~cyl, mtcars)
test_one_file(list(2+2, fit$coefficients), test_1)
test_one_file(list(2+2, 42), test_1)
}
\author{
George Moroz <agricolamz@gmail.com>
}

