################################################################################
#                                     MASTER FILE FOR TASK 4
#                                     REPLICATION OF AK91                      
#                                     R 4.0.5
#                                     DATE: 2021-09-21
#                                     CAROLINA PERSSON
#
################################################################################

rm(list=ls())                   # Removes all objects from the R memory

#install.packages("rio")         # For data import and export in R
#install.packages("dummies")     # Expands factors, characters and other eligible classes into dummy/indicator variables.
#install.packages("stringr")     # Functions for working with strings
#install.packages("tidyverse")   # A set of packages. Includes dplyr and ggplot2 among others
#install.packages("gdata")       # R programming tools for data manipulation
#install.packages("AER")         # Applied Econometrics with R
#install.packages("stargazer")   # Creates well-formatted regression tables
library(tidyverse)
library(stringr)
library(dummies)
library(rio)
library(gdata)
library(AER)
library(stargazer)           

#### Set working directory
wdir <- "C:/Users/cape8126/Desktop/AEE1Folder/Task4/AK91/r_impl"
setwd(wdir)

#### Call and execute scripts for Tables IV, V, VI and Figure V
source("./Build/Code/dataManagement.R")
source("./Analysis/Code/QOB_Table_IV_c.R")
source("./Analysis/Code/QOB_Table_V_c.R")
source("./Analysis/Code/QOB_Table_VI_c.R")
source("./Analysis/Code/QOB_Figure_V_c.R")


