global root "/Users/sergioparra/Downloads/Tesoreria/"
global altas "$root/Altas"

*************************************************
*** Pagos 2019
*************************************************
global p2019 "$root/2019"
**import delimited "/Users/sergioparra/Downloads/Tesoreria/2019/ABRIL COMPLETO 2019.txt", delimiter("|") encoding(ISO-8859-1) clear
**save $p2019/abril, replace
use "$p2019/2019.dta", clear
append using $p2019/abril, force 
duplicates drop lineacaptura, force
gen pago2019 = 1 if perini == 2019
drop marca
drop if perini != 2019
drop if nplaca == ""
drop if nplaca == "0.00"
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
keep pago2019 nplaca
save "$p2019/pagos2019_limpio", replace
use "$p2019/pagos2019_limpio",  clear

use "$root/padronlimpio.dta", clear

merge 1:1 nplaca using "$p2019/pagos2019_limpio"
tab _merge
gen _merge2019 = _merge
drop _merge 
replace pago2019 = 0 if pago2019 == . 
save "$p2019/padronpagos2019", replace 

**Altas
use "$p2019/padronpagos2019.dta",clear
drop if _merge2019==2
duplicates drop serie, force
merge 1:1 serie using $altas/altas2019, force
drop if _merge==2
replace pago2019=1 if _merge==3
drop atl idpago fcobro caja cajero subcaja partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa cobranza iva embargo recargo1 recargo2 otros bonifica tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura cfcdmx
save "$p2019/padronpagos2019", replace //Este vamos a usar para mandar los correos


*************************************************
*** Pagos 2018
*************************************************

global p2018 "$root/2018"

***Pagos en 2018
use "$p2018/2018.dta", clear

*Para ver si ya pagaron 
drop if perini == "MLH6020"
destring perini, replace
gen pago2018 = 1 if perini == 2018

*Quitamos para eliminar error 
drop marca
drop if perini != 2018
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2018/pagos2018", replace

***Pagos en 2019
use "$p2019/2019", clear

*Para ver si ya pagaron 
gen pago2018 = 1 if perini == 2018

*Quitamos para eliminar error 
drop if perini != 2018
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1


*Le pegamos los pagos hechos en 2018
append using "$p2018/pagos2018", force

*Nos deshacemos de los duplicados
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2018/pagos2018", replace

keep nplaca pago2018
save "$p2018/pagos2018_limpio", replace

***Merge

use "$p2019/padronpagos2019", clear
drop _merge 
merge 1:1 nplaca using "$p2018/pagos2018_limpio"
tab _merge
gen _merge2018 = _merge
drop _merge 
replace pago2018 = 0 if pago2018 == . 
save "$p2018/padronpagos2018", replace 

**Altas
use "$p2018/padronpagos2018.dta",clear
drop if _merge2018==2
duplicates drop serie, force
merge 1:1 serie using $altas/altas2018, force
drop if _merge==2
replace pago2018=1 if _merge==3
drop atl idpago fcobro caja cajero subcaja partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa cobranza iva embargo recargo1 recargo2 otros bonifica tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura cfcdmx
save "$p2018/padronpagos2018", replace //Este vamos a usar para mandar los correos


*************************************************
*** Pagos 2017
*************************************************

global p2017"$root/2017"

***Pagos en 2017
use "$p2017/2017.dta", clear

*Para ver si ya pagaron 
gen pago2017 = 1 if perini == 2017

*Quitamos para eliminar error 
drop if perini != 2017
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2017/pagos2017", replace

***Pagos en 2018
use "$p2018/2018", clear

*Para ver si ya pagaron 
drop if perini == "MLH6020"
destring perini, replace
gen pago2017 = 1 if perini == 2017

*Quitamos para eliminar error 
drop if perini != 2017
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2018
append using "$p2017/pagos2017", force

*Nos deshacemos de los duplicados
sort nplaca
drop dup
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2017/pagos2017", replace

***Pagos en 2019
use "$p2019/2019", clear

*Para ver si ya pagaron 
gen pago2017 = 1 if perini == 2017

*Quitamos para eliminar error 
drop if perini != 2017
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2017 y 2018
append using "$p2017/pagos2017", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2017/pagos2017", replace

keep nplaca pago2017
save "$p2017/pagos2017_limpio", replace

***Merge

use "$p2018/padronpagos2018", clear
drop _merge 
merge 1:1 nplaca using "$p2017/pagos2017_limpio"
tab _merge
gen _merge2017 = _merge
drop _merge 
replace pago2017 = 0 if pago2017 == . 
save "$p2017/padronpagos2017", replace //Este vamos a usar para mandar los correos

**Altas
use "$p2017/padronpagos2017.dta",clear
drop if _merge2017==2
duplicates drop serie, force
merge 1:1 serie using $altas/altas2017, force
drop if _merge==2
replace pago2017=1 if _merge==3
drop atl idpago fcobro caja cajero subcaja partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa cobranza iva embargo recargo1 recargo2 otros bonifica tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura cfcdmx
save "$p2017/padronpagos2017", replace //Este vamos a usar para mandar los correos


*************************************************
*** Pagos 2016
*************************************************

global p2016"$root/2016"

***Pagos en 2016
use "$p2016/2016.dta", clear

*Para ver si ya pagaron 
gen pago2016 = 1 if perini == 2016

*Quitamos para eliminar error 
drop if perini != 2016
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2016/pagos2016", replace

***Pagos en 2017
use "$p2017/2017", clear

*Para ver si ya pagaron 
gen pago2016 = 1 if perini == 2016

*Quitamos para eliminar error 
drop if perini != 2016
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2016 
append using "$p2016/pagos2016", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2016/pagos2016", replace

keep nplaca pago2016
save "$p2016/pagos2016_limpio", replace


***Pagos en 2018
use "$p2018/2018", clear

*Para ver si ya pagaron 
drop if perini == "MLH6020"
destring perini, replace
gen pago2016 = 1 if perini == 2016

*Quitamos para eliminar error 
drop if perini != 2016
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2016 y 2017
append using "$p2016/pagos2016", force

*Nos deshacemos de los duplicados
sort nplaca
drop dup
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2016/pagos2016", replace

***Pagos en 2019
use "$p2019/2019", clear

*Para ver si ya pagaron 
gen pago2016 = 1 if perini == 2016

*Quitamos para eliminar error 
drop if perini != 2016
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2016, 2017 y 2018
append using "$p2016/pagos2016", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2016/pagos2016", replace

keep nplaca pago2016
save "$p2016/pagos2016_limpio", replace

***Merge

use "$p2017/padronpagos2017", clear
drop _merge 
merge 1:1 nplaca using "$p2016/pagos2016_limpio"
tab _merge
gen _merge2016 = _merge
drop _merge 
replace pago2016 = 0 if pago2016 == . 
save "$p2016/padronpagos2016", replace //Este vamos a usar para mandar los correos

**Altas
use "$p2016/padronpagos2016.dta",clear
drop if _merge2016==2
duplicates drop serie, force
merge 1:1 serie using $altas/altas2016, force
drop if _merge==2
replace pago2016=1 if _merge==3
drop atl idpago fcobro caja cajero subcaja partida ctaoptp ctagua ctapredial ctarfc ctaestatal ctamercado convenio ctaeconum numcredito numfolio liquidacio perini perfin perayo perven vencim impuesto derecho importe1 importe2 multa cobranza iva embargo recargo1 recargo2 otros bonifica tdecla tsaldo taplic fpago pcancl totemp1 totemp2 actividad nparc hracob fraccion deleg fmove numelem tlic imprime remesa fecha_modifico usuario_alta usuario_modifico tipo_reg ajuste concepto lineacaptura cfcdm
save "$p2016/padronpagos2016", replace //Este vamos a usar para mandar los correos


*************************************************
*** Pagos 2015
*************************************************

global p2015"$root/2015"

***Pagos en 2015
use "$p2015/2015.dta", clear

*Para ver si ya pagaron 
gen pago2015 = 1 if perini == 2015

*Quitamos para eliminar error 
drop if perini != 2015
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2015/pagos2015", replace


***Pagos en 2016
use "$p2016/2016", clear

*Para ver si ya pagaron 
gen pago2015 = 1 if perini == 2015

*Quitamos para eliminar error 
drop if perini != 2015
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2015 
append using "$p2015/pagos2015", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2015/pagos2015", replace

keep nplaca pago2015
save "$p2015/pagos2015_limpio", replace


***Pagos en 2017
use "$p2017/2017", clear

*Para ver si ya pagaron 
gen pago2015 = 1 if perini == 2015

*Quitamos para eliminar error 
drop if perini != 2015
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2015 
append using "$p2015/pagos2015", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2015/pagos2015", replace

keep nplaca pago2015
save "$p2015/pagos2015_limpio", replace


***Pagos en 2018
use "$p2018/2018", clear

*Para ver si ya pagaron 
drop if perini == "MLH6020"
destring perini, replace
gen pago2015 = 1 if perini == 2015

*Quitamos para eliminar error 
drop if perini != 2015
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2015 y 2017
append using "$p2015/pagos2015", force

*Nos deshacemos de los duplicados
sort nplaca
drop dup
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2015/pagos2015", replace

***Pagos en 2019
use "$p2019/2019", clear

*Para ver si ya pagaron 
gen pago2015 = 1 if perini == 2015

*Quitamos para eliminar error 
drop if perini != 2015
drop if nplaca == ""
drop if nplaca == "0.00"

*Nos deshacemos de los duplicados
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1

*Le pegamos los pagos hechos en 2015, 2017 y 2018
append using "$p2015/pagos2015", force
drop dup
sort nplaca
quietly by nplaca : gen dup = cond(_N==1, 0, _n)
drop if dup>=1
save "$p2015/pagos2015", replace

keep nplaca pago2015
save "$p2015/pagos2015_limpio", replace

***Merge

use "$p2016/padronpagos2016", clear
drop _merge 
merge 1:1 nplaca using "$p2015/pagos2015_limpio"
tab _merge
gen _merge2015 = _merge
drop _merge 

replace pago2015 = 0 if pago2015 == . 
drop if _merge2015 == 2
save "$p2015/padronpagos2015", replace //Este vamos a usar para mandar los correos



*************************************************
*** Replace pagos
*************************************************

replace pago2018 = 1 if modelo>2018
replace pago2017 = 1 if modelo>2017
replace pago2016= 1 if modelo>2016
replace pago2015= 1 if modelo>2015

table pago2017 pago2019 pago2018, by(pago2016 pago2015) contents(freq)

