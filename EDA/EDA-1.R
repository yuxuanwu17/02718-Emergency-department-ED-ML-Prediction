######################## EDA-1 #############################

## load packages
library(openxlsx)

## load data
load("../../Data/5v_cleandf.rdata")

## inspect data by checking NA ratio of each column
## remove features that more than 5% samples have a NA in this field
removeNAColumn <- function(data, threshold = 0.05) {
  NA_ratio <- c()
  for (i in 1:ncol(data)) {
    curr_NA_ratio <- sum(is.na(data[, i]))/nrow(data)
    NA_ratio <- c(NA_ratio, curr_NA_ratio)
  }
  cleaned_dat <- data[, which(NA_ratio <= threshold)]
}

clean_dat <- removeNAColumn(df) # 584 feature + 1 label remaining

## remove samples has NA in any feature field
removeNARow <- function(data) {
  removeRowIndex <- c()
  for (i in 1:nrow(data)) {
    if (any(is.na(data[i, ]))) {
      removeRowIndex <- c(removeRowIndex, -i)
    }
  }
  newDat <- as.data.frame(data[removeRowIndex, ])
}

finalDat <- removeNARow(clean_dat)


## remove feature that are all the same between samples
## only one featture: “ecodesmachinery”
sameFeature <- c()
for (i in 1:ncol(finalDat)){
  if (length(table(finalDat[,i])) == 1) {
    sameFeature <- c(sameFeature, colnames(finalDat)[i])
  }
}
clean_dat <- finalDat[,which(colnames(finalDat)!= sameFeature[1])]

write.csv(clean_dat, "../../Data/Cleaned_dat.csv", row.names = FALSE)



## inspect on features
## read feature description
## 972 features and 1 label
features <- read.xlsx("../Data/Feature_dexcription.xlsx", colNames = TRUE)
table(features[2:nrow(features), 4])
#Binary Categorical     Numeric 
#497          13         461 

## inspect on features after cleaning
## 583 features and 1 label
remained_feature <- colnames(clean_dat)
table(features[which(features$Variable.Name %in% remained_feature),4])
#Binary Categorical     Numeric 
#491          13          79

## data imbalance
## the data is actually imbalanced, there are much more negative samples
## than positive samples
table(clean_dat$disposition)
