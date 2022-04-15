clear all
use "/Users/raymond/Desktop/georgetown/CGSS/cgss2010_14.dta"
*narrow down
drop if a18!=1
drop if a21!=1
*voting behavior
gen vote = .
replace vote = 1 if a44 == 1
replace vote = 0 if a44 == 2
label variable vote "Voting in the past three years"
label define vote_label 0 "No" 1 "Yes"
label values vote vote_label
*political trust
gen level = .
replace level = 1 if d303 == 1
replace level = 2 if d303 == 2
replace level = 3 if d303 == 3
replace level = 4 if d303 == 4
replace level = 5 if d303 == 5
label variable level "Trust level"
label define level_label 1 "Not trustworthy at all" 2 "Not Trustworthy" 3 "Neutral" 4 "Trustworthy" 5 "Very trustworthy"
label values level level_label
*trust or not
gen trust = .
replace trust = 1 if level > 3 & level <= 5
replace trust = 0 if level <= 3
label variable trust "Trust in local government"
label define trust_label 0 "No" 1 "Yes"
label values trust trust_label
*b4(未来五年是否考虑到城镇定居）可以考虑做工具变量
gen livurban = .
replace livurban = 0 if b4 == 2
replace livurban = 1 if b4==1 | b4 == 3
*b9可做工具变量 短期回家
gen back =.
replace back =1 if b9==2
replace back=0 if b9==1|b9==3|b9==4|b9==5
*承包土地作为工具变量
replace b111=. if b111==-2|b111==-3
replace b112=. if b112==-2|b112==-3
replace b113=. if b113==-2|b113==-3
replace b114=. if b114==-2|b114==-3
gen subcontract = log(b111+b112+b113+b114)

gen sub =. 
replace sub=1 if a91==1
replace sub=0 if a91==2
*家庭农业人口
replace b22=. if b22==-1|b22==-2
gen big=.
replace big=1 if b22>2 & b22<=8
replace big=0 if b22<=2&b22>=0
*房产

*age
gen age =.
replace age = 2010-a3a
label variable age "Age"
*educ & prim_scho
gen educ=.
replace educ=1 if a7a==1
replace educ=2 if a7a==2|a7a==3
replace educ=3 if a7a==4
replace educ=4 if a7a==5|a7a==6|a7a==7|a7a==8
replace educ=5 if a7a==9|a7a==10|a7a==11|a7a==12
replace educ=6 if a7a==13
replace educ=7 if a7a==14
gen prim_scho =.
replace prim_scho = 0 if educ == 1 | educ==2
replace prim_scho = 1 if educ == 3 | educ==4 | educ==5 | educ==6 | educ==7
label variable prim_scho "Junior high school or above"
label define schol_label 0 "No" 1 "Yes"
label values prim_scho schol_label
*income
gen lg_inc =.
replace lg_inc=log(a8a+1) if a8a!=9999997&a8a!=9999998&a8a!=9999999
*ethnicity
gen Han = .
replace Han =1 if a4 == 1
replace Han=0 if a4 == 2 | a4==3| a4==4 |a4 == 5 | a4==6| a4==7|a4==8
label variable Han "Han people"
label define han_label 0 "No" 1 "Yes"
label values Han han_label
*male
gen male = .
replace male =1 if a2==1
replace male=0 if a2==2
label variable male "Gender"
label define gender_label 0 "Female" 1 "Male"
label values male gender_label
*marriage
gen mar = .
replace mar =1 if a69 ==3
replace mar=0 if a69==1 | a69==2|a69==4 |a69==5| a69==6
label variable mar "Married"
label define mar_label 0 "No" 1 "Yes"
label values mar mar_label
*health status
gen health =.
replace health =1 if a15 == 4|a15==5
replace health =0 if a15==1|a15==2|a15==3
label variable health "Perceived health status"
label define heal_label 0 "Not healthy" 1 "Healthy"
label values health heal_label
*status
gen below_aver = .
replace below_aver =1 if a64 == 1|a64==2
replace below_aver=0 if a64==3|a64==4|a64==5
label variable below_aver "Perceived economic status"
label define eco_label 0 "Equal to or above local average level" 1 "Below local average level"
label values below_aver eco_label
*internet
gen internet = .
replace internet=0 if a285==1
replace internet=1 if a285==2|a285==3|a285==4|a285==5
label variable internet "Internet usage in 2009"
label define inter_label 0 "Never used" 1 "Have used"
label values internet inter_label
*party
gen party = .
replace party = 1 if a10 == 1
replace party=0 if a10==2 | a10==3|a10==4
label variable party "CCP member"
label define par_label 0 "No" 1 "Yes"
label values party par_label
*religion
gen reli =.
replace reli=0 if a5==1
replace reli=1 if a5==11|a5==12|a5==13|a5==14|a5==15|a5==16|a5==21
label variable reli "Religious"
label define reli_label 0 "No" 1 "Yes"
label values reli reli_label
*read
gen read =.
replace read=0 if d111 == 1 | d111==2
replace read=1 if d111==3|d111==4|d111==5
label variable read "Not seldom reads newspapers, magazines, or books about current events in 2009"
label define read_label 0 "No" 1 "Yes"
label values read read_label
*submit
gen submit =.
replace submit=1 if d95==4|d95==5
replace submit=0 if d95==1|d95==2|d95==3
label variable submit "Ordinary people should be submissive to the authority"
label define sub_label 0 "No" 1 "Yes"
label values submit sub_label

*complicated
gen compli =.
replace compli=1 if d1001==4|d1001==5
replace compli=0 if d1001==1|d1001==2|d1001==3
label variable compli "Politics is complicated"
label define com_label 0 "No" 1 "Yes"
label values compli com_label
*no influence
gen no_influ=.
replace no_influ=1 if d1004==4|d1004==5
replace no_influ=0 if d1004==1|d1004==2|d1004==3
label variable no_influ "Ordinary people have no influence on politics"
label define inf_label 0 "No" 1 "Yes"
label values no_influ inf_label
*capable
gen cap =.
replace cap=1 if d1002==4|d1002==5
replace cap=0 if d1002==1|d1002==2|d1002==3
label variable cap "Competent to engage in politics"
label define cap_label 0 "No" 1 "Yes"
label values cap cap_label
*TV
gen tv=.
replace tv=1 if a284==4|a284==5
replace tv=0 if a284==1|a284==2|a284==3
label variable tv "Often watched TV in 2009"
label define tv_label 0 "No" 1 "Yes"
label values tv tv_label
*region
gen region=.
replace region=1 if s41==1|s41==4|s41==10|s41==12|s41==15|s41==17|s41==19|s41==20|s41==24
replace region=2 if s41==5|s41==31|s41==27
replace region=3 if s41==9|s41==11|s41==16|s41==18|s41==21|s41==22
replace region=4 if s41==2|s41==3|s41==6|s41==8|s41==13|s41==14|s41==23|s41==28|s41==29|s41==30|s41==26
*separate regions
tab region, gen(region1)
label variable region11 "East"
label variable region12 "Northeast"
label variable region13 "Center"
label variable region14 "West"
*生成交互项
gen vote_male= vote*male
gen vote_party= vote*party

*impute values to lg_inc
 impute lg_inc age prim_scho Han male mar health below_aver internet party reli read submit compli no_influ cap tv region12 region13 region14, gen(lg_inc_imputed)
 
*descriptive analysis
gen inc = exp(lg_inc_imputed)-1 //back to original stage and use this to do descriptive analysis
label variable inc "Total personal income in 2009"

*把missing value全部drop掉
drop if trust ==.
drop if vote ==.
drop if age ==.
drop if prim_scho ==.
drop if lg_inc_imputed ==.
drop if Han==. 
drop if male==. 
drop if mar==. 
drop if health==. 
drop if below_aver==.
drop if internet==.
drop if party==.
drop if reli==.
drop if read==.
drop if submit==. 
drop if compli==. 
drop if no_influ==. 
drop if cap==. 
drop if tv==. 
drop if region==.

*formal regressions
probit trust vote [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_male male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
***F test
test vote_male + vote=0
***margin
margin,dydx(*)
***再测一次f-test
test vote_male + vote =0
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_party male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
***F test
test vote_party + vote=0
***margin
margin,dydx(*)
***再测一次f-test
test vote_party + vote=0
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

*Appendix A
oprobit level i.vote [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 
oprobit level i.vote male age Han mar prim_scho [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 
oprobit level i.vote male age Han mar prim_scho lg_inc_imputed below_aver [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 
oprobit level i.vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 
oprobit level i.vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 
oprobit level i.vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
margins, dydx(vote) 

*Appendix B
probit trust vote, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv, robust
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_male male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv, robust
***F test
test vote_male + vote=0
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_party male age Han mar prim_scho lg_inc_imputed below_aver party submit cap compli no_influ i.region reli health read internet tv, robust
***F test
test vote_party + vote=0
***margin
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

*Appendix C
drop if lg_inc==.

probit trust vote [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc below_aver [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc below_aver party submit cap compli no_influ [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc below_aver party submit cap compli no_influ i.region [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote male age Han mar prim_scho lg_inc below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_male male age Han mar prim_scho lg_inc below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
***F test
test vote_male + vote=0
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred

probit trust vote vote_party male age Han mar prim_scho lg_inc below_aver party submit cap compli no_influ i.region reli health read internet tv [pw=WEIGHT], robust cluster(stratum)
***F test
test vote_party + vote=0
***margin
margin,dydx(*)
***correctness
predict phat
sum phat
gen binarypred = 0 if phat != .
replace binarypred = 1 if phat > .5 & phat != .
gen correctpred = 0 if phat != .
replace correctpred = 1 if binarypred == trust
tab correctpred if trust == 0
tab correctpred if trust == 1
drop phat binarypred correctpred
