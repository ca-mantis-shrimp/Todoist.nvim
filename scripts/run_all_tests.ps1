# Assumes you are running from the root directory of the project
# Requires the Plenary Plugin to be installed in Neovim
# and the `tree-sitter` cli is available in your PATH
# and the `ajv` cli is available in your PATH

# Run Lua Tests
nvim --headless -c "PlenaryBustedDirectory tests/"

# Run TreeSitter Tests
cd tree-sitter-projects/
tree-sitter test
cd ../

# Json Schema Tests
ajv compile -s schemas/todoist_sync_schema.json --spec=draft2020
ajv test -s .\schemas\todoist_sync_schema.json -d .\tests\schema\example_todoist_sync_response.json --valid --spec=draft2020
