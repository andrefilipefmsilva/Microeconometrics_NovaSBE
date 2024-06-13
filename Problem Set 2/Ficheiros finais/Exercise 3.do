set more off
* Data is already in long format


//3b

bysort mode_travel: sum gc ttme hinc
*asdoc bysort mode_travel: sum gc ttme hinc, save(exercise1b.doc)


//3c
sort id

list in 1/4

asclogit choice gc ttme, case(id) alternatives(mode_travel) casevars(hinc) basealternative(3)
est store clogit1


//3d

predict pasclogit, pr

table mode_travel, contents(mean pasclogit)
tab choicetravel

//3e
est restore clogit1
estat mfx, varlist(hinc) at(mean)

//3f

drop pasclogit
drop _est_clogit1

reshape wide choice ttme gc hinc choicetravel, i(id) j(mode_travel)

mlogit choicetravel1 hinc1, baseoutcome(3)

mlogit choicetravel1 hinc1, rr baseoutcome(3)

//3g

qui mlogit choicetravel1 hinc1, baseoutcome(3)

est store mlogit3g1

qui mlogit choicetravel1 hinc1 if choicetravel1!=1, baseoutcome(3)

est store mlogit3g2

qui suest mlogit3g1 mlogit3g2, noomitted

test ([mlogit3g1_BUS=mlogit3g2_BUS]) ([mlogit3g1_TRAIN=mlogit3g2_TRAIN])


**Alternative test 1**

qui mlogit choicetravel1 hinc1, baseoutcome(3)


est store mlogit3g3

qui mlogit choicetravel1 hinc1 if choicetravel1!=4, baseoutcome(3)

est store mlogit3g4

qui suest mlogit3g3 mlogit3g4, noomitted

test ([mlogit3g3_AIR=mlogit3g4_AIR]) ([mlogit3g3_BUS=mlogit3g4_BUS])

**Alternative test 2**

qui mlogit choicetravel1 hinc1, baseoutcome(3)

**-findit spost13-** then install spots13.ado

mlogtest, hausman
