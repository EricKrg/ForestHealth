# ForestHealth

This repo holds the ForestHealth package which works togther with the ml_forest-health repository. 
This package consists of useful function to prepare NDVI data for ml and ensures structure and reproducibility for the ml_forest-health repo.

## functions

### raster only

- fh_writerowWise
- fh_parallel_extract
- fh_parallel_mask
- fh_raster_transform

### non raster

- fh_date_cols
- fh_NDVI_DF
- fh_stat_extract
