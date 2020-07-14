#!/bin/bash --

# Running examples.

# Defining colours
BLUE='\033[1;34m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'
PURPLE='\033[1;35m'

# Exit immediately if a command exits with a non-zero status.
set -e

# Folder name
FOLDER=$(basename $PWD)

echo
echo -e "${CYAN}=== Preparing Example $PWD...${RESET}"
echo


echo
echo -e "${PURPLE}=== Checking Source Code Formatting${RESET} $PWD..."
echo
# Overwrite files with formatted content: -w
# Dry run: -n
dartfmt -w $(find bin lib test -name \*.dart 2>/dev/null)


# Analyze dart files
echo
echo -e "${BLUE}=== Analyzing $PWD...${RESET}"
echo

dartanalyzer \
    --fatal-warnings \
    --fatal-infos \
     $(find bin lib test -name \*.dart 2>/dev/null)


# Running benchmark
echo
echo -e "${GREEN}=== Running Example $PWD...${RESET}"
echo

dart ./bin/example.dart
