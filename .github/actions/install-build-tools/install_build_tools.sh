INSTALLATION_FAIL="false"

function print_delim() {
	printf -- "---\n"
}

printf "Installing build tools...\n"
print_delim

if which cmake &>/dev/null && cmake --version &>/dev/null; then
	printf "Found cmake installation at %s.\n" "$(which cmake)"
	printf "version: %s\n" "$(cmake --version)"
elif sudo apt-get install -y cmake &>/dev/null; then
	printf "Successfully installed cmake to %s.\n" "$(which cmake)"
	printf "version: %s\n" "$(cmake --version)"
else
	printf "Error: failed to install cmake.\n"
	INSTALLATION_FAIL="true"
fi

print_delim

if which ninja &>/dev/null && ninja --version &>/dev/null; then
	printf "Found ninja installation at %s.\n" "$(which ninja)"
	printf "version: %s\n" "$(ninja --version)"
elif sudo apt-get install -y ninja-build &>/dev/null; then
	printf "Successfully installed ninja to %s.\n" "$(which ninja)"
	printf "version: %s\n" "$(ninja --version)"
else
	printf "Error: failed to install ninja.\n"
	INSTALLATION_FAIL="true"
fi

print_delim

if which clang &>/dev/null && clang --version &>/dev/null; then
	printf "Found clang installation at %s.\n" "$(which clang)"
	printf "version: %s\n" "$(clang --version)"
elif sudo apt-get install -y clang &>/dev/null; then
	printf "Successfully installed clang to %s.\n" "$(which clang)"
	printf "version: %s\n" "$(clang --version)"
else
	printf "Error: failed to install clang.\n"
	INSTALLATION_FAIL="true"
fi

print_delim

if [ "$INSTALLATION_FAIL" = "true" ]; then
	printf "### Build tools installation FAIL ###\n"
	exit 1
else
	printf "### Build tools installation SUCCESS ###\n"
	exit 0
fi

