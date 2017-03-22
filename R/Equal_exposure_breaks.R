equalexposurebreaks <- function(nbins,weight,factor,miss=NA,sensitivity=1)
{
  if (!is.na(miss)){factor[factor==miss]=NA}
  sort <- order(factor)
  factor.sort <- factor[sort]
  weight.sort <- weight[sort]
  weight.cum <- cumsum(weight.sort)
  weight.sum <- max(weight.cum[!is.na(factor.sort)])
  weight.sumna <- max(weight.cum)
  weight.bands <- cut(weight.cum,c(seq(0,weight.sum,(weight.sum/nbins)),weight.sumna+sensitivity))
  levels(weight.bands)<-(1:length(levels(weight.bands)))
  fac_breaks <- vector(length = nbins + 1)
  fac_breaks[1] <- min(factor[!is.na(factor)])-sensitivity
  for (i in 1:nbins){
    fac_breaks[i+1] <- max(max(factor.sort[weight.bands==i]),fac_breaks[i]+sensitivity)
    
  }
  return(fac_breaks)
}

equalexposurecut <- function(nbins, weight, factor, miss=NA, sensitivity=1)
{
    if (!is.na(miss)){factor[factor==miss]=NA}
    sort <- order(factor)
    factor.sort <- factor[sort]
    weight.sort <- weight[sort]
    weight.cum <- cumsum(weight.sort)
    weight.sum <- max(weight.cum[!is.na(factor.sort)])
    weight.sumna <- max(weight.cum)
    weight.bands <- cut(weight.cum,c(seq(0,weight.sum,(weight.sum/nbins)),weight.sumna+sensitivity))
    levels(weight.bands)<-(1:length(levels(weight.bands)))
    fac_breaks <- vector(length = nbins + 1)
    fac_breaks[1] <- min(factor[!is.na(factor)])-sensitivity
    fac_labels <- vector(length = nbins + 1)
    for (i in 1:nbins){
        fac_breaks[i+1] <- max(max(factor.sort[weight.bands==i]),fac_breaks[i]+sensitivity)
        
    }
    factor_bin <- cut(factor, fac_breaks)
    levels(factor_bin)<-c(levels(factor_bin),"NA")
    factor_bin[is.na(factor_bin)]=levels(factor_bin)[length(levels(factor_bin))]
    return(factor_bin)
}
