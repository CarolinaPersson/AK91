******************************************************
**** QOB Table IV
**** 
**** Yuqiao Huang
**** Date: May 5th 2008
*****************************************************
****  TASK 2C.2 REMOVE DUPLICATION OF CODE AND DATA
****
**** NAME OF THIS FILE: Build/Code/QOBTableIV.do
**** INPUT:  			Build/Input/NEW7080.dta
**** OUTPUT: 			Analysis/Input/QOBcleanedData.dta
****
**** CAROLINA PERSSON
**** DATE: 2021-09-15
*****************************************************
local infile "Build/Input/NEW7080.dta"
local outfile "Analysis/Input/QOBcleanedData.dta"

use "`infile'"

rename v1 AGE
rename v2 AGEQ
rename v4 EDUC
rename v5 ENOCENT
rename v6 ESOCENT
rename v9 LWKLYWGE
rename v10 MARRIED
rename v11 MIDATL
rename v12 MT
rename v13 NEWENG
rename v16 CENSUS
rename v18 QOB
rename v19 RACE
rename v20 SMSA
rename v21 SOATL
rename v24 WNOCENT
rename v25 WSOCENT
rename v27 YOB
drop v8

gen COHORT=20.29
replace COHORT=30.39 if YOB<=39 & YOB >=30
replace COHORT=40.49 if YOB<=49 & YOB >=40

replace AGEQ=AGEQ-1900 if CENSUS==80
gen AGEQSQ= AGEQ*AGEQ

** Generate YOB dummies **********

forvalues i= 0 (1) 9 {
						gen byte YR2`i' = (YOB == 192`i' | YOB == 3`i' | YOB == 4`i') if !missing(YOB) 
					}
** Generate QOB dummies ***********

forvalues i= 1 (1) 4 {
						gen byte QTR`i' = QOB == `i'
					}

** Generate YOB*QOB dummies ********

forvalues j = 1 (1) 3 {
						forvalues i = 20 (1) 29 {
								gen byte QTR`j'`i' = QTR`j' * YR`i'
						}
					}

save `outfile', replace

clear
*****************************************************