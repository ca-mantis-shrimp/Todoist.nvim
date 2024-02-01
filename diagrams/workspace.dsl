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
                project_spec = component "Project List Spec"
                treesitter_parser = component "Project List TreeSitter"

                init -> api "calls"
                api -> config "Imports"
                api -> request "Imports"
                api -> dictionary_model "Imports"
                api -> tree "Imports"
                api -> buffer "Imports"
                api -> window "Imports"
                buffer -> filetype "applies filetype, automatically setting off custom settings"
                treesitter_parser -> project_spec "conforms to specified format"
                filetype -> treesitter_parser "applies highlight groups to query outputs"
                commands -> api "calls"

                request -> config  "implicitly takes API key from config Object"
                dictionary_model -> request "must understand how to convert JSON response into dictionary"
                tree -> dictionary_model "converts dictionary into tree, and lines based on that"
                buffer -> tree "represents tree in buffer as lines of text"
                window -> buffer "represents buffer in window, either split or floating"


                editor -> this "Utilizes Commands"
            }
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

        theme default
    }

}
