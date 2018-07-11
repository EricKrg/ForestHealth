#**********************************************************
# Time series----
# function which creates a timeseries data table
# returns a list with 1 - dt affected & 2 - dt unaffected
# input df needs colnames like: YYYYMMDD
# input is NDVI_DF output
#**********************************************************

create_timeseries <- function(ndvi_df){
  ndvi_aff <- ndvi_df %>%
    dplyr::filter(affected > 0)
  ndvi_no <- ndvi_df %>%
    dplyr::filter(affected == 0)
  time_df <-NULL
  i = NULL
  j = 1
  l = 1
  value = NULL
  end = length(ndvi_df)-1
  for(k in list(ndvi_aff,ndvi_no)){
    print(k)
    for(i in k[,2:end]) {
      print(j)
      tmp <- data.frame(value = i, affected = k$affected)
      time <- as.numeric(colnames(k)[j+1])
      year <- as.numeric(substr(time, 1,4))
      month <- as.numeric(substr(time, 5,6))
      day <- as.numeric(substr(time, 7,nchar(time)))
      tmp$time_raw <- as.numeric(colnames(k)[j+1])
      tmp$year <- year
      tmp$month <- month
      tmp$day <- day
      value[[j]] <- tmp
      j = j + 1
      tmp = NULL
    }
    time_tmp <- data.table::as.data.table(do.call(rbind, value))
    l =  l +1
    j = 1
  }
  #time_df <- data.table::as.data.table(do.call(rbind, value))
  return(time_df)
}
