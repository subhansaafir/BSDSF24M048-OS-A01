# Operating Systems Programming Assignment 01

## Feature 2 — Multi-file Project using Make

### Q1. Explain the linking rule in this part's Makefile:
### `$(TARGET): $(OBJECTS)`.
### How does it differ from a Makefile rule that links against a library?

The rule `$(TARGET): $(OBJECTS)` tells Make that the final target depends on the object files. The object files are then linked together to create the final executable.

In our multi-file project, all source files are compiled and linked directly to create `bin/client`. No separate library is used.

When linking against a library, the executable is linked with a library using options such as `-L` to specify the library directory and `-l` to specify the library. In that case, the library contains reusable compiled functions instead of directly listing all source/object files in the final linking command.

### Q2. What is a git tag and why is it useful in a project?
### What is the difference between a simple tag and an annotated tag?

A Git tag is a name attached to a specific commit. It is useful for marking important versions or stable points in a project's history.

A simple tag is a lightweight pointer to a commit. An annotated tag is a separate Git object that contains additional information such as the tag message, tagger, and date.

In this feature, we created the annotated tag `v0.1.1-multifile` to mark our multi-file build version.

### Q3. What is the purpose of creating a Release on GitHub?
### What is the significance of attaching binaries like `client` to it?

A GitHub Release provides a way to publish a particular version of a project based on a Git tag. It allows users to obtain a specific stable version of the project.

Attaching the compiled `bin/client` executable allows users to download and run the already-built program without compiling the source code themselves.


## Feature 3 — Creating and Using Static Library

### Q1. Compare the Makefile from Part 2 and Part 3.

In Part 2, the Makefile directly compiled all the source files and linked them together to create the executable `bin/client`.

In Part 3, the Makefile was modified to first compile the utility source files into object files and then package them into the static library `lib/libmyutils.a`. The `main.o` object file is then linked against this static library to create `bin/client_static`.

Therefore, Part 2 directly links the source files, while Part 3 uses a reusable static library.

### Q2. What is the purpose of the `ar` command? Why is `ranlib` often used immediately after it?

The `ar` command is used to create and manage archive files. In this project, it combines the object files `mystrfunctions.o` and `myfilefunctions.o` into the static library `libmyutils.a`.

The `ranlib` command creates or updates the symbol index of the archive. This allows the linker to efficiently find the required functions inside the static library.

### Q3. When you run `nm` on your `client_static` executable, are the symbols for functions like `mystrlen` present? What does this tell you about how static linking works?

Yes, symbols for functions such as `mystrlen` are present in the `client_static` executable.

This shows that the required code from the static library was included in the final executable during the linking process. In static linking, the required library code becomes part of the executable itself.
