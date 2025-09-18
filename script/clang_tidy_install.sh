#!/bin/bash

# Installs a specified version of the clang-tidy static analysis tool on Ubuntu/Debian systems using apt-get.
# Requires CLANG_TIDY_VERSION environment variable to specify the version to install.
# Example: CLANG_TIDY_VERSION=14 sudo apt-get update && ./install-clang-tidy.sh

if [ -z "$CLANG_TIDY_VERSION" ]; then
	printf "Error: variable CLANG_TIDY_VERSION is required.\n"
	exit 1
fi

CLANG_TIDY="clang-tidy-$CLANG_TIDY_VERSION"
INSTALLATION_FAIL="false"

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
	printf "### %s installation FAIL ###\n" "$CLANG_TIDY"
	exit 1
else
	printf "### %s installation SUCCESS ###\n" "$CLANG_TIDY"
	exit 0
fi
