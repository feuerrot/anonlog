#!/bin/bash
VENVDIR=venv
SCRIPT=./main

venv_make() {
	pyvenv $VENVDIR
}

venv_activate() {
	. venv/bin/activate
}

pip_install() {
	pip install -r requirements.txt
}

rib_get() {
	if [ -f "rib*.bz2" ]
	then 
		rm rib.bz2
	fi
	venv/bin/pyasn_util_download.py --latestv46
	venv/bin/pyasn_util_convert.py --single rib.*.bz2 ipasn.db
}

run() {
	eval "${SCRIPT} $@"
}

if [ ! -d "$VENVDIR" ]
then
	venv_make
	venv_activate
	pip_install
else
	venv_activate
fi

rib_get
run $@
