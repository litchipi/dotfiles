#!/bin/bash

function no_output {
	$@ 1>/dev/null 2>/dev/null
}

function test_dep {
	if ! no_output dpkg -s $1; then
		echo "Dependency $1 need to be installed"
		echo -e "\tsudo apt install $1"
		return 1;
	fi
	return 0;
}

test_dep secure-delete
test_dep gpg
test_dep git-crypt

gpg -d gitcrypt.key.gpg > gitcrypt.key
git-crypt unlock gitcrypt.key
srm gitcrypt.key
