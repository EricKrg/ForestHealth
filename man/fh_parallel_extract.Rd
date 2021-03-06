% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fh_parrallel_extract.R
\name{fh_parallel_extract}
\alias{fh_parallel_extract}
\title{function to perform a raster::extract on very large data sets}
\usage{
fh_parallel_extract(raster_brick, in_geometry, no_cores)
}
\arguments{
\item{raster_brick}{-  a raster brick or stack}

\item{in_geometry}{- (multi) polygon (sf) or points (xy as matrix) where the ndvi should be extracted}

\item{no_cores}{- number of cores to register for the parallel job}
}
\value{

}
\description{
function to perform a raster::extract on very large data sets
}
\examples{
\dontrun{

}
}
\author{
Eric Krueger
}
