####################################
##   Rearrange Layerstacks        ##
##   by do-me 01.06.2018          ##
#################################### 

# Rearrange bands of layerstacks
# Creates new layerstack for every band from all layerstack
# NewStack 1 = Band 1 of every layerstack (1,2,3...)
# NewStack 2 = Band 2 of every layerstack (1,2,3...)
# ...
# Useful for quick trend analysis i.e. in ERDAS

library(raster)
library(rgdal)

path <- "E:/Rearrange/"

# list all the layerstacks (.img format) in the given directory 
laystacks <- list.files(path, pattern = "*.img$",full.names = TRUE) 

listX <- list() # create empty list list
counter <- 0

for (i in 1:15){ # we create 15 new layerstacks (for every band a new one)
  
  counter <- counter+1
  assign("listX", NULL, envir = .GlobalEnv) # empty listX
  inbandcounter <- 0
  
  # crucial loop: take band i for every old layerstack in directory and append it to listX
  for (layerstack in laystacks){ # for one layerstack in the list of layerstacks
    
    inbandcounter <- inbandcounter+1
    
    bandi<- raster(layerstack, band = i) # take only band i of current layerstack
    listX[inbandcounter]<-list.append(bandi)}
  
  #write list to rasterstack
  modis = stack(listX)
  writeRaster(modis, file=paste("E:/Band_",counter, ".img", sep = ''), overwrite=TRUE)}
  