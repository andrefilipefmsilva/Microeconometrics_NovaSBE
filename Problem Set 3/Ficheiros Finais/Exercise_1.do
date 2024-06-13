// Exercise 1c

xtset nr year

xttab year
egen nobs = count(year), by(nr) 
xtdescribe
** to check if panel is balanced. We see that it is perfectly balanced.

reg lwage d81 d82 d83 d84 d85 d86 d87 exper expersq married union black hisp educ, vce(cluster nr)

test union

// Exercise 1d

regress D.(lwage d82 d83 d84 d85 d86 d87 exper expersq married union black hisp educ), vce(cluster nr) noconstant

//Exercise 1f

*Within Estimator
xtreg lwage d81 d82 d83 d84 d85 d86 d87 exper expersq married union, fe vce(cluster nr)


*Random Effects Estimator
xtreg lwage d81 d82 d83 d84 d85 d86 d87 exper expersq married union, re vce(cluster nr) theta


//Exercise 1g
xtreg lwage d81 d82 d83 d84 d85 d86 d87 exper expersq married union, fe
est store FE

xtreg lwage d81 d82 d83 d84 d85 d86 d87 exper expersq married union, re theta
est store RE

hausman FE RE, sigmamore
