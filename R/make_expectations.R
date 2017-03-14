#' Make an expectation list from rmarkdown file
#'
#' This function takes a file, searches all kye_words using key_word_prefix argument and then create a list with evaluation of all chunks with keywords.
#' @param file an rmarkdown file or an r charactor vector.
#' @param keyword_prefix a common part of all keywords. By default is "### ".
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' make_expectations(test_1)
#' @export

make_expectations <- function(file, keyword_prefix = "### ") {
  # is file just a name or a whole file? ------------------------------------
  if(length(file) == 1){
    work <- readLines(file)
  } else{
    work <- file
  }

  keywords <- work[grep(keyword_prefix, work)]

  results <- lapply(keywords, function(x) {
  work <- work[grep(x, work):length(work)]
  start <- grep("```\\{r", work)[1]+1
  final <- grep("```", work)[2]-1
  eval(parse(text=work[start:final]))
  })

results
}
