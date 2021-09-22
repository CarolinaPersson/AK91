#####################################################################################################
#                                 DATA MANAGEMENTE FOR  REPLICATION OF AK91                      
#                                         VERSION:    R 4.0.5
#                                         INPUT:      Raw/NEW7080.dta
#                                         OUTPUT:     Table_IV_Data_Set.dta
#                                                     Table_V_Data_Set.dta
#                                                     Table_Vi_Data_Set.dta
#                                                     fIGURE_V_Data_Set.dta
#                                         DATE:       2021-09-21
#                                         CAROLINA PERSSON
#
#####################################################################################################


unlink("Analysis/Input",recursive = TRUE)
dir.create("Analysis/Input")


df<-import("./Raw/NEW7080.dta")

colnames(df)[1:27]<-c("AGE","AGEQ", "v3", "EDUC", "ENOCENT", "ESOCENT", "v7", "v8",
    "lnweeklywage", "MARRIED", "MIDATL", "MT", "NEWENG", "v14", "v15",
    "CENSUS", "v17", "QOB", "RACE", "SMSA", "SOATL", "v22", "v23", "WNOCENT",
    "WSOCENT","v26", "YOB")

#### Select only variables of interest, drop those starting with name "v"
df <- select(df, !starts_with("v"))


#### Create COHORT variable and modify age

df <- df %>% mutate(COHORT=20.29,
                        COHORT=ifelse(YOB<=39 & YOB >=30, 30.39, COHORT),
                        COHORT=ifelse(YOB<=49 & YOB>=40, 40.49, COHORT),
                        AGE=ifelse(CENSUS==80,AGE-1900,AGE),
                        AGEQSQ=AGEQ^2)

#### Create YEAR dummies YR20 - YR29

for (year in 20:29){
  YEARnumber <- paste("YR",year,sep = "")
  df[YEARnumber] <- transmute(df,x=0,
                             x=ifelse(YOB== 1900 + year, 1, x)
                             ,x=ifelse(YOB== 10 + year, 1, x)
                             ,x=ifelse(YOB== 20 + year, 1, x)
# transmute() creates the new dummy variable x. Then it is stored in YEAR20-YR29
  )
}
rm(YEARnumber, year)


#### Create QOB dummies QTR1 - QTR4
for (quarter in 1:4){
  Quartnumber <- paste("QTR",quarter,sep = "")
  df[Quartnumber] <- transmute(df, x=as.numeric(QOB==quarter))
  
}
rm(Quartnumber, quarter)

#### Create interaction dummies between QOB and YEAR20 - YR29
for (quarter in 1:4){
  for (year in 20:29){
    QuarterYEAR <- paste("QTR",quarter,year,sep = "")
    Quarternumber <- paste("QTR",quarter,sep = "")
    YEARnumber <- paste("YR",year,sep = "")
    df[QuarterYEAR] <- ifelse(df[Quarternumber]==1 & df[YEARnumber]==1,1,0)
  }
}
rm(QuarterYEAR, Quarternumber, YEARnumber, quarter, year)


########################################################

#save
df_coh_20<-subset(df, df$COHORT==20.29)
export(df_coh_20, "./Analysis/Input/Table_IV_Data_Set.dta")

df_coh_30<-subset(df, df$COHORT==30.39)
export(df_coh_30, "./Analysis/Input/Table_V_Data_Set.dta")

df_coh_40<-subset(df, df$COHORT==40.49)
export(df_coh_40, "./Analysis/Input/Table_VI_Data_Set.dta")

df_all<-df
export(df_all, "./Analysis/Input/Figure_V_Data_Set.dta")

rm(list=ls())


