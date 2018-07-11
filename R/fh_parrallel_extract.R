#'
#' function to perform a raster::extract on very large data sets
#'
#' @author  Eric Krueger
#'
#' @name fh_parallel_extract
#'
#' @return
#'
#' @param raster_brick -  a raster brick or stack
#' @param in_geometry - (multi) polygon (sf) or points (xy as matrix) where the ndvi should be extracted
#' @param no_cores - number of cores to register for the parallel job
#' @examples
#' \dontrun{
#'
#' }
#' @export

fh_parallel_extract <- function(raster_brick, in_geometry, no_cores){
  cl <- parallel::makeCluster(no_cores, type="FORK")
  doParallel::registerDoParallel(cl)
  #getting all ndvi for all layers
  if(class(in_geometry)[1] == "matrix"){
    ndvi<- foreach(i=1:raster::nlayers(raster_brick)) %dopar%
      raster::extract(raster_brick[[i]],in_geometry)
  } else {
    in_geometry <- sf::st_zm(in_geometry) # drop z dimension
    ndvi <- foreach::foreach(i = 1:raster::nlayers(raster_brick)) %dopar%
      raster::extract(raster_brick[[i]], in_geometry, fun = mean, na.rm = TRUE)  # this takes forever
  }
  stopCluster(cl)
  gc()
  return(ndvi)
}
