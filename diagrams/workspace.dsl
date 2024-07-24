workspace {
    model {
        user = person "Neovim Enjoyer"
            neovim_platform = softwareSystem "Neovim" {
                editor = container "Neovim Base" {
                    user -> this "Uses"
                }
                plugin = container "Todoist.nvim" {
                    init = component "initalization"
                        api = component "API"
                        config = component "Configuration"
                        request = component "Query" 
                        dictionary_model = component "Model"
                        tree = component "Tree"
                        buffer = component "Buffer"
                        window = component "Window"
                        commands = component "Commands"
                        filetype = component "Filetype" 

                        init -> api "calls"
                        api -> config "Imports"
                        api -> request "Imports"
                        api -> dictionary_model "Imports"
                        api -> tree "Imports"
                        api -> buffer "Imports"
                        api -> window "Imports"
                        buffer -> filetype "applies filetype, automatically setting off custom settings"
                        commands -> api "calls"

                        request -> config  "implicitly takes API key from config Object"
                        dictionary_model -> request "must understand how to convert JSON response into dictionary"
                        tree -> dictionary_model "converts dictionary into tree, and lines based on that"
                        buffer -> tree "represents tree in buffer as lines of text"
                        window -> buffer "represents buffer in window, either split or floating"


                        editor -> this "Utilizes Commands"
                }
                treesitter-parser = container "Project Treesitter Parser" {
                    grammar = component "Grammar Definition"
                        queries = component "Queries"
                        parser = component "Generated Parser"
                        spec = component "Grammar Specification"

                        queries -> parser "uses"
                        parser -> spec "conforms to specified format"
                        grammar -> parser "generates"
                }
                treesitter-library = container "TreeSitter Plugin" {
                    parser_list = component "Parser Library"
                    highlighter = component "Highlighting library for TS"
                    indent = component "TS-based indentation"
                    folder = component "TS-based folds"
                }
                highlighter -> queries "references"
                indent -> queries "references"
                folder -> queries "references"
                parser_list -> parser "installs"
                editor -> treesitter-library "installs"

            }
    }

        views {
            systemContext neovim_platform {
                include *
            }

            container neovim_platform {
                include *
            }

            component plugin {
                include *
            }
            component treesitter-parser {
                include *
            }
            component treesitter-library {
                include *
            }

            theme default
        }
}
