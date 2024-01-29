workspace {
    model {
        user = person "Neovim Enjoyer"
        softwareSystem = softwareSystem "Neovim" {
            editor = container "Neovim Base" {
                user -> this "Uses"
            }
            container "Plugin" {
                editor -> this "Runs Code"
            }
        }
    }

    views {
        systemContext softwareSystem {
            include *
            autolayout lr
        }

        container softwareSystem {
            include *
            autolayout lr
        }

        theme default
    }

}
