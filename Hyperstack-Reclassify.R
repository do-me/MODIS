################################
##   Hyperstack Reclassify    ##
##   by do-me 28.05.2018      ##
################################ 

# Reclassify all pixels from a given raster file to a certain value
# Then create hyperstack (big layerstack) where all pixels of one band are assigned one respective value 
# Useful for correlation analysis for time-series

# Here: Create Hyperstack with 204 bands (23, twice per month for one year *17, timespan in years), 
# where every pixel of a band is assigned respetive DMI value
# ATTENTION: Memory might be too small! >8gb RAM recommended

library(raster)
library(rgdal)
library(rlist)

# Raster input (one band only with proper col/row dimensions), number of columns required
r <- raster("E:/ndvi_1.img", ncol=1586)

# hard coded DMI list, 204 values (23*17)
listeDMI <- list(-0.245,0.163,0.15,0.334,0.353,0.337,0.173,0.001,0.162,-0.068,0.026,0.171,0.04,0.087,0.173,-0.156,-0.112,0.022,0.051,0.086,0.671,0.775,0.358,0.065,-0.063,0.199,0.12,0.095,0.053,0.346,0.438,0.403,0.326,0.137,0.105,0.407,0.225,0.293,0.248,0.116,-0.345,-0.179,0.009,0.162,0.28,0.372,0.104,0.091,0.055,-0.376,-0.268,0.278,0.183,0.032,-0.071,-0.045,-0.145,-0.054,-0.004,-0.068,0.056,-0.12,-0.06,0.181,0.005,0.148,0.346,0.523,0.806,0.945,0.759,0.392,0.402,0.331,0.275,0.291,0.485,0.242,0.36,0.536,0.623,0.451,0.246,0.004,0.303,0.112,0.269,0.042,0.397,0.424,0.553,0.42,0.474,0.41,0.144,0.174,0.218,0.348,0.264,0.319,0.471,0.305,0.115,0.196,0.279,0.362,0.188,0.382,0.473,0.209,0.628,0.56,0.183,0.065,0.308,0.244,0.123,-0.056,-0.216,0.021,0.373,0.418,0.537,0.352,0.126,0.261,0.533,0.646,0.586,0.735,0.597,0.097,0.227,0.1,0.195,-0.064,-0.122,0.218,0.856,0.944,0.839,0.49,0.165,0.488,0.118,0.372,0.246,-0.102,-0.29,-0.291,0.122,0.1,0.082,0.22,0.458,0.368,0.089,0.092,0.014,0.136,0.121,0.182,-0.05,-0.075,0.243,0.503,0.272,0.266,0.077,-0.165,-0.076,0.187,0.453,0.498,0.529,0.859,0.674,0.858,0.599,0.49,0.438,0.066,0.161,0.341,0.106,-0.227,-0.433,-0.142,-0.049,0.017,-0.093,-0.075,0.099,0.283,0.528,0.704,0.753,0.635,0.828,0.646,0.42,0.396,0.55,0.342) # One value for every pixel in one band of output raster

layers <- list()
counter <- 0
#counter2 <- 0 # this counter only for test purposes to diminish memory load

for (DMI in listeDMI){
  counter <-counter+1 
  #if (counter%%2 ==0){
  #counter2<-counter2+1
  
  # create matrix: all values from -infinite to x replaced by DMI
  m <- matrix(c(-Inf,-0.0000000000000000000001,DMI,
               0.00000000000000000000001,Inf, DMI), ncol=3, byrow=TRUE) 

  r <- reclassify(r, m) # reclassify the raster input r

  layers[counter]<-list.append(r)} # add bands to list
  # here counter2 in case of memory reduction

modis = stack(layers) # stack list to raster layer stack

writeRaster(modis, file="E:/dmi_stack_2001_2017", overwrite=TRUE)
