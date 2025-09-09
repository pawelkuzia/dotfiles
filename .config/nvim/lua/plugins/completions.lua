return {
    -- LuaSnip + friendly snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- nvim-cmp (wymagany dla codeium.nvim i blink.cmp)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({})
        end,
    },

    -- Codeium (Lua version)
    {
        "Exafunction/codeium.nvim",
        lazy = true,
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local codeium = require("codeium")
            codeium.setup({})

            -- Skróty do akceptacji / cyklowania / czyszczenia AI
            vim.keymap.set("i", "<C-g>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<A-r>", function()
                return vim.fn 
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<C-,>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true })

            vim.keymap.set("i", "<C-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true })
        end,
    },

    -- Blink CMP
    {
        "saghen/blink.cmp",
        dependencies = { "Exafunction/codeium.nvim", "rafamadriz/friendly-snippets" },
        version = "1.*",
        event = "InsertEnter",
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "codeium" },
                providers = {
                    codeium = { name = "Codeium", module = "codeium.blink", async = true },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
