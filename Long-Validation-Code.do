*******************************************************
* This do file contains validation code for linked CPS
* files in long format. For details see below
*
* Written by the IPUMS-CPS team
* 31 May 2018
*******************************************************

****************************************************************************************************************
* Source
* https://cps.ipums.org/cps/resources/workshop_materials/validate_wide.txt
****************************************************************************************************************

/***************************************************************************************************************
This validation do file will validate links based on AGE, SEX, and RACE for any linked long file where the
following assumptions are met:
1. All nonlinks based on CPSIDP are dropped before validation
2. Only matches across all observations of AGE, SEX, and RACE are considered valid

The user must specify the number of expected observations as an argument to the do file (do validate_long.txt 2). 
If a user wishes to add other validation variables to the basic AGE, SEX, and RACE, these may be added
as an argument as well (i.e. do validate_wide_test.txt 2 marst  - this will validate a linked file with two time 
observations on AGE, SEX, RACE, and MARST).

If you want to use this validation code, no changes are required. Simply refer to this do file from within another
do file. For example, if you want to validate links across two time points:
	do validate_long.txt 2
******************************************************************************************************************/

forval num = 2/8 {
	local args `0'
	local expected_obs = `num'
	local not `expected_obs'
	local _validation_vars: list args-not
	local simple_validation_vars sex race `_validation_vars'
	di "`expected_obs'"
	di "`simple_validation_vars'"


	/********************************************************************************************************
	Users should  not need to alter anything below here unless they wish to tweak the validation requirements
	********************************************************************************************************/

	/*Step 0 -- confirm number of times individuals will be observed in data has been set by user. */

	//make sure a valid number of observations has either been derived or specified
	if missing("`expected_obs'"){
		di "!!!!!Please specify the number of time points you wish to validate."
	}

	//now check to make sure that it is between 2 and 8
	if `expected_obs' < 2 | `expected_obs' > 8 {
		di "!!!!!Number of expected observations must be between 2 and 8! Value is currently `expected_obs' (years * months). Please set above in 'local expected_obs'!!!!!"
		exit
	}

	di "`expected_obs'"
	di "`simple_validation_vars'"
	/*validate long based on sex and race*/

	/*Step 1a -- start with the easy vars -- SEX and RACE*/

	sort cpsidp year month

	foreach var in `simple_validation_vars' mish {
		bysort cpsidp: gen `var'_time_1 = `var'[1]
		gen `var'_match = 1 if `var' == `var'_time_1
		replace `var'_match = 0 if `var'_match==.
		egen `var'_total_match = total(`var'_match),by(cpsidp)
	}


	/*Step 1b -- now onto AGE which is more complicated*/

	sort cpsidp year month
	bysort cpsidp : gen age_time_1 = age[1] 

	gen allowable_age_diff=.

		/*Rule 1: allow a one-year age increase within months 1-4 and 5-8
		if mish1 < 4 and the sum of mish1 and num of obs <= 4  or mish1 is between 5 and 8,
		then 8-month break not in window of observation and plus/minus one year will suffice*/
		
		replace allowable_age_diff = 1 if ((mish_time_1 >= 1 & mish_time_1 < 4) & (mish_time_1 + `expected_obs' - 1 <= 4)) | ///
					  (mish_time_1 >= 5 & mish_time_1 < 8)

		/*Rule 2: if mish1 == 4 | mish1+4 > 4, then 8-month break needs to be accounted for*/
		replace allowable_age_diff = 2 if allowable_age_diff == . & (mish_time_1 == 4 | mish_time_1+4 > 4)

		/*Rule 3: account for age topcodes 80 85 */
		replace allowable_age_diff = 5 if (allowable_age_diff == 1 | allowable_age_diff == 2) & age_time_1 == 80

	//in link of adjacent months (as this test is), we would expect allowable_age_diff to be all 1s and 5s
	tab allowable_age_diff


	/*Create the "age match" variable*/
	gen age_match = (age==age_time_1 | (age > age_time_1 & age <= age_time_1+allowable_age_diff))
	egen age_total_match = total(age_match),by(cpsidp)


	/*Create an "all match" variable*/
	gen all_match = (age_total_match==`expected_obs' & sex_total_match==`expected_obs' & race_total_match==`expected_obs')
	count if all_match==1


	/*Step 2 -- count the number of validation vars match across all observations*/
	sum all_match age_total_match sex_total_match race_total_match

	sort cpsidp year month
	if `num' == 2 {
		by cpsidp: gen n = _n
		by cpsidp: gen N = _N
	}
	tab N all_match
	
	ren all_match all_match`num'
	drop age_* sex_* race_* allowable_age_diff age_time_1 mish_*
	
	di "`num' complete"

}
egen matched_keep = rowtotal(all_match*)
tab matched_keep, m

*disp "your next step might be to **keep if all_match==1**"
