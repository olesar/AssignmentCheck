#' Test rmarkdown task
#'
#' This function takes a file, searches a kye_word line and then evaluate the first r chunk after the keyword. Then function compare ther result with the expected value.
#' @param file an rmarkdown file or an r charactor vector.
#' @param expectations an expected value.
#' @param keyword a key_word to identify, where shuld be r chunk searched.
#' @author George Moroz <agricolamz@gmail.com>
#' @examples
#' test_task(expectations = 2+2, file = test_1, keyword = "### 1.1")
#' test_task(expectations = 2+3, file = test_1, keyword = "### 1.1")
#' @export

test_task <- function(expectations, file, keyword) {
# is file just a name or a whole file? ------------------------------------
  if(length(file) == 1){
    work <- readLines(file)
  } else{
    work <- file
  }
  work <- work[grep(keyword, work):length(work)]
  start <- grep("```\\{r", work)[1]+1
  final <- grep("```", work)[2]-1
  identical(eval(parse(text=work[start:final])), expectations)}

