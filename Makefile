# https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_OpenSCAD_in_a_command_line_environment
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

SHELL := /bin/bash
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Default openscad lib path: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries
DEP := ${HOME}/Documents/OpenSCAD/libraries/dotSCAD
openscad := /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

.PHONY: cookie-cutters

%.png: %.scad
	@echo Generating $*.png from $@
	${openscad} -o ${ROOT_DIR}/build/images/$*.png $*.scad

cookie-cutters:
	ls ${ROOT_DIR}/src/CookieCutters/*.scad | sed 's/.scad//g' \
		| xargs -n 1 basename \
		| xargs -n 1 bash -c ' \
			cd ${ROOT_DIR}/src/CookieCutters && make -f ${ROOT_DIR}/Makefile $${0}.png \
		'

${DEP}:
	mkdir -f $$( dirname ${DEP} )
	git clone git@github.com:JustinSDK/dotSCAD.git ${DEP}

start: ${DEP}
	open -a "OpenSCAD"

open:
	open -a "Google Chrome" ${ROOT_DIR}/index.html

