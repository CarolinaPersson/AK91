****************************************************************
**** ANALYSIS PART
**** TASK 2c 
****
**** NAME OF THIS FILE: Analysis/Code/cohort_analysis.do
**** INPUT:  			Analysis/Input/QOBcleanedData.dta
**** OUTPUT: 			Analysis/Output/TableCols1357.rtf
****         			Analysis/Output/TableCols2468.rtf
****
****  
**** PERFORMS REGRESSIONS 
**** 
**** CAROLINA PERSSON
**** Date: 2021-09-16
****************************************************************

* use "Analysis/Input/QOBcleanedData.dta"

****************************************************************

local YEARS "YR20-YR28"
local CONTROLS "i.RACE i.MARRIED i.SMSA i.NEWENG i.MIDATL i.ENOCENT i.WNOCENT i.SOATL i.ESOCENT i.WSOCENT i.MT"
local AGEQUARTERS "AGEQ AGEQSQ"
local EDUCinstruments "QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28"

** REGRESSION FOR COLUMNS 1 3 5 7 ***

* COL 1.  
quietly reg LWKLYWGE EDUC `YEARS'
est store Col1 

* COL 3. 
quietly reg LWKLYWGE EDUC `YEARS' `AGEQUARTERS'
est store Col3 

* COL 5. 
quietly xi: reg LWKLYWGE EDUC `CONTROLS' `YEARS'
est store Col5 

* COL 7.
quietly xi: reg LWKLYWGE EDUC `CONTROLS' `YEARS' `AGEQUARTERS'
est store Col7

outreg2 [Col1 Col3 Col5 Col7] using "Analysis/Output/TableCols1357.rtf", replace see
est store clear

** IV-REGRESSIONS FOR COLUMNS 2 4 6 8 ***

* Col 2 .
quietly ivregress 2sls LWKLYWGE `YEARS' (EDUC = `EDUCinstruments')
est store Col2

* Col 4 .
quietly ivregress 2sls LWKLYWGE `YEARS' `AGEQUARTERS' (EDUC = `EDUCinstruments')
est store Col4

* Col 6 . 
quietly ivregress 2sls LWKLYWGE `YEARS' `CONTROLS' (EDUC = `EDUCinstruments')
est store Col6

* Col 8 . 
quietly ivregress 2sls LWKLYWGE `YEARS' `CONTROLS' `AGEQUARTERS' (EDUC = `EDUCinstruments')
est store Col8

outreg2 [Col2 Col4 Col6 Col8] using "Analysis/Output/TableCols2468.rtf", replace see
est store clear

*******************************************************************************
* REGRESSIONS CAN ALSO BE DONE BY CALLING A PROGRAM.
* I NAMED THE PROGRAM  "RegressionsProgram.ado" AND IS INSTALLED IN FOLDER
* C:\Users\cape8126\Desktop\AEE1Folder\Stata\ado
********************************************************************************

RegressionsProgram LWKLYWGE EDUC `YEARS' `CONTROLS' `AGEQUARTERS'

clear