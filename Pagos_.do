global root "/Users/sergioparra/Downloads/Tesoreria"
global bases "$root/Bases"

*************************************************
*** Padrón
*************************************************

use "$root/padron_impuesto_sobre_tenencia_o_uso_de_vehiculos_2019asdasd.dta", clear
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

destring subsidio tenencia derechos, replace
destring total, replace
destring modelo, replace
save "$root/padronlimpio.dta", replace
use "$root/padronlimpio.dta", clear

*************************************************
*** Pagos 2019
*************************************************
global p2019 "$root/2019"

//Pagos
use "$p2019/2019.dta", clear
append using $p2019/abril, force 
duplicates drop lineacaptura, force
gen pago2019 = 1 if perini == 2019
drop marca
drop if perini != 2019
save "$p2019/pagos2019_sucio", replace

use "$root/padronlimpio.dta", clear
merge 1:m nplaca using "$p2019/pagos2019_sucio" 
replace pago2019 = 0 if pago2019 == . 
gen _merge2019 = _merge
save "$bases/padron_pagos_2019", replace 
use "$bases/padron_pagos_2019", clear
drop if _merge!=2
gen unmatched=1
save $p2019/pagos_unmatched, replace

//Altas
use "$altas/aux2019.dta", clear

gen serie = ctaoptp + convenio 
duplicates report serie
duplicates drop serie, force
gen pago2019 = 1

save "$altas/altas2019", replace

use "$altas/altas2019", clear

global p2019 "$root/2019"
use "$bases/padron_pagos_2019.dta",clear

duplicates drop serie, force
drop _merge
merge 1:1 serie using $altas/altas2019, force
save "$bases/padron_pagos_2019.dta", replace

append using $p2019/pagos_unmatched, force
save "$bases/padron_pagos_2019.dta", replace
use "$bases/padron_pagos_2019.dta", clear


*************************************************
*** Pagos 2018
*************************************************

global p2018 "$root/2018"

//Pagos en 2018
use "$p2018/2018.dta", clear
drop if perini == "MLH6020"
destring perini, replace
gen pago2018 = 1 if perini == 2018
drop marca
drop if perini != 2018
save "$p2018/pagos2018_sucio", replace

//Pagos en 2019
use "$p2019/2019.dta", clear
gen pago2018 = 1 if perini == 2018
drop marca
drop if perini != 2018
append using "$p2018/pagos2018_sucio", force
save "$p2018/pagos2018_sucio", replace

use "$root/padronlimpio.dta", clear

merge 1:m nplaca using "$p2018/pagos2018_sucio" 
save "$bases/padron_pagos_2018", replace 
use "$bases/padron_pagos_2018", clear
drop if _merge!=2
save $p2018/pagos_unmatched, replace

//Altas
use "$altas/aux2018.dta", clear

gen serie = ctaoptp + convenio 
duplicates report serie
duplicates drop serie, force
gen pago2018 = 1

save "$altas/altas2018", replace

use "$altas/altas2018", clear

global p2018 "$root/2018"
use "$bases/padron_pagos_2018.dta",clear

duplicates drop serie, force
drop _merge
merge 1:1 serie using $altas/altas2018, force
save "$bases/padron_pagos_2018.dta", replace

append using $p2018/pagos_unmatched, force
save "$bases/padron_pagos_2018.dta", replace

*************************************************
*** Pagos 2017
*************************************************

global p2017 "$root/2017"

//Pagos en 2017
use "$p2017/2017.dta", clear
gen pago2017 = 1 if perini == 2017
drop marca
drop if perini != 2017
save "$p2017/pagos2017_sucio", replace

//Pagos en 2018
use "$p2018/2018.dta", clear
drop if perini == "MLH6020"
destring perini, replace
gen pago2017 = 1 if perini == 2017
drop marca
drop if perini != 2017
append using "$p2017/pagos2017_sucio", force
save "$p2017/pagos2017_sucio", replace

//Pagos en 2019
use "$p2019/2019.dta", clear
gen pago2017 = 1 if perini == 2017
drop marca
drop if perini != 2017
append using "$p2017/pagos2017_sucio", force
save "$p2017/pagos2017_sucio", replace

use "$root/padronlimpio.dta", clear
merge 1:m nplaca using "$p2017/pagos2017_sucio" 
save "$bases/padron_pagos_2017", replace 
use "$bases/padron_pagos_2017", clear
drop if _merge!=2
save $p2017/pagos_unmatched, replace

//Altas
use "$altas/aux2017.dta", clear

gen serie = ctaoptp + convenio 
duplicates report serie
duplicates drop serie, force
gen pago2017 = 1

save "$altas/altas2017", replace

use "$altas/altas2017", clear

global p2017 "$root/2017"
use "$bases/padron_pagos_2017.dta",clear

duplicates drop serie, force
drop _merge
merge 1:1 serie using $altas/altas2017, force
save "$bases/padron_pagos_2017.dta", replace

append using $p2017/pagos_unmatched, force
save "$bases/padron_pagos_2017.dta", replace


*************************************************
*** Pagos 2016
*************************************************

global p2016 "$root/2016"

//Pagos en 2016
use "$p2016/2016.dta", clear
gen pago2016 = 1 if perini == 2016
drop marca
drop if perini != 2016
save "$p2016/pagos2016_sucio", replace


//Pagos en 2017
use "$p2017/2017.dta", clear
gen pago2016 = 1 if perini == 2016
drop marca
drop if perini != 2016
append using "$p2016/pagos2016_sucio", force
save "$p2016/pagos2016_sucio", replace

//Pagos en 2018
use "$p2018/2018.dta", clear
drop if perini == "MLH6020"
destring perini, replace
gen pago2016 = 1 if perini == 2016
drop marca
drop if perini != 2016
append using "$p2016/pagos2016_sucio", force
save "$p2016/pagos2016_sucio", replace

//Pagos en 2019
use "$p2019/2019.dta", clear
gen pago2016 = 1 if perini == 2016
drop marca
drop if perini != 2016
append using "$p2016/pagos2016_sucio", force
save "$p2016/pagos2016_sucio", replace

use "$root/padronlimpio.dta", clear
merge 1:m nplaca using "$p2016/pagos2016_sucio" 
save "$bases/padron_pagos_2016", replace 
use "$bases/padron_pagos_2016", clear
drop if _merge!=2
save $p2016/pagos_unmatched, replace

//Altas
use "$altas/aux2016.dta", clear

gen serie = ctaoptp + convenio 
duplicates report serie
duplicates drop serie, force
gen pago2016 = 1

save "$altas/altas2016", replace

use "$altas/altas2016", clear

global p2016 "$root/2016"
use "$bases/padron_pagos_2016.dta",clear

duplicates drop serie, force
drop _merge
merge 1:1 serie using $altas/altas2016, force
save "$bases/padron_pagos_2016.dta", replace

append using $p2016/pagos_unmatched, force
save "$bases/padron_pagos_2016.dta", replace

*************************************************
*** Pagos 2015
*************************************************

global p2015 "$root/2015"

//Pagos en 2015
use "$p2015/2015.dta", clear
gen pago2015 = 1 if perini == 2015
drop marca
drop if perini != 2015
save "$p2015/pagos2015_sucio", replace


//Pagos en 2016
use "$p2016/2016.dta", clear
gen pago2015 = 1 if perini == 2015
drop marca
drop if perini != 2015
append using "$p2015/pagos2015_sucio", force
save "$p2015/pagos2015_sucio", replace


//Pagos en 2017
use "$p2017/2017.dta", clear
gen pago2015 = 1 if perini == 2015
drop marca
drop if perini != 2015
append using "$p2015/pagos2015_sucio", force
save "$p2015/pagos2015_sucio", replace

//Pagos en 2018
use "$p2018/2018.dta", clear
drop if perini == "MLH6020"
destring perini, replace
gen pago2015 = 1 if perini == 2015
drop marca
drop if perini != 2015
append using "$p2015/pagos2015_sucio", force
save "$p2015/pagos2015_sucio", replace

//Pagos en 2019
use "$p2019/2019.dta", clear
gen pago2015 = 1 if perini == 2015
drop marca
drop if perini != 2015
append using "$p2015/pagos2015_sucio", force
save "$p2015/pagos2015_sucio", replace

use "$root/padronlimpio.dta", clear
merge 1:m nplaca using "$p2015/pagos2015_sucio" 
save "$bases/padron_pagos_2015", replace 
use "$bases/padron_pagos_2015", clear
drop if _merge!=2
save $p2015/pagos_unmatched, replace

/*
//Altas
use "$altas/aux2015.dta", clear

gen serie = ctaoptp + convenio 
duplicates report serie
duplicates drop serie, force
gen pago2015 = 1

save "$altas/altas2015", replace

use "$altas/altas2015", clear

global p2015 "$root/2015"
use "$bases/padron_pagos_2015.dta",clear

duplicates drop serie, force
drop _merge
merge 1:1 serie using $altas/altas2015, force
save "$bases/padron_pagos_2015.dta", replace

append using $p2015/pagos_unmatched, force
save "$bases/padron_pagos_2015.dta", replace
*/

*************************************************
*** Stata 13
*************************************************
global stata13 "$bases/Stata13"

use "$bases/padron_pagos_2015.dta", clear
saveold "$stata13/padron_pagos_2015.dta", version(13) replace

use "$bases/padron_pagos_2016.dta", clear
saveold "$stata13/padron_pagos_2016.dta", version(13) replace

use "$bases/padron_pagos_2017.dta", clear
saveold "$stata13/padron_pagos_2017.dta", version(13) replace

use "$bases/padron_pagos_2018.dta", clear
saveold "$stata13/padron_pagos_2018.dta", version(13) replace

use "$bases/padron_pagos_2019.dta", clear
saveold "$stata13/padron_pagos_2019.dta", version(13) replace
