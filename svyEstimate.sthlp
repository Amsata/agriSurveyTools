{smcl}
{* *! version 1.0 24 Nov 2024}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "svyEstimate##syntax"}{...}
{viewerjumpto "Description" "svyEstimate##description"}{...}
{viewerjumpto "Options" "svyEstimate##options"}{...}
{viewerjumpto "Remarks" "svyEstimate##remarks"}{...}
{viewerjumpto "Examples" "svyEstimate##examples"}{...}
{title:Title}
{phang}
{bf:svyEstimate} {hline 2} a command to setup working directory and necessary files and folder for anonymization

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:svyEstimate}
[{help varlist}]
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}

{syntab:Required }

{synopt:{opt param:eter(string)}}  parameter to be estimated in the domains (total, mean or ratio). {p_end}

{synopt:{opt var:iable(string asis)}}  variable the value of which will be used to generate the specified parameter in 'parameter'. {p_end}

{syntab:Optional}
{synopt:{opt conditionals(string asis)}} eliminate tuples (of dimensions in varlist) according to specified conditions.

{synopt:{opt :svySE(string)}}  

{synopt:{opt subpop(string asis)}} {cmd:(}[{varname}

{synopt:{opt alldim(string asis)}}  

{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}
{pstd}

{pstd}
 {cmd:generateODT} generate multi-dimentional statisticial tables destined to open Data Africa plateform
 or for other potential use.

{marker options}{...}
{title:Options}
{dlgtab:Main}

{phang}
{opt param:eter(string)} parameter to be estimated in the domains (total, mean or ratio).

{phang}
{opt var:iable(string asis)} variable the value of which will be used to generate the specified parameter in 'parameter'.

{phang}
{opt conditionals(string asis)} eliminate tuples (of dimensions in varlist) according to specified conditions.

{phang}
{opt :svySE(string)}  

{phang}
{opt subpop(string asis)} {cmd:(}[{varname}

{phang}
{opt alldim(string asis)}  



{marker examples}{...}
{title:Examples}

 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("ratio") var((I3_n/I3_d)) ///
	indicatorname("Women entrepreneurship index") ///
	units("")}
	
	 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("mean") var(hh_member) ///
	indicatorname("Average households size") ///
	units("people")}
	
		 {stata generateODT Region sex ,marginlabels("All households" "Wakanda") param("total") var(production) ///
	indicatorname("Crop production") ///
	units("MT")}


{title:References}
{pstd}

{pstd}

{pstd}

{pstd}

{pstd}


{title:Author}
{p}

Amsata Niang, Food and Agriculture Organization of the United Nations FAO.

Email {browse "mailto:amsata_niang@yahoo.fr":amsata_niang@yahoo.fr}



{title:See Also}
Related commands:



