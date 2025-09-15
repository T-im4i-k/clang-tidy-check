# Clang Tidy Check

A fast and lightweight **GitHub Action** for automated C++ code quality assessment using
the [clang-tidy](https://clang.llvm.org/extra/clang-tidy/) static analysis tool. Designed to integrate seamlessly into
your **GitHub Workflows** for continuous code quality monitoring.

## Supported Platforms

This action currently supports **Ubuntu** runners only (including `ubuntu-latest` and `ubuntu-22.04`).

## Behavior

The action processes all files listed in your `compile_commands.json` compilation database with **clang-tidy**,
providing detailed output for each file checked.

## Arguments

### `version`

Version of **clang-tidy** that will be used.

- **Default:** `'18'`
- **Optional.**

### `compile-commands-path`

Path to your [compile_commands.json](https://clang.llvm.org/docs/JSONCompilationDatabase.html).

- **Required.**

### `checks`

Comma-separated list of checks to enable/disable.

- Same as **clang-tidy** `--checks=`.
- **Default:** `''`
- **Optional.** Specify `''` to ignore.

### `warnings-as-errors`

Comma-separated list of warnings that will be treated as errors.

- Same as **clang-tidy** `--warnings-as-errors=`.
- **Default:** `'*'`
- **Optional.** Specify `''` to ignore.

### `config-file`

Path to custom `.clang-tidy` config file.

- Same as **clang-tidy** `--config-file=`.
- **Default:** `''`
- **Optional.** Specify `''` to ignore.

### `extra-args`

Any additional **clang-tidy** arguments.

- **Default:** `''`
- **Optional.** Specify `''` to ignore.

## Output

The action provides following outputs:

- Individual file checking status
- **clang-tidy** warnings and errors
- Final summary (SUCCESS/FAIL)

Action will fail with exit code 1 if any **clang-tidy** errors occur.

## Examples

### Example With All Options

In your **GitHub Workflow:**

```yml
- name: Run clang-tidy-check
  uses: T-im4i-k/clang-tidy-check@v1
  with:
    version: '18'
    compile-commands-path: './path/to/compile_commands.json'
    checks: 'cppcoreguidelines-*, modernize-*, -readability-identifier-length'
    warnings-as-errors: 'cppcoreguidelines-*'
    config-file: './path/to/.clang-tidy'
    extra-args: '--quiet'
```

### Minimal Working Example

In your **GitHub Workflow:**

```yml
- name: Run clang-tidy check
  uses: T-im4i-k/clang-tidy-check@v1
  with:
    compile-commands-path: './path/to/compile_commands.json'
```