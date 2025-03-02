return {
    -- integrated with lazydocker
    {
        "mgierada/lazydocker.nvim",
        dependencies = { "akinsho/toggleterm.nvim" },
        config = function()
            require("lazydocker").setup({
                border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
            })
        end,
        event = "BufRead",
        keys = {
            {
                "<leader>ld",
                function()
                    require("lazydocker").open()
                end,
                desc = "Open Lazydocker floating window",
            },
        },
    },
    -- integrated with yazi
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
        },
    },
}
