#!/bin/bash 
#:   Autor:   Donnet
#:   Fecha:   03 Jul 2022
#:   Proposito:  Obtener datos acumulados covid
#:   Opciones:   ninguna
##   https://github.com/Donnet01/intersemestral22

_obtiene_campo(){

local FECHA=$1 

head -n 1 Casos_Diarios_Municipio_Confirmados_20220614.csv | tr "," "\n" | nl | grep $FECHA | cut -f 1
}

_suma_resultado(){
local FECHA=$1

tail -n +2 Casos_Diarios_Municipio_Confirmados_20220614.csv | awk -v CP=$FECHA -F "," '{A += $CP}; END {print A}'

}

_obtener_fechas(){
MES=$1
ANIO=$2
head -n 1 Casos_Diarios_Municipio_Confirmados_20220614.csv | tr "," "\n" | grep ${MES}-${ANIO}

}

FECHAS=$(_obtener_fechas $1 $2)
for FECHA in $FECHAS ; do
	echo -n "la fecha es $FECHA: "
    _suma_resultado $(_obtiene_campo $FECHA)
done > suma_Casos_Covid.csv


echo -n "Los casos acumulados de $1-$2 son: "
suma_mes= awk -F ': ' '{sum += $2} END {print sum}' suma_Casos_Covid.csv