xtset id year 

// Exercise 1b
xtdescribe

gen hour_wage= wgsal / hrswrk
gen loghrwage=ln(hour_wage)
summ loghrwage
hist loghrwage

xttab drnk6m

// Exercise 1e
gen faminc_1 = faminc/1000
gen logfaminc = ln(faminc_1)

xtreg loghrwage i.drnk6m health logfaminc povst urate, fe

// Exercise 1f

xtreg loghrwage i.drnk6m#sex health logfaminc povst urate, fe
