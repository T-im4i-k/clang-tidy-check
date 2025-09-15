function print_delim(){
  printf -- "---\n"
}

function print_boxed(){
  if [ "$#" -ne 1 ]; then
    printf "Error: print_boxed() expects 1 argument, but %s were provided\n" "$#"
  fi

  print_delim
  printf "%s\n" "$1"
  print_delim
}

printf "Installing required packages...\n"
if which cmake &>/dev/null && cmake --version &>/dev/null; then
  print_boxed "Found cmake installation:\n$(cmake --version)"
elif sudo apt-get install -y cmake &>/dev/null; then
  print_boxed "Installed cmake:\n$(cmake --version)"
else
  printf "Error: cmake installation failed.\n"
  exit 1
fi

if which ninja &>/dev/null && ninja --version &>/dev/null; then
  print_boxed "Found ninja installation:\n$(ninja --version)"
elif sudo apt-get install -y ninja-build &>/dev/null; then
  print_boxed "Installed ninja:\n$(ninja --version)"
else
  printf "Error: ninja installation failed.\n"
  exit 1
fi

if which clang &>/dev/null && clang --version &>/dev/null; then
  print_boxed "Found clang installation:\n$(clang --version)"
elif sudo apt-get install -y clang &>/dev/null; then
  print_boxed "Installed clang:\n$(clang --version)"
else
  printf "Error: clang installation failed.\n"
  exit 1
fi