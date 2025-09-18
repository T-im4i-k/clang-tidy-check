#!/bin/bash

CHECK_FAIL="false"
CLANG_TIDY=""
CLANG_TIDY_ARGS=()
UNSET_VALUE='__UNSET__'

if [ -z "$CLANG_TIDY_VERSION" ]; then
	printf "Error: variable CLANG_TIDY_VERSION is required.\n"
	exit 1
elif [ "$CLANG_TIDY_VERSION" = "$UNSET_VALUE" ]; then
	CLANG_TIDY="clang-tidy"
else
	CLANG_TIDY="clang-tidy-$CLANG_TIDY_VERSION"
fi

if [ -z "$CLANG_TIDY_COMPILE_COMMANDS_PATH" ]; then
	printf "Error: variable CLANG_TIDY_COMPILE_COMMANDS_PATH is required.\n"
	exit 1
elif [ ! -f "$CLANG_TIDY_COMPILE_COMMANDS_PATH" ]; then
	printf "Error: %s is not a valid regular file.\n" "$CLANG_TIDY_COMPILE_COMMANDS_PATH"
	exit 1
elif ! jq empty "$CLANG_TIDY_COMPILE_COMMANDS_PATH" &>/dev/null; then
	printf "Error: %s is not a valid .json file.\n" "$CLANG_TIDY_COMPILE_COMMANDS_PATH"
	exit 1
fi

CLANG_TIDY_ARGS+=("-p=$CLANG_TIDY_COMPILE_COMMANDS_PATH")
if [ "$CLANG_TIDY_CHECKS" != "$UNSET_VALUE" ]; then
	CLANG_TIDY_ARGS+=("--checks=$CLANG_TIDY_CHECKS")
fi

if [ "$CLANG_TIDY_WARNINGS_AS_ERRORS" != "$UNSET_VALUE" ]; then
	CLANG_TIDY_ARGS+=("--warnings-as-errors=$CLANG_TIDY_WARNINGS_AS_ERRORS")
fi

if [ "$CLANG_TIDY_CONFIG" != "$UNSET_VALUE" ]; then
	CLANG_TIDY_ARGS+=("--config=$CLANG_TIDY_CONFIG")
fi

if [ "$CLANG_TIDY_CONFIG_FILE" != "$UNSET_VALUE" ]; then
	CLANG_TIDY_ARGS+=("--config-file=$CLANG_TIDY_CONFIG_FILE")
fi

if [ "$CLANG_TIDY_EXTRA_ARGS" != "$UNSET_VALUE" ]; then
	read -ra CLANG_TIDY_EXTRA_ARGS_ARRAY <<<"$CLANG_TIDY_EXTRA_ARGS"
	CLANG_TIDY_ARGS+=("${CLANG_TIDY_EXTRA_ARGS_ARRAY[@]}")
fi

function print_delim() {
	printf -- "---\n"
}

printf "Checking code quality with %s...\n" "$CLANG_TIDY"
printf "arguments: %s\n" "${CLANG_TIDY_ARGS[*]}"
print_delim

while IFS= read -r FILE_METADATA; do
	FILE_PATH=$(jq -r '.file' <<<"$FILE_METADATA")

	if [ "$CLANG_TIDY_FILE_EXCLUDE_REGEX" != "$UNSET_VALUE" ] && \
	grep -q -E -- "$CLANG_TIDY_FILE_EXCLUDE_REGEX" <<<"$FILE_PATH" &>/dev/null; then
		printf "Skipping file %s.\n" "$FILE_PATH"
		print_delim
		continue
	fi

	printf "Checking file %s...\n" "$FILE_PATH"
	if ! "$CLANG_TIDY" "${CLANG_TIDY_ARGS[@]}" \
		"$FILE_PATH" 2>&1; then
		CHECK_FAIL="true"
	fi

	print_delim

done < <(jq -c '.[]' "$CLANG_TIDY_COMPILE_COMMANDS_PATH")

if [ "$CHECK_FAIL" = "true" ]; then
	printf "### clang-tidy quality check FAIL ###\n"
	exit 1
else
	printf "### clang-tidy quality check SUCCESS ###\n"
	exit 0
fi
