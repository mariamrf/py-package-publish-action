#!/bin/bash

install_python_version(){
	pyenv install $INPUT_PYTHON_VERSION
	pyenv global $INPUT_PYTHON_VERSION
}

install_build_tools(){
	pip install --upgrade setuptools wheel twine
}

go_to_build_dir(){
	if [ ! -z $INPUT_SUBDIR ]; then
		cd $INPUT_SUBDIR
	fi
}

check_if_setup_file_exists(){
	if [ ! -f setup.py ]; then
		echo "setup.py must exist in the directory that is being packaged and published."
		exit 1
	fi
}

upload_package(){
	python setup.py sdist bdist_wheel
	twine upload dist/*
}

install_python_version
install_build_tools
go_to_build_dir
check_if_setup_file_exists
upload_package
