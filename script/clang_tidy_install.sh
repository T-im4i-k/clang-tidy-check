#!/bin/bash

# Installs a specified version of the clang-tidy static analysis tool on Ubuntu/Debian systems using apt-get.
# This script should only be called from clang-tidy-check action.yml

INSTALLATION_FAIL="false"
UNSET_VALUE='__UNSET__'
CLANG_TIDY=""

if [ -z "$CLANG_TIDY_VERSION" ]; then
	printf "Error: variable CLANG_TIDY_VERSION is required.\n"
	exit 1
elif [ "$CLANG_TIDY_VERSION" = "$UNSET_VALUE" ]; then
	CLANG_TIDY="clang-tidy"
else
	CLANG_TIDY="clang-tidy-$CLANG_TIDY_VERSION"
fi

function print_delim() {
	printf -- "---\n"
}

printf "Installing %s...\n" "$CLANG_TIDY"
print_delim

if which "$CLANG_TIDY" &>/dev/null && "$CLANG_TIDY" --version &>/dev/null; then
	printf "Found %s installation at %s.\n" "$CLANG_TIDY" "$(which "$CLANG_TIDY")"
	printf "version: %s\n" "$($CLANG_TIDY --version)"

elif sudo apt-get install -y "$CLANG_TIDY" &>/dev/null; then
	printf "Successfully installed %s to %s.\n" "$CLANG_TIDY" "$(which "$CLANG_TIDY")"
	printf "version: %s\n" "$($CLANG_TIDY --version)"

else
	printf "Error: failed to install %s.\n" "$CLANG_TIDY"
	INSTALLATION_FAIL="true"
fi

print_delim

if [ "$INSTALLATION_FAIL" = "true" ]; then
	printf "### clang-tidy installation FAIL ###\n"
	exit 1
else
	printf "### clang-tidy installation SUCCESS ###\n"
	exit 0
fi
