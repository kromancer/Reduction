#!/bin/bash
PARSER_DIR=./Parsers/
REPORT_PAR=${PARSER_DIR}ParserReport

TEMPL_DIR=./Templates/
TEM_DIR=./.src/

EXE_DIR=./.exe/
REP_DIR=./.rep/
STATS=${REP_DIR}stats.csv
CUDA_ARC=sm_20

mkdir ${TEM_DIR} ${EXE_DIR} ${REP_DIR} 2> discard
printf "Unroll_Depth , Execution_Time\n" > ${STATS}


for i in {1..20} 
do
    echo "Unrolling $i"
    cat ${TEMPL_DIR}Reduction.addition.template | sed "1 a #define DB_PER_TB $i" > ${TEM_DIR}pre_unroll$i
   
    ${PARSER_DIR}Tunner ${TEM_DIR}pre_unroll$i ${TEM_DIR}unrolled$i
    cat ${TEM_DIR}unrolled$i ${TEMPL_DIR}Main.cu > ${TEM_DIR}final$i.cu

    nvcc -arch=${CUDA_ARC} ${TEM_DIR}/final$i.cu -o ${EXE_DIR}/exe$i
    nvprof ${EXE_DIR}exe$i 2> ${REP_DIR}rep$i.txt

    ${REPORT_PAR} ${REP_DIR}rep$i.txt ${STATS} $i
done
./plot.R
evince Rplots.pdf &
