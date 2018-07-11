#'
#' function to mask data with polygons - in parts
#'
#' @author Gregor Didenko, Eric Krueger
#'
#' @param no_cores - number of cores to register for the parallel job
#' @param in_raster - input raster to be masked
#' @param in_geometry - mask
#' @param parts - the raster is splitted into parts to speed up processing,
#' parts defines the number of parts
#' @details
#' @export

fh_parallel_mask <- function(no_cores, in_raster, in_geometry, parts){
  # Initiate cluster
  cl <- parallel::makeCluster(no_cores, type="FORK")
  doParallel::registerDoParallel(cl)

  # Parallelize mask function
  masked_raster <- foreach::foreach(i = 1:length(parts)) %dopar% {
    # create smaller raster for faster processing time
    temp = raster::crop(in_raster, raster::extent(in_geometry[parts[[i]], ]))
    # mask raster with part of geometry
    raster::mask(temp, in_geometry[parts[[i]], ])
  }
  # Finish
  parallel::stopCluster(cl)

  # Merge all raster parts
  rMerge <- do.call(merge, masked_raster)

  gc()
  return(rMerge)
}
