#'
#' function to write a raster file by row
#'
#' @author  Gergor Didenko, Eric Krueger
#' @name fh_write_rowwise
#' @return writes raster to disk
#' @param layer - raster layer to be written
#' @param path - file location
#' @param  name - file name
#' @details
#' write raster to disk rowwise, uses less memory than writeRaster
#' take raster with path and name and write to disk. good for very large rasters
#' @export

fh_write_rowWise <- function(layer, path, name){
  # create empty brick
  b <- raster::brick(layer, values=FALSE)
  b <- raster::writeStart(b,
                          filename= paste0(path, "/", name, ".gri"),
                          format="raster",
                          overwrite=TRUE)
  tr <- raster::blockSize(b)
  for (i in 1:tr$n) {
    v <- raster::getValuesBlock(layer , row=tr$row[i], nrows=tr$nrows[i])
    b <- raster::writeValues(b, v, tr$row[i])
  }
  b <- raster::writeStop(b)
  rm(v, b)
  gc()
}
