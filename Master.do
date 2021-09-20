/************************************************
 MASTER-DO  PROGRAM
 
 Applied Empirical Methods in Economics
 Task 2c 
 Carolina Persson
 Date: 2021-09-15
*************************************************/
clear
cls

global rootdir "C:/Users/cape8126/Desktop/AEE1Folder/Task2c/local_repo/AK91"
 
cd $rootdir

/* Load raw data to Build/Input folder.
   First remove and create Build/Input directory
   then load data 
*/
ssc install outreg2

!rmdir "Build/Input"  /s /q
mkdir "Build/Input"
copy Raw/New7080.dta Build/Input/

* Build basic data sets in Analysis/Input/  
!rmdir "Analysis/Input/"  /s /q
mkdir "Analysis/Input"

!rmdir "Analysis/Output/"  /s /q
mkdir "Analysis/Output"

*log using "Analysis/Output/QOB.log", replace 

************************************************
** BUILD AND CLEAN DATA
************************************************

do Build/Code/QOBTableIV.do

************************************************
** ANALYSE DATA
************************************************

use "Analysis/Input/QOBcleanedData.dta"
keep if COHORT<20.30
do Analysis/Code/cohort_analysis.do

use "Analysis/Input/QOBcleanedData.dta"
keep if COHORT>30.00 & COHORT <30.40
do Analysis/Code/cohort_analysis.do

use "Analysis/Input/QOBcleanedData.dta"
keep if COHORT>40.00
do Analysis/Code/cohort_analysis.do

************************************************
** CLEAN AND END
************************************************
*log close
clear
cls
