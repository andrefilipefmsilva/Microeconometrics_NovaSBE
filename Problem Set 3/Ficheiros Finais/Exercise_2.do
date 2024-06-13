set more off

******EXERCISE 2.1***********
asdoc summ, by(treat), save(summary.doc), replace
//Here we are presenting summary statistics, seperated between control and treatment group


asdoc ttest age, by(treat)  save(age.doc), replace
asdoc ttest educ, by(treat) save(educ.doc), replace
asdoc ttest sex, by(treat) save(gender.doc), replace
//Here we are testing whether there are significant differences between treatment 
//and control groups for the age, educ and gender characteristics.

****EXERCISE 2.2*****
//Due to the suspect  of clusters in communities, we will do both the normal ttests and cluster-adjusted ttests

by cluster: summ electric pipwater distcapital

//Cluster-adjusted t-tests
*ssc install cltest
clttest electric, by(treat) cluster(cluster)
clttest pipwater, by(treat) cluster(cluster)
clttest distcapital, by(treat) cluster(cluster)
//Here we are testing whether there are significant differences between treatment
//and control groups for the electric, pipwater and distcapital characteristics,
//but taking into account possible clustering effects. 


//Normal ttests
asdoc ttest electric, by(treat) save(electric.doc), replace
asdoc ttest pipwater, by(treat) save(pipwater.doc), replace
asdoc ttest distcapital, by(treat) save(distcapital.doc), replace
//Here we are testing whether there are significant differences between treatment
//and control groups for the electric, pipwater and distcapital characteristics.

***EXERCISE 2.4********
asdoc reg primary treat if ycohort==1, save(regression1.doc), replace


***EXERCISE 2.5********

asdoc reg primary treat distcapital pipwater fhere94 mhere94 num2schols if ycohort==1, save(reg2.doc), replace



***EXERCISE 2.6********
gen prim_y=.
replace prim_y=primary if ycohort==1
gen prim_o=.
replace prim_o=primary if ocohort==1

ttest prim_y, by(treat)
ttest prim_o, by(treat)

***EXERCISE 2.7********
asdoc reg primary treat ycohort ycohortxtreat, save(regr3.doc), replace

