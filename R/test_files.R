#' Test all tasks in all rmarkdown files

#' This function takes all files in directory, searches all kye_words using key_word_prefix argument and then tests associated with all keywords r chunks. Then function compare the results with the expected value and return a dataframe containing file name, author, check results and number of corrected answers.
#' @param files an rmarkdown files. By dafault is all .Rmd files in a working directory.
#' @param expectations an expected value.
#' @param keyword_prefix a common part of all keywords. By default is "### ".
#' @param group logical. If TRUE, function searches first line with the "group:" argument and returns it in the summary.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' \dontrun{
#' fit <- lm(mpg~cyl, mtcars)
#' test_files(expectations = list(2+2, fit$coefficients))}
#' @export

test_files <- function(expectations, files = list.files(), keyword_prefix = "### ", group = FALSE) {
  if(length(files) == 0){
    warning("There is no files to check", call. = FALSE)
  }

  files <- files[grep(".Rmd", files)]

  results <- test_one_file(file = files[1], expectations = expectations, group = group)

  sapply(files[-1], function(x) {
    results <<- rbind.data.frame(results,
                                 test_one_file(file = x, expectations = expectations, group = group))
  })

  results
}
