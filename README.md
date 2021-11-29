# Prediction of hospital admission at emergency department using machine learning


## Background
Emergency department (ED) visit is one of the most common ways to get medical support and EDs represents the largest source of hospital admissions. In order to improve the running efficiency of ED, optimize the resource allocation, as well as to maximize the number of patients that get appropriate treatment, we train machine learning models to predict hospital admission at the time of ED triage using patients' triage information and previous medical history.

**Note**: This is the course project for 02-718 Computational Medicine in fall 2021


## Data souorce
The Electronic Health Record (EHR) data we use was from a paper published on [PLOS one](https://doi.org/10.1371/journal.pone.0201016). The original retrospective data was obtained from three Emergence Departments from March 2013 to July 2017, each ensuring one year of historical timeframe. We obtained the data from the author's [Github Repository](https://github.com/yaleemmlc/admissionprediction) and corresponding [Keggle dataset](https://www.kaggle.com/maalonahospital-triage-and-history-data-top-variables/data). 

**Note**: Because data is large (> 500M), which includes 560,486 patient visits with 972 variables, we didn't upload it under this repo. But we can send it to you if your are interested.


## Workflow

<p align="center">
    <img src="https://github.com/yuxuanwu17/proj4CM/blob/WX/Workflow.png" height="400" width="500" alt = "workflow"/>
</p>

## File organization

* `EDA` folder: includes scripts for EDA and some plots
* `Data` folder: includes Feature_dexcription.xlsx file which has descriptions for each feature
* `comparison_plot` folder: includes performance comparsion between four models
* `model` folder: includes feature selection .py script, scripts for training four models and code for drawing comparsion plots
* `paper&Proposol` folder: includes the original [PLOS one](https://doi.org/10.1371/journal.pone.0201016) paper and our project proposal

## Authors
* Xin Wang, xinwang3@andrew.cmu.edu, Carnegie Mellon University
* Yuxuan Wu, yuxuanwu@andrew.cmu.edu, Carnegie Mellon University
