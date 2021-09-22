################################################################################
#                                     TABLE v REPLICATION OF AK91                      
#                                         VERSION: R 4.0.5
#                                         DATE: 2021-09-21
#                                         CAROLINA PERSSON
#
################################################################################
rm(list=ls())

df<-import("./Analysis/Input/Table_V_Data_Set.dta")

################################################################################


#### Perform regressions using data for cohort 30-39

col1 <- lm(lnweeklywage ~ EDUC + factor(YOB),data = df)
col3 <- lm(lnweeklywage ~ EDUC + factor(YOB)
           + AGEQ + AGEQSQ,data = df)
col5 <- lm(lnweeklywage ~ EDUC + factor(YOB)
           + RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT ,data = df)
col7 <- lm(lnweeklywage ~ EDUC + factor(YOB)
           + RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT
           + AGEQ + AGEQSQ ,data = df)

#### Perform instrumental variable regressions for cohort 30-39

col2 <- ivreg(lnweeklywage ~ EDUC + factor(YOB)
              | interaction(YOB,QOB) + factor(YOB),data = df)
col4 <- ivreg(lnweeklywage ~ EDUC + factor(YOB)
              + AGEQ + AGEQSQ
              | interaction(YOB,QOB) + factor(YOB)
              + AGEQ + AGEQSQ,data = df)
col6 <- ivreg(lnweeklywage ~ EDUC + factor(YOB)
              + RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT
              | interaction(YOB,QOB) + factor(YOB)+ RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT,data = df)
col8 <- ivreg(lnweeklywage ~ EDUC + factor(YOB)
              + RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT
              + AGEQ + AGEQSQ
              | interaction(YOB,QOB) + factor(YOB)
              + RACE + MARRIED + SMSA + NEWENG + MIDATL + ENOCENT + WNOCENT + SOATL + ESOCENT + WSOCENT + MT
              + AGEQ + AGEQSQ,data = df)

#### Output table

stargazer(col1,col2,col3,col4,col5,col6,col7,col8,out = "Analysis/output/Table_V_cohort30_39.txt")


################################################################################