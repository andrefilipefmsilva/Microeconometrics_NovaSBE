//Exercise 1a

gen marrfem= married*female

label variable marrfem "married_female"

reg lwage exper expersq married female marrfem

est store OLS1

//Exercise 1c

test exper expersq

//Exercise 1d

estat imtest, white


//Exercise 1f (Alternative Solution)

quietly regress lwage exper expersq married female marrfem
predict uhat, resid
gen luhat2 = ln(uhat*uhat)
regress luhat2 exper expersq married female marrfem //regressão auxiliar do ln(erro^2) sobre os X's
predict vhat, resid //residuo da regressão auxiliar
gen evhat = exp(vhat) //exp do residuo da regressão auxiliar

**Weigthed variables below, para aplicar como o WLS
gen w=1/(evhat)^0.5
gen wlwage = lwage*w
gen wexper = exper*w
gen wexpersq = expersq*w
gen wmarried = married*w
gen wfemale = female*w
gen wmarrfem = marrfem*w

**FGLS model
regress wlwage wexper wexpersq wmarried wfemale wmarrfem


//Exercise 1f (Class Solution)

reg lwage exper expersq female married marrfem

predict double that, resid

gen double thatsq = that^2

gen uno = 1

gen abse =abs(exper)

gen absesq =abs(expersq)

gen absfemale =abs(female)

gen absmarried =abs(married)

gen absmarfem =abs(marrfem)

qui nl(thatsq= exp({xb: abse absesq absfemale absmarried absmarfem uno} )), nolog

predict double varu, yhat

qui reg lwage exper expersq female married marrfem [aweight = 1/varu]

estat hettest exper expersq female married marrfem, mtest


//Exercise 1g

gen newvar = 2*exper + married

reg lwage exper newvar female



//EXERCISE 2

 summarize AGE EDUC LWAGE MARRIED CENSUS QOB RACE SMSA YOB AGESQ

 // a

mean(EDUC) if QOB == 1 & YOB == 30| YOB == 31 | YOB == 32 | YOB == 33 | YOB == 34 | YOB== 35 | YOB == 36| YOB == 37 |YOB == 38 | YOB== 39 
mean(EDUC) if QOB == 2 & YOB == 30| YOB == 31 | YOB == 32 | YOB == 33 | YOB == 34 | YOB== 35 | YOB == 36| YOB == 37 |YOB == 38 | YOB== 39 
mean(EDUC) if QOB == 3 & YOB == 30| YOB == 31 | YOB == 32 | YOB == 33 | YOB == 34 | YOB== 35 | YOB == 36| YOB == 37 |YOB == 38 | YOB== 39 
mean(EDUC) if QOB == 4 & YOB == 30| YOB == 31 | YOB == 32 | YOB == 33 | YOB == 34 | YOB== 35 | YOB == 36| YOB == 37 |YOB == 38 | YOB== 39 
 
mean(EDUC) if QOB == 1 & YOB == 40| YOB == 41 | YOB == 42 | YOB == 43 | YOB == 44 | YOB== 45 | YOB == 46| YOB == 47 |YOB == 48 | YOB== 49 
mean(EDUC) if QOB == 2 & YOB == 40| YOB == 41 | YOB == 42 | YOB == 43 | YOB == 44 | YOB== 45 | YOB == 46| YOB == 47 |YOB == 48 | YOB== 49  
mean(EDUC) if QOB == 3 & YOB == 40| YOB == 41 | YOB == 42 | YOB == 43 | YOB == 44 | YOB== 45 | YOB == 46| YOB == 47 |YOB == 48 | YOB== 49  
mean(EDUC) if QOB == 4 & YOB == 40| YOB == 41 | YOB == 42 | YOB == 43 | YOB == 44 | YOB== 45 | YOB == 46| YOB == 47 |YOB == 48 | YOB== 49 

// b
keep if YOB == 30| YOB == 31 | YOB == 32 | YOB == 33 | YOB == 34 | YOB== 35 | YOB == 36| YOB == 37 |YOB == 38 | YOB== 39 

reg LWAGE EDUC AGE AGESQ

// d

gen first_qob = QOB==1

ssc install ranktest

ssc install ivreg2

ivreg2 LWAGE (EDUC = first_qob)

reg LWAGE EDUC

// e i)

gen z1= QOB==1
gen z2= QOB==2
gen z3= QOB==3

reg EDUC z1 z2 z3 AGE AGESQ RACE MARRIED SMSA


// e ii)

test z1 z2 z3 //relevance restriction

//Exogeneity Sargan test below
qui ivreg LWAGE (EDUC=z1 z2 z3) AGE AGESQ RACE MARRIED SMSA //regression of lwage on all exogenous variables
predict vhat_iv, res //get the error
reg vhat_iv z1 z2 z3 AGE AGESQ RACE MARRIED SMSA //regress the error on all the exogenous variables
ereturn list

scalar nR2=e(N)*e(r2) //test statistic
di nR2

scalar pvalOverid=chi2tail(2,nR2) //2=number of instruments - number of endog variables
di pvalOverid

// e iii)

reg LWAGE EDUC AGE AGESQ RACE MARRIED SMSA 
est store OLS


//2SLS
reg EDUC z1 z2 z3 AGE AGESQ RACE MARRIED SMSA //first stage
predict EDUCHAT
reg LWAGE EDUCHAT AGE AGESQ RACE MARRIED SMSA //second stage
est store sls

ssc install estout
estout OLS sls
