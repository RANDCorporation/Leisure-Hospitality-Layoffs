# RAND Commentary – Leisure & Hospitality Layoffs
ED & Labor Unit

This GitHub repository supports a RAND Commentary written by Kathryn Edwards and can be found at the following URL: https://www.rand.org/blog/2020/09/for-leisure-and-hospitality-weak-recovery-still-looks-like-recession.html

#### -- Project Status: Completed.

## Project Description
Using the CPS Basic Monthly Sample of the Current Population Survey (CPS) from January to July, we count the number of workers in the leisure & hospitality industry in month t who are on temporary layoff and what employment state they are in month t+1. We also update a previous commentary on overall transitions to include new data from the July 2020 CPS.

### Methods Used
* Descriptive statistics

### Technologies
* Stata 15

## Getting Started

1. Download the three Do files in this repository.

2. Download data from the cps.ipums.org (see “Analysis” do file for list of variables).
    
3. Run “Format CPS extract.do”

4. Run “Temp_Layoffs_in_Leisure_Hospitality.do” to generate the transition statistics used in the commentary.

### Other notes

This commentary builds on a previous commentary by adding data from the July 2020 CPS and looking at a particular subset of workers in the leisure & hospitality industries. For more details on our methodology, please see the README for this earlier commentary, which can be found at https://github.com/RANDCorporation/Temporary-Layoff-Transitions.

Our estimate of temporary layoffs does not cohere with the BLS estimate in the Employment Situation, Table A11. The BLS defines temporary layoff as workers with a recall date to their old job. These workers do not have to be searching for work (https://www.bls.gov/cps/definitions.htm#joblosers). We add to this individuals who are potentially misclassified, which was a key issue in the early months of the recession: employed but not at work for other reasons. In addition, the use of both harmonized and unharmonized variables in IPUMS creates some definitional issues; there are workers who answer that they have a recall data with their employer (uh_lay6m_b1 or uh_laydt_b1) who are also classified as not in the labor force and therefore not unemployed. This is about 15% of positive recall data respondents, and they are not included in our definition of temporary layoff.

Data extract from the CPS downloaded on August 1, 2020 by Daniel Schwam.

Reference(s): 

1. Sarah Flood, Miriam King, Renae Rodgers, Steven Ruggles and J. Robert Warren. Integrated Public Use Microdata Series, Current Population Survey: Version 7.0 [dataset]. Minneapolis, MN: IPUMS, 2020. https://doi.org/10.18128/D030.V7.0

2. Bauer, Laren, Wendy Edelberg, Jimmy O'Donnell, and Jay Shambaugh (2020). "Who are the potentially misclassified in the Employment Report?" Brookings. Published online on June 30, 2020. https://www.brookings.edu/blog/up-front/2020/06/30/who-are-the-potentially-misclassified-in-the-employment-report/#cancel

3. Edwards, Kathryn. “What Unemployment Statistics Obscure About Temporary Layoffs,” TheRANDBlog, published online 17 August 2020. URL: https://www.rand.org/blog/2020/08/what-unemployment-statistics-obscure-about-temporary-layoffs.html.

4. Schwam, Daniel, and Kathryn Edwards, “Within Unemployment Transitions in the Current Population Survey,” GitHub, RAND Corporation Repository, last updated 30 September 2020. As of September 30, 2020: https://github.com/RANDCorporation/Temporary-Layoff-Transitions.

## Project Members:

Kathryn Edwards (kathryne@rand.org) and Daniel Schwam (dschwam@rand.org)

* Feel free to contact team leads with any questions or if you are interested in contributing!

## Suggested Citation for this repository: 

Schwam, Daniel, and Kathryn Edwards, "For Leisure and Hospitality, Weak Recovery Still Looks Like Recession," GitHub, RAND Corporation Repository, last updated 1 October 2020. As of October 1, 2020: https://github.com/RANDCorporation/Leisure-Hospitality-Layoffs
