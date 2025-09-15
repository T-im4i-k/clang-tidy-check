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

if which cmake &>/dev/null && cmake --version &>/dev/null; then
  printf "Found cmake installation:\n"
  print_boxed "$(cmake --version)"
elif sudo apt install -y cmake &>/dev/null; then
  printf "Installed cmake:\n"
  print_boxed "$(cmake --version)"
else
  printf "Error: cmake installation failed.\n"
  exit 1
fi

if which ninja &>/dev/null && ninja --version &>/dev/null; then
  printf "Found ninja installation:\n"
  print_boxed "$(ninja --version)"
elif sudo apt install -y ninja-build &>/dev/null; then
  printf "Installed ninja:\n"
  print_boxed "$(ninja --version)"
else
  printf "Error: ninja installation failed.\n"
  exit 1
fi

if which clang &>/dev/null && clang --version &>/dev/null; then
  printf "Found clang installation:\n"
  print_boxed "$(clang --version)"
elif sudo apt install -y clang &>/dev/null; then
  printf "Installed clang:\n"
  print_boxed "$(clang --version)"
else
  printf "Error: clang installation failed.\n"
  exit 1
fi