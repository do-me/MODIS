# Reproject all files in directory 
# assembled from on the basis of https://www.rdocumentation.org/packages/raster/versions/2.8-19/topics/projectRaster

library(raster)
library(rgdal)

filelist <- list.files("E:/", pattern = "*.img$", full.names = TRUE)
fn <- gsub("\\.img$", "_prj.img", filelist)
newproj <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"

for (i in 1:i){
  r <- raster(filelist[i])
  prj <- projectRaster(r, crs=newproj, method = 'ngb', filename = fn[i], overwrite=TRUE)}