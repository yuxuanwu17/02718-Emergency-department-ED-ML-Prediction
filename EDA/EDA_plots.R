######################## EDA-2 #############################

# load packages
library(ggplot2)
library(reshape2)
library(ggcorrplot)
library(scales)
library(ggrepel)

# only triage feature
useonlytriage <- function(df) {
  demographics <- 1:16
  triage_vitals <- which(names(df) == 'triage_vital_hr'):which(names(df) == 'triage_vital_temp')
  cc <- which(names(df) == 'cc_abdominalcramping'):which(names(df) == 'cc_wristpain')
  onlytriage <- c(demographics, triage_vitals, cc)
  
  df[,onlytriage]
}

########### correlation heatmap ##############################

## transform categorical and binary features to numeric feature
## for computing the correlation
df_trans <- clean_dat
for (i in 1:ncol(clean_dat)) {
  df_trans[,i] <- as.numeric(df_trans[,i])
}

# computing correlation and inspect features with high correlation
cortest <- cor(df_trans)
plot(cortest["disposition",] )
mean(abs(cortest["disposition",]))
ggcorrplot(cortest, hc.order = TRUE, outline.col = "white")


########### sex pie chart ##############################
sexPie <- function(sexArray, titleText){
  sexDat <- data.frame(
    group = c("Male", "Female"),
    value = c(sum(sexArray == "Male"), 
              sum(sexArray == "Female"))
  )
  
  bp <- ggplot(sexDat, aes(x="", y=value, fill=group))+
    geom_bar(width = 1, stat = "identity")
  
  pie <- bp + coord_polar("y", start=0)
  
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=14, face="bold", hjust = 0.5)
    )
  
  p <- pie + scale_fill_brewer("Gender") + blank_theme +
    theme(axis.text.x=element_blank())+
    geom_text_repel(aes(y = value/2 + c(0, cumsum(value)[-length(value)]), 
                  label = percent(value/sum(value))), size=5) +
    ggtitle(titleText)
  p
}



########### esi pie chart ##############################
esiPie <- function(esiArray, titleText){
  esiArray <- as.numeric(esiArray)
  esiDat <- data.frame(
    group = c("level1", "level2", "level3", 
              "level4", "level5"),
    value = c(sum(esiArray == 1), sum(esiArray == 2), 
              sum(esiArray == 3), sum(esiArray == 4),
              sum(esiArray == 5))
  )
  
  bp<- ggplot(esiDat, aes(x="", y=value, fill=group))+
    geom_bar(width = 1, stat = "identity")
  
  pie <- bp + coord_polar("y", start=0)
  
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=14, face="bold", hjust = 0.5)
    )
  
  p <- pie + scale_fill_brewer("ESI") + blank_theme +
    theme(axis.text.x=element_blank())+
    geom_text_repel(aes(y = value/2 + c(0, cumsum(value)[-length(value)]), 
                  label = percent(value/sum(value))), size=5) + 
    ggtitle(titleText)
  p
}

