#' Creates rmarkdown from mestaken tasks
#'
#' This function takes a results of test_files() function and writes in working directory an rmarkdown containing all mistaken tasks made by students.
#' @param results data frame with test_files() results
#' @param keyword_prefix a common part of all keywords. By default is "### ".
#' @param write_file logical. If TRUE, writes the created rmarkdown to the working directory.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' my_files <- c(
#' system.file("extdata", "test_1.Rmd", package = "AssignmentCheck"),
#' system.file("extdata", "test_2.Rmd", package = "AssignmentCheck"),
#' system.file("extdata", "test_3.Rmd", package = "AssignmentCheck"),
#' system.file("extdata", "test_4.Rmd", package = "AssignmentCheck")
#' )
#' fit <- lm(mpg~cyl, mtcars)
#' result <- test_files(expectations = list(2+2, fit$coefficients), files = my_files)
#' mistaken_tasks(results = result, write_file = FALSE)
#' @export
#'
#' @importFrom tidyr gather

mistaken_tasks <- function(results, keyword_prefix = "### ", write_file = TRUE) {
  tasks <- correctness <- NULL # trick to control R CMD CHECK
      mistakes <- tidyr::gather(subset(results, select=-c(results)),
                           key = tasks, value = correctness,
                           grep(keyword_prefix, names(results)))

  mistakes <- mistakes[mistakes$correctness == FALSE,]

  results_rmd <- lapply(unique(mistakes$author), function(x){
    text <- readLines(unique(mistakes[mistakes$author == x,'file_name']))
    lapply(mistakes[mistakes$author == x, 'tasks'], function(y){
      checkpoints <- c(grep(keyword_prefix, text), length(text)+1)
      n <- which(checkpoints == grep(y, text))
      c(paste(y, x), text[(checkpoints[n]+1):(checkpoints[n+1]-1)])})
  })

  results_rmd <- unlist(results_rmd)
  # add rmarkdown header
  results_rmd <- c('---', 'date: "`r Sys.Date()`"', 'output: html_document', '---', '',
                  results_rmd)

  if(write_file == TRUE){
  writeLines(results_rmd, "mistaken_tasks.Rmd")
  } else {results_rmd}
}
