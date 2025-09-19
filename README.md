# Clang Tidy Check

A fast and lightweight **GitHub Action** for automated C++ code quality assessment using
the [clang-tidy](https://clang.llvm.org/extra/clang-tidy/) static analysis tool. Designed to integrate seamlessly into
your **GitHub Workflows** for continuous code quality monitoring.

## Supported Platforms

This action currently supports **Ubuntu** runners only (including `ubuntu-latest` and `ubuntu-22.04`).

## Behavior

The action processes all files listed in your `compile_commands.json` compilation database with **clang-tidy**,
providing detailed output for each file checked.

Action will fail with exit code 1 if any **clang-tidy** errors occur.

## Arguments

### `version`: \<string\> (optional)

Specifies the **clang-tidy** version to use.

- **Default:** `'__UNSET__'`
- **Example:** `'16'`, `'18'`, `'20'`

If set to `'__UNSET__'`, default version of clang-tidy will be used.

For the list of supported versions on your runner, please, refer
to [GitHub Actions Runner Images](https://github.com/actions/runner-images)
and [Ubuntu Packages](https://packages.ubuntu.com/plucky/clang-tidy).

### `compile-commands-path`: \<string\> (required)

Path to your [compile_commands.json](https://clang.llvm.org/docs/JSONCompilationDatabase.html) compilation database.

- **Example:** `'./build/compile_commands.json'`

Other types of compilation databases are not currently supported.

### `file-exclude-regex`: \<string\> (optional)

Extended regular expression to exclude specific files from checking.

- **Default:** `'__UNSET__'`
- **Example:** `'/build/|/third_party/'`

If set to `'__UNSET__'`, no files will be excluded from check.

### `checks`: \<string\> (optional)

Comma-separated list of checks to enable or disable. Uses the same format as **clang-tidy** `--checks=` option.

- **Default:** `'__UNSET__'`
- **Example:** `'cppcoreguidelines-*, modernize-*, -readability-identifier-length'`

If set to `'__UNSET__'`, option will not be passed to **clang-tidy**.

### `warnings-as-errors`: \<string\> (optional)

Comma-separated list of warnings to treat as errors. Uses the same format as **clang-tidy** `--warnings-as-errors=`
option.

- **Default:** `'__UNSET__'`
- **Example:** `'cppcoreguidelines-*, modernize-use-nullptr'`

If set to `'__UNSET__'`, option will not be passed to **clang-tidy**.

### `config`: \<string\> (optional)

Inline configuration in YAML/JSON format. Uses the same format as **clang-tidy** `--config=` option.

- **Default:** `'__UNSET__'`
- **Example:** `'{ Checks: "modernize-*, -modernize-use-trailing-return-type" }'`

If set to `'__UNSET__'`, option will not be passed to **clang-tidy**.

### `config-file`: \<string\> (optional)

Path to a `.clang-tidy` file or custom configuration file. Uses the same format as **clang-tidy** `--config-file=` option.

- **Default:** `'__UNSET__'`
- **Example:** `'./.clang-tidy'`, `'./config/my-clang-tidy-config'`

If set to `'__UNSET__'`, option will not be passed to **clang-tidy**.

### `extra-args`: \<string\> (optional)

Additional arguments to pass directly to **clang-tidy**.

- **Default:** `'__UNSET__'`
- **Example:** `'--quiet --format-style=file'`

If set to `'__UNSET__'`, no additional options will be passed to **clang-tidy**.

## Output

The action provides following outputs:

- Individual file checking status
- **clang-tidy** warnings and errors
- Final summary (SUCCESS/FAIL)

## Examples

### Example With All Options

In your **GitHub Workflow:**

```yml
- name: Run clang-tidy-check
  uses: T-im4i-k/clang-tidy-check@v3
  with:
    version: '18'
    compile-commands-path: './build/compile_commands.json'
    file-exclude-regex: '/build/|/third_party/'
    checks: 'cppcoreguidelines-*, modernize-*, -readability-identifier-length'
    warnings-as-errors: 'cppcoreguidelines-*'
    config-file: './.clang-tidy'
    extra-args: '--quiet'
```

### Minimal Working Example

In your **GitHub Workflow:**

```yml
- name: Run clang-tidy check
  uses: T-im4i-k/clang-tidy-check@v3
  with:
    compile-commands-path: './build/compile_commands.json'
```