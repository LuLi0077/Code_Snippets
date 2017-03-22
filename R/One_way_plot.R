oneway.plot <- function(dataset, x, y, weight=NULL)
{
    Weight = ifelse(is.null(weight), 1, dataset[,weight])
    modeldata <- data.frame(
    Weight = Weight,
    Actual = dataset[,y],
    Factor = as.factor(dataset[,x]))
    
    dframe <- as.data.frame(data.table(modeldata)[ ,.(SumWeight = sum(Weight),
    SumActual = sum(Actual),
    AverageActual = sum(Actual)/sum(Weight)),
    by = Factor])
    
    dframe <- dframe[order(dframe$Factor), ]
    dframe.melt <- melt(dframe [, c(1, 4)], id = c("Factor"))
    weight_max  <- max(dframe$SumWeight)
    resp_max    <- max(dframe.melt$value)
    
    plot1 <- ggplot(dframe, aes(x=Factor, y=SumWeight, group = 1)) +
    geom_bar(stat = "identity", aes(x = Factor, y = SumWeight*0.5*(resp_max)/(weight_max)),
    col = "black", fill = "#9EB9D4") +
    geom_line(data=dframe.melt, aes(x = Factor, y = value, color = variable, group = variable)) +
    scale_colour_manual(values = c("red")) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
    labs(title = paste("Oneway","-",x), x = "Values", y = "Target" )
    
    return(list(dframe=dframe, plot_table = plot1))
}

oneway.plot.fit <- function(df, var, exposure, response, fit)
{
  modeldata <- data.frame(Weight = df[[exposure]],
                          Actual = df[[response]],
                          Fit = df[[fit]],
                          Factor = df[[var]])
  
  dframe <- as.data.frame(data.table(modeldata)[,.(SumWeight = sum(Weight)
                                                   ,SumActual = sum(Actual)
                                                   ,SumFit  = sum(Fit)
                                                   ,AverageActual = sum(Actual)/sum(Weight)
                                                   ,AverageFit = sum(Fit)/sum(Weight))
                                                ,by = Factor])
  
  dframe <- dframe[order(dframe$Factor), ]
  dframe.melt <- melt(dframe [, c(1, 5, 6)], id = c("Factor"))
  weight_max <<- max(dframe$SumWeight)
  resp_max <<- max(dframe.melt$value)
  
  plot2 <- ggplot(dframe, aes(x = Factor, y = SumWeight, group=1)) +
    geom_bar(stat = "identity", aes(x = Factor, y = SumWeight*0.5*(resp_max)/(weight_max)), col = "#09091A", fill = "#1FBAD6") +
    geom_line(data = dframe.melt, aes(x = Factor, y = value, colour = variable, group = variable)) +
    scale_colour_manual(values = c("red", "blue", "black")) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
    labs(title = paste(var,"Oneway"), x = var,  y = "Response") 
  #+ geom_text(data=dframe.melt, aes(x=Factor, y = value, label = round(value, digits = 3), vjust = 9))
  
  return(list(dframe=dframe,plot=plot2))
}
