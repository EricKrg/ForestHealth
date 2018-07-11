#'
#' function to perform a raster::extract on very large data sets
#'
#' @author  Eric Krueger
#'
#' @name fh_raster_transform
#'
#' @return
#'
#' @param in_layerStack -  a raster brick or stack
#' @param transfrom_eq - equation to manipulate the cell values i.e. "(x - 10000) /10000"
#' x represents the cell value
#' @details
#' takes a layer stack/brick an transforms all layers-pixel values
#' provide a transformation eq like: transform_eq = "(x-10000) / 10000"
#' @examples
#' \dontrun{
#' r <- r2 <- raster::raster(ncol=10, nrow=10)
#' r <- raster::setValues(r,1:raster::ncell(r))
#' r2 <- raster::setValues(r2,10)
#' raster_brick <- raster::brick(r,r2)
#' fh_raster_transform(in_layerStack = raster_brick,
#'                  transform_eq = "(x + 10) / 2") # adds 10 to each cell
#' }
#' @export

fh_raster_transform <- function(in_layerStack, parallel, no_cores, transform_eq){
  print(paste0("using: ", transform_eq, " for transformation"))
    for(layer in 1:raster::nlayers(in_layerStack)){
      x <- in_layerStack[[layer]]
      trans_tmp <-eval(parse(text=transform_eq)) # apply trans_eq
      trans_tmp[trans_tmp < 0] <- NA
      in_layerStack[[layer]] <- trans_tmp
      trans_tmp = x = NULL
    }
  gc()
  return(in_layerStack)
}
