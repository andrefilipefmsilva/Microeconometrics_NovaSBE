// Exercise 2


//2a)

sum nettfa inc age e401k

hist nettfa

//2b)

reg nettfa inc age agesq e401k


//2c)

//H0: No Heteroskedasticity 
//H1: Heteroskedasticity 

imtest, white

//2d)

sqreg nettfa inc age agesq e401k, nolog q(0.1 0.25 0.5 0.75 0.9) reps(40)


//2e)

sqreg nettfa e401k, nolog q(0.1 0.25 0.5 0.75 0.9) reps(40)

