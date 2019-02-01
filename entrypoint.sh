#!/bin/bash

check_if_branch(){
	local ref=$(jq '.ref' $GITHUB_EVENT_PATH)
	if ! [[ -z ${BRANCH} ]]; then
		if [ "$ref" != "\"refs/heads/$BRANCH\"" ]; then
			echo "Not publishing because we're not on $BRANCH"
			exit 0
		fi
	fi
}

go_to_build_dir(){
	if [ ! -z $SUBDIR ]; then
		cd $SUBDIR
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

check_if_branch
go_to_build_dir
check_if_setup_file_exists
upload_package
