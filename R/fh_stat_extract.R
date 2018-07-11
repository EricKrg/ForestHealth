#'
#' function to return a layer list for fh_NDVI_DF()
#'
#' @author  Eric Krueger
#' @name fh_stat_extract
#' @return a list with the selected statistical parameter for each poly in each layer
#' @param extract_result - a nested list, length represents the number of layers
#'  from the raster extract, length of nested lists represents the number of polygons used for extraction
#' @param stat - string to specify the statistical parameter to apply i.e. "mean", "max", "min" ...
#' @examples
#' \dontrun{
#' test_list <- readRDS("inst/data/test_list.RDS")
#' test_layer_list <- fh_stat_extract(test_list, "mean", na.rm = T)
#' fh_NDVI_DF(test_layer_list,layernames = c(1:24),transform_ndvi = F)
#' }
#' @export
fh_stat_extract <-function(extract_results, stat, ...){
  print(paste0("using following statistic: ", stat))
  l = 1
  j = 1
  poly_list = list()
  layer_list = list()

  for(k in 1:length(extract_results)){
    for(i in extract_results[[k]]){
      tmp <- eval(parse(text= stat))(i, ...)
      poly_list[[j]] <- tmp
      j = j + 1
    }
    layer_list[[l]] <- poly_list
    j = 1
    poly_list = list()
    l = l + 1
  }
  return(layer_list)
}


