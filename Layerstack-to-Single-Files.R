####################################
##   Layerstack to Single Files   ##
##   by do-me 28.05.2018          ##
####################################  

# This script will save all 23 bands of a layerstack.img 
# file to # individual files to a new folder in .img format
# It will process all layerstack files found in a directory ending with .img

library(raster)
library(rgdal)

path <- "E:/layerstacks/"
# list all the layerstacks (.img format) in the given directory 
laystacks <- list.files(path, pattern = "*ndvi.img",full.names = TRUE) 

for (layerstack in laystacks){ # for one layerstack in the list of layerstacks
  
  for (i in 1:i){ # for all bands in one layerstack 
    
  RGB_bandi_HARV <- raster(layerstack, band = i) # take one band 
  
  # if needed, divide by 10,000
  # might be useful for NDVI handling if values are simplified
  # RGB_bandi_HARV <- RGB_bandi_HARV/10000 
  
  dir_without_img <- unlist(strsplit(layerstack, "\\."))[1] # remove .img from filename
  filename <- unlist(strsplit(dir_without_img, "[/]"))[6] #remove first part of filename, in order to return only name, change when folders change!
  
  # write raster with proper name to output directory
  writeRaster(RGB_bandi_HARV, file=paste("E:/outputfolder","/", filename, "_",i, ".img", sep = ''), overwrite=TRUE)}}
  
#Processes like this:

# 1
#RGB_band1_HARV <- raster("E:/Modis_Data/h24v05/Himachal_WGS84/himachal_2001_ndvi.img",band = 1)
#RGB_band1_HARV <- RGB_band1_HARV/10000 # rescale by 10 000 to get real NDVI values ranging from 0 to 1
#writeRaster(RGB_band1_HARV,
            #file="E:/Modis_Data/h24v05/All_Images/himachal_2001_evi_1.img",
            #format="GTiff",
            #overwrite=TRUE)

# 2
#RGB_band2_HARV <- raster("E:/Modis_Data/h24v05/Himachal_WGS84/himachal_2001_ndvi.img",band = 2)
#RGB_band2_HARV <- RGB_band2_HARV/10000
#writeRaster(RGB_band2_HARV,
            #file="E:/Modis_Data/h24v05/All_Images/himachal_2001_evi_1.img",
            #format="GTiff",
            #overwrite=TRUE)
# and so on