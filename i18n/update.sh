#!/bin/bash

set -e

TS_FILES=$(ls *.ts)
LUPDATE=$(which lupdate-qt5 lupdate lupdate-qt4 2>/dev/null | head -n1 )

ARGS=""
#ARGS+=" -no-obsolete"

${LUPDATE} ${ARGS}  -recursive .. -ts ${TS_FILES}
