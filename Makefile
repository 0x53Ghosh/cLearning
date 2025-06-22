# Compiler and flags
CC = clang
CFLAGS = -Wall -Wextra -g

# Source and output folders
SRC_DIR = src
BIN_DIR = bin

# Ensure binary directory exists
$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

# List of source files (e.g., main.c → main)
SOURCES := $(basename $(notdir $(wildcard $(SRC_DIR)/*.c)))
TARGETS := $(addprefix $(BIN_DIR)/,$(SOURCES))

# Rule: build each target from src
$(BIN_DIR)/%: $(SRC_DIR)/%.c | $(BIN_DIR)
	@$(CC) $(CFLAGS) $< -o $@

# Rule: call like 'make main'
$(SOURCES): %: $(BIN_DIR)/%
	@:

# Run: make run-main → builds and runs bin/main
run-%: %
	@./$(BIN_DIR)/$*

# Debug: make debug-main → builds and launches gdb
debug-%: %
	@gdb $(BIN_DIR)/$*

# Clean rule
clean:
	@rm -f $(BIN_DIR)/*
	@echo "🧹 Cleaned $(BIN_DIR)"

.PHONY: clean run-% debug-%
