#' Test all tasks in rmarkdown file
#'
#' This function takes a file, searches all kye_words using key_word_prefix argument and then tests associated with all keywords r chunks. Then function compare the results with the expected value and return a dataframe containing file name, author, check results and number of corrected answers.
#' @param file an rmarkdown file or an r charactor vector.
#' @param expectations an expected values.
#' @param keyword_prefix a common part of all keywords. By default is "### ".
#' @param group logical. If TRUE, function searches first line with the "group:" argument and returns it in the summary.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' fit <- lm(mpg~cyl, mtcars)
#' test_one_file(list(2+2, fit$coefficients), test_1)
#' test_one_file(list(2+2, 42), test_1)
#' @export

test_one_file <- function(expectations, file, keyword_prefix = "### ", group = FALSE){
  # is file just a name or a whole file? ------------------------------------
  if(length(file) == 1){
    work <- readLines(file)
    file_name <- file
  } else{
    work <- file
    file_name <- deparse(substitute(file))
  }

  author <- substring(work[grep("author", work)][1],
                      10,
                      nchar(work[grep("author", work)])-1)

  keywords <- work[grep(keyword_prefix, work)]

  checks <- unname(mapply(function(x, y){
    test_task(file = work, keyword = x, expectations = y)
  },
  keywords, expectations))

  results <- data.frame(t(data.frame(checks)))
  names(results) <- keywords
  rownames(results) <- NULL
  if(group == TRUE){
    group_name <- substring(work[grep("group", work)][1],
                            9,
                            nchar(work[grep("group", work)])-1)
    results <- cbind.data.frame(author, group_name, results, file_name, stringsAsFactors = FALSE)
    results$results <- sum(unlist(results[, -c(1:2, length(results))]))
  } else {
    results <- cbind.data.frame(author, results, file_name, stringsAsFactors = FALSE)
    results$results <- sum(unlist(results[, -c(1, length(results))]))
  }
  results
}
