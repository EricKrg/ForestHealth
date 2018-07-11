#'
#' function to return a formatted ndvi df
#'
#' @author  Eric Krueger
#' @name fh_NDVI_DF
#' @return a formatted NDIV Data table, from an list of NDVI values
#' @param inlist - list of NDVI layer, layers list == numbers of extracted points/polygons
#' @param layernames - vector of Layernames which are set a colnames, need to be ordered
#' @param transform_ndvi - if TRUE the NDVI values are transfromed like: (x- 10000)/10000
#' @details
#' thisfunction  returns a formatted ndvi df (data table)
#' inlist is the output of mean_extract() or result of a raster::extract job (if poly centroids were used)
#' layernames is a vector with the columnnames (date stamps) of the new ndvi dt
#' @export

fh_NDVI_DF <- function(inlist, layernames, transform_ndvi){
  ndvi_df <- data.table::data.table(PID = 1:length(inlist[[1]]))
  w = 1
  for(w in 1:length(inlist)){
    if(transform_ndvi){
      ndvi_tmp <- (unlist(inlist[[w]])-10000)/10000
    } else {
      ndvi_tmp <- unlist(inlist[[w]])
    }
    ndvi_df[,paste0(layernames[w])] <- ndvi_tmp
  }
  return(ndvi_df)
}
