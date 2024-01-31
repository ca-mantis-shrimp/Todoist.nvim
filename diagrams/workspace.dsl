workspace {
    model {
        user = person "Neovim Enjoyer"
        neovim_platform = softwareSystem "Neovim" {
            editor = container "Neovim Base" {
                user -> this "Uses"
            }
            plugin = container "Todoist.nvim" {
                filetype = component "Custom Todoist Filetype" 
                request = component "Curl Requests" 
                dictionary_model = component "Dictionary-Based internal Representation of Todoist Items"
                tree = component "Tree Model and View Functions"


                editor -> this "Utilizes Commands"
            }
        }
    }

    views {
        systemContext neovim_platform {
            include *
            autolayout lr
        }

        container neovim_platform {
            include *
            autolayout lr
        }

        component plugin {
            include *
            autolayout lr
        }

        theme default
    }

}
