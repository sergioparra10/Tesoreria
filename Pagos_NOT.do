*************************************************
*** Pagos 2019
*************************************************
global p2019 "/Users/sergioparra/Desktop/Tesoreria/2019"
global root "/Users/sergioparra/Desktop/Tesoreria"

use "$p2019/2019.dta", clear
gen pago2019 = 1 if perini == 2019
drop marca
drop if perini != 2019
drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2019/pagos2019_limpio", replace
use "$p2019/pagos2019_limpio",  clear

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
merge 1:1 nplaca using "$p2019/pagos2019"

save "$p2019/padron_pagos2019", replace //Esta le vamos a mandar a tu tía Rosy
use "$p2019/padron_pagos2019", clear
drop if _merge == 2   
tab _merge
gen _merge2019 = _merge
drop _merge atl idpago fcobro caja subcaja cajero partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa iva cobranza embargo recargo1 recargo2 otros subsidio bonifica total tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_alta fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura dup
replace pago2019 = 0 if pago2019 == . 
save "$p2019/padronpagos2019", replace //Este vamos a usar para mandar los correos
use "$p2019/padronpagos2019"





*************************************************
*** Pagos 2018
*************************************************

global p2018 "/Users/sergioparra/Desktop/Tesoreria/2018"

//import delimited "/Users/sergioparra/Desktop/Tesoreria/2018.txt", delimiter("|") encoding(ISO-8859-1) clear
//save "$p2018/2018.dta", replace
use "$p2018/2018.dta", clear
//Pagos en 2018

*para ver si ya pagaron 
drop if perini == "MLH6020"
destring perini, replace
gen pago2018 = 1 if perini == 2018

*quitamos para eliminar error 
drop marca
drop if perini != 2018

drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2018/pagos2018_limpio", replace
use "$root/padronlimpio.dta", clear
merge 1:1 nplaca using "$p2018/pagos2018_limpio"
save "$p2018/padron_pagos2018",replace //Este le vamos a mandar a tu tía Rosy

use "$p2018/pagos2018_limpio", clear
drop atl idpago fcobro caja subcaja cajero partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa iva cobranza embargo recargo1 recargo2 otros subsidio bonifica total tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_alta fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura dup
save "$p2018/pagos2018", replace

//Pagos en 2019
use "$p2019/2019", clear
gen pago2018 = 1 if perini == 2018
drop if perini != 2018
drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
keep nplaca pago2018
save "$p2018/pagos2018_2019", replace

append using "$p2018/pagos2018", force
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

save "$p2018/pagos2018", replace

// Vamos a hacer el merge

use $p2019/padronpagos2019.dta, clear
merge 1:1 nplaca using "$p2018/pagos2018"
drop if _merge == 2   
tab _merge
gen _merge2018 = _merge
drop _merge 
replace pago2018 = 0 if pago2018 == .
save "$p2018/padronpagos2018", replace


**************************************************
*** Pagos 2017
**************************************************
global p2017 "/Users/sergioparra/Desktop/Tesoreria/2017"

//import delimited "/Users/sergioparra/Desktop/Tesoreria/2017.txt", delimiter("|") encoding(ISO-8859-1) clear
//save "$p2018/2017.dta", replace

//Pagos en 2017

*para ver si ya pagaron 
use "$p2017/2017.dta", clear
destring perini, replace
gen pago2017 = 1 if perini == 2017

*quitamos para eliminar error 
drop marca
drop if perini != 2017

drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2017/pagos2017_limpio", replace
use "$root/padronlimpio.dta", clear
merge 1:1 nplaca using "$p2017/pagos2017_limpio"
save "$p2017/padron_pagos2017", replace //Este le vamos a mandar a tu tía Rosy

use "$p2017/pagos2017_limpio", clear
drop atl idpago fcobro caja subcaja cajero partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa iva cobranza embargo recargo1 recargo2 otros subsidio bonifica total tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_alta fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura dup
save "$p2017/pagos2017", replace

//Pagos en 2018
use "$p2018/2018", clear
drop if perini == "MLH6020"
destring perini, replace
gen pago2017 = 1 if perini == 2017
drop if perini != 2017
drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
keep nplaca pago2017
save "$p2017/pagos2017_2018", replace

append using "$p2017/pagos2017", force
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

save "$p2017/pagos2017", replace

//Pagos en 2019
use "$p2019/2019", clear
gen pago2017 = 1 if perini == 2017
drop if perini != 2017
drop if nplaca == ""
drop if nplaca == "0.00"
/*
rename numcredito serie
duplicates report serie
sort serie
*/
duplicates report nplaca
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
keep nplaca pago2017
save "$p2017/pagos2017_2019", replace

append using "$p2017/pagos2017", force
sort nplaca
drop dup
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

save "$p2017/pagos2017", replace


//Merge
use $p2018/padronpagos2018.dta, clear
merge 1:1 nplaca using "$p2017/pagos2017"
drop if _merge == 2   
tab _merge
gen _merge2017 = _merge
drop _merge 
replace pago2017 = 0 if pago2017 == .
drop dup 
duplicates report nplaca
save "$p2017/padronpagos2017", replace



**************************************************
*** Apendice
**************************************************
 //duplicates report nplaca
 //duplicates drop nplaca, force
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup < 1
drop if dup > 50
