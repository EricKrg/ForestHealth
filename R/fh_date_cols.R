#'
#' select all date stamps based on a input year
#'
#' @author  Eric Krueger
#'
#' @name fh_date_cols
#'
#' @return a formatted NDVI Data table, from an list of NDVI values
#' @param df - a data frame or data table
#' @param year - a string, this specifies the year of date stamps to select,
#' i.e. if year = "2016" all date stamps from 2016 are selected and returned as vector
#' @details
#' this functions returns a vector with the colnames of all time stamps of a df
#' so you could subset your df based on that vector and
#' cut out all columns which are date stamps
#' @export

fh_date_cols <- function(df, year){
  all_cols = NULL
  for(cols in colnames(df)){
    if(!is.na(stringr::str_match(cols, paste0(year,".*"))[1])){
      all_cols <- c(all_cols,cols) # all cols mit datum
    }
  }
  cols = NULL
  return(all_cols)
}
