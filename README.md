# 🖥️ Operating Systems — Programming Assignment 01

> ⭐ **Note:** This README is intended as a practical reference/notes document for the complete assignment workflow.

> **A practical C/Linux project covering compilation, libraries, Make, Git, documentation, and software releases.**

![Language](https://img.shields.io/badge/Language-C-blue)
![Platform](https://img.shields.io/badge/Platform-Linux%20%2F%20WSL-orange)
![Build](https://img.shields.io/badge/Build-Make-green)
![Version](https://img.shields.io/badge/Final-v0.4.1--final-purple)

---

## 📌 Overview

This repository contains the work completed for **Operating Systems Programming Assignment 01**.

The assignment focuses on the complete workflow of building and releasing a multi-file C project:

- Modular C programming using `.h` and `.c` files
- Build automation with **Make**
- Static libraries (`.a`)
- Dynamic/shared libraries (`.so`)
- Linking and binary analysis
- Linux manual pages
- Installation through a Makefile
- Git branching, merging, tagging, and GitHub Releases

The project implements a small utility library named **`libmyutils`** containing string and file-processing functions, together with a driver program that tests them.

### 🗺️ Assignment Roadmap

**01** 🧱 Setup → **02** 🔨 Make → **03** 📦 Static Library → **04** 🔗 Dynamic Library → **05** 📚 Man Pages & Installation → **🎯 Final Release**

---

## 📂 Project Structure

```text
BSDSF24M048-OS-A01/
│
├── src/
│   ├── main.c
│   ├── mystrfunctions.c
│   └── myfilefunctions.c
│
├── include/
│   ├── mystrfunctions.h
│   └── myfilefunctions.h
│
├── lib/
│   ├── libmyutils.a
│   └── libmyutils.so
│
├── bin/
│   ├── client
│   ├── client_static
│   └── client_dynamic
│
├── obj/
│   ├── main.o
│   ├── mystrfunctions.o
│   └── myfilefunctions.o
│
├── man/
│   └── man3/
│       ├── mystrlen.3
│       ├── mystrcpy.3
│       ├── mystrncpy.3
│       ├── mystrcat.3
│       ├── wordCount.3
│       └── mygrep.3
│
├── test.txt
├── Makefile
├── REPORT.md
└── README.md
```

---

---

# 🧱 Feature 1 — Project Scaffolding & Version Control

### 🎯 Goal

Create a professional C project structure and put it under Git/GitHub version control.

### ✅ What we did

1. Created a public GitHub repository named:

```text
BSDSF24M048-OS-A01
```

2. Cloned the repository into the Linux/WSL environment.

3. Created the required directories:

```text
src/
include/
lib/
bin/
obj/
```

4. Created:

```text
REPORT.md
README.md
```

5. Added the initial project structure to Git and pushed it to GitHub.

### 💻 Commands Used

```bash
git clone <GITHUB_REPOSITORY_URL>

cd BSDSF24M048-OS-A01

mkdir -p src include lib bin obj

touch REPORT.md README.md

git status

git add .

git commit -m "Create initial project structure"

git push origin main
```

### 📖 Important Definitions

**Git:** A distributed version-control system used to track changes in source code.

**GitHub:** A platform for hosting Git repositories and collaborating on software projects.

**Repository:** A project managed by Git. It contains the project's files and its complete version history.

**Commit:** A saved snapshot of changes in a Git repository.

**Branch:** An independent line of development used to work on a feature without directly modifying another branch.

---

---

# 🔨 Feature 2 — Multi-file Project Using Make

### Goal

Convert the project into a modular multi-file C program and automate compilation using a Makefile.

### 🧩 What we created

Two modules were implemented.

### String module

```text
include/mystrfunctions.h
src/mystrfunctions.c
```

Functions:

```c
mystrlen()
mystrcpy()
mystrncpy()
mystrcat()
```

### File module

```text
include/myfilefunctions.h
src/myfilefunctions.c
```

Functions:

```c
wordCount()
mygrep()
```

The driver program was:

```text
src/main.c
```

A test file was also created:

```text
test.txt
```

### ⚙️ Makefile

The Makefile automated the compilation of the source files and produced:

```text
bin/client
```

### 🌿 Git Workflow

A separate branch was created:

```bash
git switch -c multifile-build
```

After implementation and testing:

```bash
git add .
git commit -m "Implement multifile C project using make"
git push -u origin multifile-build
```

### ▶️ Build and Run

```bash
make
./bin/client
```

### 🧹 Clean the Build

```bash
make clean
```

### Tag

```bash
git tag -a v0.1.1-multifile -m "Version 1.0 - Basic multifile compilation"

git push origin v0.1.1-multifile
```

A GitHub Release was then created with:

```text
bin/client
```

### 📖 Important Definitions

**Header file (`.h`):** Contains declarations such as function prototypes that can be shared between source files.

**Source file (`.c`):** Contains the actual implementation of functions.

**Make:** A build automation utility that determines what needs to be compiled and executes the required commands.

**Makefile:** A file containing rules that tell `make` how to build a project.

**Compilation:** Converting C source code into object code.

**Linking:** Combining object files and libraries to create the final executable.

---

---

# 📦 Feature 3 — Static Library

### 🎯 Goal

Create a reusable static library from the utility functions and link the client program against it.

## Step 1 — Merge Feature 2

```bash
git switch main
git pull origin main

git merge multifile-build

git push origin main
```

## Step 2 — Create the Static Build Branch

```bash
git switch -c static-build
```

## Step 3 — Compile Object Files

```bash
gcc -Wall -Wextra -Iinclude -c src/mystrfunctions.c -o obj/mystrfunctions.o

gcc -Wall -Wextra -Iinclude -c src/myfilefunctions.c -o obj/myfilefunctions.o

gcc -Wall -Wextra -Iinclude -c src/main.c -o obj/main.o
```

## Step 4 — Create the Static Library

```bash
ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o

ranlib lib/libmyutils.a
```

The resulting library was:

```text
lib/libmyutils.a
```

## Step 5 — Build and Run

```bash
make

./bin/client_static
```

The executable successfully tested all string and file functions.

## Step 6 — Analyze the Library and Executable

### List archive contents

```bash
ar -t lib/libmyutils.a
```

### Inspect object-file symbols

```bash
nm obj/mystrfunctions.o
```

### Inspect symbols in the final executable

```bash
nm bin/client_static | grep -E "mystrlen|mystrcpy|mystrncpy|mystrcat|wordCount|mygrep"
```

### Inspect symbol information with readelf

```bash
readelf -s bin/client_static | grep mystrlen
```

## Step 7 — Commit and Push

```bash
git add .

git commit -m "Build and link static library"

git push -u origin static-build
```

## Step 8 — Tag

```bash
git tag -a v0.2.1-static -m "Version 0.2.1 - Static Library Build"

git push origin v0.2.1-static
```

The GitHub Release contained:

```text
lib/libmyutils.a
bin/client_static
```

### 📖 Important Definitions

**Object file (`.o`):** Compiled machine-code output that has not yet been linked into a final executable.

**Static library (`.a`):** An archive of object files. Required library code is copied into the executable during static linking.

**`ar`:** Utility used to create and manage archive files such as static libraries.

**`ranlib`:** Creates or updates the symbol index of an archive.

**`nm`:** Displays symbols contained in object files, libraries, and executables.

**`readelf`:** Displays detailed information about ELF files, including sections and symbols.

**Static linking:** Library code is included in the final executable at link time.

---

---

# 🔗 Feature 4 — Dynamic Library

### 🎯 Goal

Create a shared/dynamic library and dynamically link the client program against it.

## Step 1 — Merge Static Build

```bash
git switch main
git pull origin main

git merge static-build

git push origin main
```

## Step 2 — Create Dynamic Build Branch

```bash
git switch -c dynamic-build
```

## Step 3 — Compile Position-Independent Object Files

```bash
gcc -Wall -Wextra -fPIC -Iinclude -c src/mystrfunctions.c -o obj/mystrfunctions.o

gcc -Wall -Wextra -fPIC -Iinclude -c src/myfilefunctions.c -o obj/myfilefunctions.o

gcc -Wall -Wextra -Iinclude -c src/main.c -o obj/main.o
```

## Step 4 — Create the Shared Library

```bash
gcc -shared -o lib/libmyutils.so obj/mystrfunctions.o obj/myfilefunctions.o
```

The resulting library was:

```text
lib/libmyutils.so
```

## Step 5 — Build and Run

```bash
make
```

The dynamic executable was:

```text
bin/client_dynamic
```

The first execution intentionally demonstrated the shared-library lookup problem:

```bash
./bin/client_dynamic
```

The loader could not find `libmyutils.so`.

We then added the project's library directory to the library search path:

```bash
export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
```

Verify:

```bash
echo $LD_LIBRARY_PATH
```

Run again:

```bash
./bin/client_dynamic
```

The program then executed successfully.

## Step 6 — Verify Dynamic Dependencies

```bash
ldd bin/client_dynamic
```

This showed that `client_dynamic` depends on:

```text
libmyutils.so
```

## Step 7 — Commit and Push

```bash
git add .

git commit -m "Build and link dynamic library"

git push -u origin dynamic-build
```

## Step 8 — Tag

```bash
git tag -a v0.3.1-dynamic -m "Version 0.3.1 - Dynamic Library Build"

git push origin v0.3.1-dynamic
```

The GitHub Release contained:

```text
bin/client_dynamic
lib/libmyutils.so
```

### 📖 Important Definitions

**Dynamic/shared library (`.so`):** A library loaded by the dynamic loader when a program runs instead of copying its code directly into the executable.

**`-fPIC`:** Generates Position-Independent Code, allowing shared-library code to work correctly regardless of where the library is loaded into memory.

**`-shared`:** Tells GCC to create a shared library.

**`LD_LIBRARY_PATH`:** An environment variable that specifies additional directories where the dynamic loader searches for shared libraries.

**`ldd`:** Displays the shared-library dependencies of an executable.

**Dynamic linking:** The executable references shared-library code, which is loaded at runtime.

### ⚖️ Static vs Dynamic Linking

| Static | Dynamic |
|---|---|
| Uses `.a` | Uses `.so` |
| Library code is included in executable | Library remains separate |
| Executable is generally larger | Executable is generally smaller |
| No shared library needed at runtime | Shared library must be available |
| Library update requires relinking | Shared library can be updated separately |

---

---

# 📚 Feature 5 — Man Pages & Installation

### 🎯 Goal

Document the library functions using Linux man pages and add an installation target to the Makefile.

## Step 1 — Merge Dynamic Build

```bash
git switch main
git pull origin main

git merge dynamic-build

git push origin main
```

## Step 2 — Create Documentation Branch

```bash
git switch -c man-pages
```

## Step 3 — Create Man Page Directory

```bash
mkdir -p man/man3
```

Six man pages were created:

```text
man/man3/mystrlen.3
man/man3/mystrcpy.3
man/man3/mystrncpy.3
man/man3/mystrcat.3
man/man3/wordCount.3
man/man3/mygrep.3
```

Each page contains the required sections:

```text
.TH
.SH NAME
.SH SYNOPSIS
.SH DESCRIPTION
.SH AUTHOR
```

## Preview a Man Page

```bash
man -l man/man3/mystrlen.3
```

## Step 4 — Installation Target

The Makefile was updated with an `install` target.

The installation command was:

```bash
sudo make install
```

The installation copied the executable and man pages to system locations.

## Step 5 — Test Installation

Run the installed program:

```bash
client
```

View a man page:

```bash
man mystrlen
```

Both tests worked successfully.

## Step 6 — Commit and Push

```bash
git status

git add man/ Makefile

git commit -m "Add man pages and installation target"

git push -u origin man-pages
```

## Step 7 — Final Annotated Tag

```bash
git tag -a v0.4.1-final -m "Version 0.4.1 - Final Build"

git push origin v0.4.1-final
```

A final GitHub Release was created using:

```text
Tag: v0.4.1-final
Title: Version0.4.1: Final Build
```

Final release assets:

```text
bin/client_dynamic
lib/libmyutils.so
```

### 📖 Important Definitions

**Man page:** Standard Linux documentation displayed through the `man` command.

**groff:** A document-formatting system used by traditional Unix/Linux manual pages.

**`.TH`:** Defines the man-page title/header.

**`.SH`:** Defines a major section in a man page.

**`man`:** Command used to read Linux manual pages.

**`sudo`:** Executes a command with elevated privileges, which is required when installing files into system directories.

---

---

# 🚀 Final Git Workflow

After Feature 5 was completed, the documentation branch was merged into `main`.

```bash
git switch main

git pull origin main

git merge man-pages

git push origin main
```

All feature branches were pushed to GitHub:

```bash
git push origin multifile-build
git push origin static-build
git push origin dynamic-build
git push origin man-pages
```

## Final Repository Verification

Check the working tree:

```bash
git status
```

Expected:

```text
nothing to commit, working tree clean
```

Check branches:

```bash
git branch -a
```

Check tags:

```bash
git tag
```

Expected tags:

```text
v0.1.1-multifile
v0.2.1-static
v0.3.1-dynamic
v0.4.1-final
```

View the complete history:

```bash
git log --oneline --decorate --graph --all
```

---

---

# 🌿 Git Concepts Used Throughout the Assignment

## `git switch`

Changes the current branch.

```bash
git switch main
```

Create and switch to a new branch:

```bash
git switch -c static-build
```

## `git add`

Adds changes to the staging area.

```bash
git add .
```

## `git commit`

Creates a permanent snapshot of staged changes.

```bash
git commit -m "Build and link static library"
```

## `git push`

Uploads local commits to the remote GitHub repository.

```bash
git push origin main
```

For the first push of a new branch:

```bash
git push -u origin branch-name
```

The `-u` option sets the upstream branch, so later `git push` can be used directly.

## `git pull`

Downloads changes from the remote repository and integrates them into the current branch.

```bash
git pull origin main
```

## `git merge`

Combines the history of another branch into the current branch.

```bash
git merge dynamic-build
```

## Git Tag

A tag gives a permanent name to an important commit, commonly a release version.

Annotated tag:

```bash
git tag -a v0.4.1-final -m "Version 0.4.1 - Final Build"
```

Push a tag:

```bash
git push origin v0.4.1-final
```

## GitHub Release

A GitHub Release is a published version of the project associated with a Git tag. Compiled binaries and libraries can be attached so users can download ready-to-use files.

---

---

# 🛠️ Build Tools and Their Roles

| Tool | Purpose |
|---|---|
| `gcc` | Compiles and links C programs |
| `make` | Automates the build process |
| `ar` | Creates/manages static library archives |
| `ranlib` | Creates the archive symbol index |
| `nm` | Displays symbols |
| `readelf` | Analyzes ELF files |
| `ldd` | Shows dynamic-library dependencies |
| `man` | Displays manual pages |
| `git` | Version control |
| GitHub | Remote repository and release hosting |

---

---

# 🎯 Final Outcome

The assignment progressed from a basic multi-file C program to a more complete software-project workflow:

```text
C Source Files
      ↓
Multi-file Build
      ↓
Makefile
      ↓
Static Library (.a)
      ↓
Dynamic Library (.so)
      ↓
Binary Analysis
      ↓
Man Pages
      ↓
Installation
      ↓
Git Branches + Tags
      ↓
GitHub Releases
```

The final project demonstrates the complete process of **developing, building, analyzing, documenting, installing, versioning, and releasing a C project on Linux**.

---

## 🏷️ Final Git Tags

```text
v0.1.1-multifile   → Multi-file build
v0.2.1-static      → Static library
v0.3.1-dynamic     → Dynamic library
v0.4.1-final       → Final build
```

## 🌿 Final Branches

```text
main
multifile-build
static-build
dynamic-build
man-pages
```

---

## 👨‍💻 Author

**Subhan Ahmad**

Operating Systems — Programming Assignment 01

> ⭐ **Note:** This README is intended as a practical reference/notes document for the complete assignment workflow.
