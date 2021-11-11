######################## EDA-2 #############################

# load packages
library(ggplot2)
library(reshape2)
library(ggcorrplot)
library(scales)
library(ggrepel)

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

## build correlation data frame
diposition_corr <- data.frame(cor = cortest["disposition",],
                              corabs = abs(cortest["disposition",]))
diposition_corr_order <- diposition_corr[order(diposition_corr$corabs, 
                                               decreasing = TRUE),]

cor_test <- cor(df_trans[,which(colnames(df_trans) %in% 
                                  rownames(diposition_corr_order)[1:30])])
ggcorrplot(cor_test, hc.order = TRUE, outline.col = "white")


########### sex pie chart ##############################
sexPie <- function(sexArray, titleText){
  sexDat <- data.frame(
    group = c("Male", "Female"),
    value = c(sum(sexArray == 2), 
              sum(sexArray == 1))
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

########### age stack barplot ##############################
## inspect on age
summary(df_trans$age)
age_start <- c(0,32,50,65)
age_end <- c(32,50,65,108)
age_interval_string <- c()
for (i in 1:4){
  current_age_string <- paste(age_start[i], 
                              age_end[i],sep = "-")
  age_interval_string <- c(age_interval_string, current_age_string)
}

age_df <- data.frame(label = rep(c("Admit", "Discharge"), each = 4),
                     age = rep(age_interval_string, 2),
                     age_start = rep(age_start, 2),
                     age_end = rep(age_end, 2),
                     value = 0)

## fill in the value field of the age data frame
for (i in 1:nrow(age_df)){
  age_df[i, "value"] <- nrow(clean_dat[which(clean_dat$disposition == age_df[i,1] &
                                               clean_dat$age >= age_df[i,3] & 
                                               clean_dat$age < age_df[i,4]),])
  if (i == 4 | i == 8) {
    age_df[i, "value"] <- nrow(clean_dat[which(clean_dat$disposition == age_df[i,1] &
                                                 clean_dat$age >= age_df[i,3] & 
                                                 clean_dat$age <= age_df[i,4]),])
  }
}

# Stacked barplot
ggplot(age_df[,c(1,2,5)], aes(fill=label, y=value, x=age)) + 
  geom_bar(position="fill", stat="identity")

