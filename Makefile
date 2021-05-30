# Download and install `butler` first, and run `butler login` before you run this
#
# Add a Makefile at ${cart}/Makefile, and define:
#
# name of the .p8 itself
# name = hello_world
#
# where to deploy the game
# itchio = user/game

# name of the folder containing the .p8
cart = project
include ${cart}/Makefile

# path to the pico8 executable
pico8 = /mnt/c/Users/thiba/Desktop/gamedev/pico-8/pico8.exe
fullname = ${cart}/${name}

all: web bin

deploy: deploy_all

deploy_all: deploy_web deploy_os

deploy_web: web
	# butler push ${fullname}.zip ${itchio}:web

deploy_os: deploy_linux deploy_mac deploy_windows

deploy_linux: bin
	# butler push ${fullname}.bin/${name}_linux.zip ${itchio}:linux

deploy_mac: bin
	# butler push ${fullname}.bin/${name}_osx.zip ${itchio}:mac

deploy_windows: bin
	# butler push ${fullname}.bin/${name}_windows.zip ${itchio}:windows
	
web: check_label clean_web
	${pico8} ${fullname}.p8 -export ${name}.html
	mv ${name}.html ${cart}/index.html
	mv ${name}.js ${cart}/
	cd ${cart} && zip ${name}.zip index.html ${name}.js
	cd ${cart} && rm -r ${name}.js index.html

bin: check_label clean_bin
	${pico8} ${fullname}.p8 -export ${name}.bin
	mv ${name}.bin ${fullname}.bin

clean: clean_web clean_bin

clean_web:
	rm -f ${fullname}.zip
	rm -f ${cart}/*.js
	rm -f ${cart}/*.html

clean_bin:
	rm -rf ${fullname}.bin

check_label:
	grep -q __label__ ${fullname}.p8

.PHONY: all deploy deploy_all deploy_web deploy_os deploy_linux deploy_mac deploy_windows web clean clean_web clean_bin check_label
