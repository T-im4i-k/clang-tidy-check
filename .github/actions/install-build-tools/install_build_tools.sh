function print_delim() {
	printf -- "---\n"
}

printf "Installing required packages...\n"
print_delim
if which cmake &>/dev/null && cmake --version &>/dev/null; then
	printf "Found cmake installation:\n"
	printf "%s\n" "$(cmake --version)"
	print_delim
elif sudo apt-get install -y cmake &>/dev/null; then
	printf "Installed cmake:\n"
	printf "%s\n" "$(cmake --version)"
	print_delim
else
	printf "Error: cmake installation failed.\n"
	exit 1
fi

if which ninja &>/dev/null && ninja --version &>/dev/null; then
	printf "Found ninja installation:\n"
	printf "%s\n" "$(ninja --version)"
	print_delim
elif sudo apt-get install -y ninja-build &>/dev/null; then
	printf "Installed ninja:\n"
	printf "%s\n" "$(ninja --version)"
	print_delim
else
	printf "Error: ninja installation failed.\n"
	exit 1
fi

if which clang &>/dev/null && clang --version &>/dev/null; then
	printf "Found clang installation:\n"
	printf "%s\n" "$(clang --version)"
	print_delim
elif sudo apt-get install -y clang &>/dev/null; then
	printf "Installed clang:\n"
	printf "%s\n" "$(clang --version)"
	print_delim
else
	printf "Error: clang installation failed.\n"
	exit 1
fi

printf "### Successfully installed required packages ###\n"
