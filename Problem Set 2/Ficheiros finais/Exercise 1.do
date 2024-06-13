//Exercise 1

//1a

reg inlf nwifeinc educ exper age kidslt6 kidsge6, robust

//1b

probit inlf nwifeinc educ exper age kidslt6 kidsge6
margins, dydx(*)

logit inlf nwifeinc educ exper age kidslt6 kidsge6
margins, dydx(*)

//1c

qui reg inlf nwifeinc educ exper age kidslt6 kidsge6, robust
est store LPM

qui probit inlf nwifeinc educ exper age kidslt6 kidsge6
margins, dydx(*) post
est store probmarg


qui logit inlf nwifeinc educ exper age kidslt6 kidsge6
margins, dydx(*) post
est store logtmarg


esttab LPM probmarg logtmarg, not b(%7.6f) star mtitles("LPM" "Marg Probit" "Marg Logit") nogaps nonumb nocons

//1d

**kidslt6==0**

qui probit inlf nwifeinc educ exper age kidsge6 kidslt6
predict pprob_0 if kidslt6==0, pr

est restore LPM
predict pols_0 if kidslt6==0, xb

summarize pols_0 pprob_0

**kidslt6==1**
qui probit inlf nwifeinc educ exper age kidsge6 kidslt6
predict pprob_1 if kidslt6==1, pr

est restore LPM
predict pols_1 if kidslt6==1, xb

summarize pols_1 pprob_1

**kidslt6==2**
qui probit inlf nwifeinc educ exper age kidsge6 kidslt6
predict pprob_2 if kidslt6==2, pr

est restore LPM
predict pols_2 if kidslt6==2, xb

summarize pols_2 pprob_2

**all in a table**

summarize pols_0 pprob_0 pols_1 pprob_1 pols_2 pprob_2


//1e

sum kidsge6 kidslt6


qui probit inlf nwifeinc educ exper age kidsge6 i.kidslt6
margins i.kidslt6, atmeans
marginsplot

graph export probit1.png, replace


qui logit inlf nwifeinc educ exper age kidsge6 i.kidslt6
margins i.kidslt6, atmeans
marginsplot

graph export logit1.png, replace
