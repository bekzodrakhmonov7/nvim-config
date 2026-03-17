return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                -- Choose your strictness: "off", "basic", "standard", "recommended", "all"
                                typeCheckingMode = "recommended",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- Tell conform to use Ruff for formatting and organizing imports
                python = { "ruff_format", "ruff_organize_imports" },
            },
        },
    },
}
