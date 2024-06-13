//Exercise 2a

twoway (kdensity hrwage if alcoholic==0) (kdensity hrwage if alcoholic==1), legend(row(1) order(1 2) lab(1 "Non-Alcohol abuser") lab(2 "Alcohol Abuser")) xtitle("Hourly Wage")
twoway (kdensity hrwage if alcoholic==0) (kdensity hrwage if alcoholic==1) if hrwage < 50, legend(row(1) order(1 2) lab(1 "Non-Alcohol abuser") lab(2 "Alcohol Abuser")) xtitle("Hourly Wage")

//Exercise 2b
tab alcoholic

tabstat perday sex race afqtrev depression health povst urate faminc, by(alcoholic) nototal
ttest perday, by(alcoholic)
ttest sex , by(alcoholic)
ttest race , by(alcoholic)
ttest afqtrev , by(alcoholic)
ttest depression , by(alcoholic)
ttest health , by(alcoholic)
ttest povst , by(alcoholic)
ttest urate , by(alcoholic)
ttest faminc, by(alcoholic)

//Exercise 2c

logit alcoholic sex race afqtrev depression DMISS_depression health DMISS_health povst DMISS_povst urate DMISS_urate faminc DMISS_faminc 
predict pscore1, p

psgraph, treated(alcoholic) pscore(pscore1)
twoway (kdensity pscore1 if alcoholic==0) (kdensity pscore1 if alcoholic==1), legend(row(1) order(1 2) lab(1 "Non-Alcoholic") lab(2 "Alcoholic"))

//Exercise 2d

psmatch2 alcoholic, radius caliper(0.0001) outcome(hrwage) pscore(pscore1)
bootstrap: psmatch2 alcoholic, radius caliper(0.0001) outcome(hrwage) pscore(pscore1)

pstest sex race afqtrev depression health povst urate faminc 

//Exercise 2e
g att_psw=hrwage*(alcoholic-pscore1)/(1-pscore1) 
sort alcoholic 
egen N1=total(alcoholic) 
egen nominator=total(att_psw) 
scalar ATT_psw=nominator/N1
gen ATT_psw=nominator/N1

g ate_psw=hrwage*(alcoholic-pscore1)/(pscore1*(1-pscore1))
sort alcoholic
gen N=4707
capture drop nominator
egen nominator=total(ate_psw) 
scalar ATE_psw=nominator/N
gen ATE_psw=nominator/N

tabstat ATE_psw ATT_psw
