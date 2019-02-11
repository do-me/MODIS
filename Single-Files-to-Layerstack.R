####################################
##   Single Files to Layerstack   ##
##   by do-me 28.05.2018          ##
#################################### 

# Create layerstack from all individual files in one folder

library(raster)
library(rgdal)
library (rts)
library (RCurl)
library (devtools)
library(rlist)
modisProducts()

path <- "E:/NDVI/"

# list all the layerstacks (.img format) in the given directory 
laystacks <- list.files(path, pattern = "*.img$",full.names = TRUE) 

listX <- list()
counter <- 0

for (i in laystacks){ 
  
  # if needed, implement condition, i.e. every second file to reduce total amount
  # if (i%%2 != 0){}
  
  counter <- counter+1
  
  bandi <- raster(i) # take one band 
  listX[counter]<-list.append(bandi)} # append to list
  
  #write list to rasterstack
modis = stack(listX)
writeRaster(modis, file="E:/NDVI.img", overwrite=TRUE)