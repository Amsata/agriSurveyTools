/* START HELP FILE
title[a command to setup working directory and necessary files and folder for anonymization]

desc[
 {cmd:generateODT} generate multi-dimentional statisticial tables destined to open Data Africa plateform
 or for other potential use.
] 

opt[varlist() list of of variables (domains) over which estimates will be creatd.]
opt[marginlabels() specify the labels of margins of variables in varlist.]
opt[parameter() parameter to be estimated in the domains (total, mean or ratio).]
opt[variable() variable the value of which will be used to generate the specified parameter in 'parameter'.]
opt[conditionals() eliminate tuples (of dimensions in varlist) according to specified conditions.]
opt[indicatorname() a comprehensive and informative label of the indicator generated with variables specified in 'variable'.]
opt[units() units of the parameter generated with variable in 'variable'.]
opt[svySE() units of the parameter generated with variable in 'variable'.]
opt[subpop() {cmd:(}[{varname}] [{it:{help if}}]{cmd:)}}identify a subpopulation]



opt2[varlist() list of of variables (domains) over which estimates will be creatd.]
opt2[marginlabels() specify the labels of margins of variables in varlist.]
opt2[parameter() parameter to be estimated in the domains (total, mean or ratio).]
opt2[variable() variable the value of which will be used to generate the specified parameter in 'parameter'.]
opt2[conditionals() eliminate tuples (of dimensions in varlist) according to specified conditions.]
opt2[indicatorname() a comprehensive and informative label of the indicator generated with variables specified in 'variable'.]
opt2[units() units of the parameter generated with variable in 'variable'.]
opt2[svySE() units of the parameter generated with variable in 'variable'.]
opt2[subpop() {cmd:(}[{varname}] [{it:{help if}}]{cmd:)}}identify a subpopulation	]


example[
 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("ratio") var((I3_n/I3_d)) ///
	indicatorname("Women entrepreneurship index") ///
	units("")}
	
	 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("mean") var(hh_member) ///
	indicatorname("Average households size") ///
	units("people")}
	
		 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("total") var(production) ///
	indicatorname("Crop production") ///
	units("MT")}
 ]
 
 
author[Amsata Niang]
institute[Food and Agriculture Organization of the United Nations FAO]
email[amsata_niang@yahoo.fr]


freetext[

]

references[

]

seealso[

]

END HELP FILE */

*capture program drop svyEstimate
program define svyEstimate
		
	syntax [varlist] ,PARAMeter(string) VARiable(string asis) ///
	[conditionals(string asis) svySE(string) subpop(string asis) alldim(string asis) ]

		quietly {
		************************************************************************
		*** Generate estimate over dimension the given dimension combination ***
		************************************************************************
		
		if("`alldim'"=="yes") svy: `parameter' `variable'
		else svy, over(`varlist'): `parameter' `variable'
		qui return list
		matrix define T= r(table)'	
		qui ereturn list
		matrix define n_subpop= e(_N)'	
		matrix define N_subpop= e(_N_subp)'	

		mat_to_ds T		   
		tempfile res_estimation
		save `res_estimation', replace
		
		mat_to_ds n_subpop	   
		tempfile dataset_n_obs
		order rownames
		unab all_vars: *
		rename `:word 2 of `all_vars'' n_Obs // or word(`all_vars', 1)
		save `dataset_n_obs', replace
		
		mat_to_ds N_subpop	   
		tempfile dataset_N_subpop
		order rownames
		unab all_vars: *
		rename `:word 2 of `all_vars'' N_subPop // or word(`all_vars', 1)
		save `dataset_N_subpop', replace
		
		* Estimating coefficient of variation
		estat cv
		matrix define CV = r(cv)'
		mat_to_ds CV
		*renaming the variable to CV
		unab all_vars: *
		rename `:word 1 of `all_vars'' CV // or word(`all_vars', 1)
		merge 1:1 rownames using `res_estimation', nogen
		merge 1:1 rownames using `dataset_n_obs', nogen
		merge 1:1 rownames using `dataset_N_subpop', nogen

		*break 498
		**************************************************************************
		*** Extract correct dimension name and merging with sample frequencies (possible from Stata 17 ***
		*************************************************************************
		if("`alldim'"!="yes") {
		split rownames, p(@)
		capture drop Indicator
		rename rownames1 Indicator
		replace Indicator= regexr(Indicator, "^c.", "")
		rename rownames2 dimension
		split dimension, p(#)
		local c : word count `varlist'
		forvalues i=1/`c' {
			local v "`:word `i' of `varlist''"
			rename dimension`i' `v'
			replace `v' = regexs(1) if regexm(`v', "([0-9]+)")
			cap destring `v', replace
		}
		drop dimension
		}
		} //quietly
	
end

*include controle in case of hierarchical geographic variable, indication=> to many zero/missing value in sample frequencies