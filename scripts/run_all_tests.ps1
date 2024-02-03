# Assumes you are running from the root directory of the project
# Requires the Plenary Plugin to be installed in Neovim
# and the `tree-sitter` cli is available in your PATH

# Run Lua Tests
nvim --headless -c "PlenaryBustedDirectory tests/"

# Run TreeSitter Tests
cd tree-sitter-projects/
tree-sitter test
cd ../

