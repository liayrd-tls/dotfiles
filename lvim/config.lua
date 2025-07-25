-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- ciscord: https://discord.com/invite/Xb9B4Ny
--
local lspconfig = require("lspconfig")

lvim.plugins = {
    { "Hoffs/omnisharp-extended-lsp.nvim" }, -- покращена підтримка LSP
    { "mfussenegger/nvim-dap" },             -- дебагер},
    { "navarasu/onedark.nvim" },
    { "folke/tokyonight.nvim" },
    { "marko-cerovac/material.nvim" },
    { "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
    { "Mofiqul/dracula.nvim" },
    { "github/copilot.vim" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- іконки
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                window = {
                    position = "left",
                    width = 30,
                    mappings = {
                        ["<space>"] = "none", -- вимкнути пробіл для вибору
                        ["<leader>"] = "none",
                    },
                },
                filesystem = {
                    filtered_items = {
                        visible = true, -- true = показує приховані файли, але фільтрує в списку
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_by_name = {
                            ".DS_Store",
                        },
                        hide_by_pattern = {
                            "*.meta", -- ← ховає всі .meta файли
                        },
                    },
                },
            })
        end,
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                enabled = true,
                execution_message = {
                    message = function()
                        return "💾 Saved all"
                    end,
                    dim = 0.18,
                    cleaning_interval = 1000,
                },
                trigger_events = { "InsertLeave", "TextChanged" },
                -- ✨ Ось головне: ця функція викликає :wa замість :w
                write_all_buffers = true,
                write_command = "wa", -- це замінює звичайне :w
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")
                    return fn.getbufvar(buf, "&modifiable") == 1
                        and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
                end,
            })
        end,
    },
}

-- transperent background
lvim.transparent_window = true

-- variables for colorscheme
function custom_colors()
    return {
        bg = "#2b2d30",             -- Background color
        fg = "#abb2bf",             -- Foreground color
        accent = "#61afef",         -- Accent color
        error = "#e06c75",          -- Error color
        warning = "#e5c07b",        -- Warning color
        info = "#56b6c2",           -- Info color
        hint = "#98c379",           -- Hint color

        comment = "#85c46c",        -- Comment color
        keyword = "#6c95eb",        -- Keyword color
        namespace = "#c191ff",      -- Namespace color
        class = "#c191ff",          -- Class color
        property = "#bdbdbd",       -- Property color
        structure = "#e1bfff",      -- Structure color
        delegate = "#e1bfff",       -- Delegate color
        event = "#ed94c0",          -- Event color
        field = "#66c3cc",          -- Field color
        attribute = "#c191ff",      -- Attribute color
        method = "#39cc9b",         -- Method color
        number = "#ed94c0",         -- Number color
        local_variable = "#bdbdbd", -- Local variable color
        string = "#c9a26d",         -- String color
    }
end

lvim.autocommands = {
    {
        { "ColorScheme" },
        {
            pattern = "*",
            callback = function()
                local colors = custom_colors()
                --background
                -- vim.api.nvim_set_hl(0, "Normal", { bg = colors.bg, fg = colors.fg })
                -- @lsp.type.keyword.cs
                vim.api.nvim_set_hl(0, "@lsp.type.keyword.cs", { fg = colors.keyword })
                vim.api.nvim_set_hl(0, "@lsp.type.namespace.cs", { fg = colors.namespace })
                vim.api.nvim_set_hl(0, "@lsp.type.class.cs", { fg = colors.class })
                vim.api.nvim_set_hl(0, "@lsp.type.fieldName.cs", { fg = colors.field })
                vim.api.nvim_set_hl(0, "@lsp.type.parameter.cs", { fg = colors.property })
                vim.api.nvim_set_hl(0, "@lsp.type.punctuation.cs", { fg = colors.property })
                vim.api.nvim_set_hl(0, "@lsp.type.operator.cs", { fg = colors.property })
                vim.api.nvim_set_hl(0, "@lsp.type.method.cs", { fg = colors.method })
                vim.api.nvim_set_hl(0, "@lsp.type.struct.cs", { fg = colors.structure })
                vim.api.nvim_set_hl(0, "@lsp.type.string.cs", { fg = colors.string })
                vim.api.nvim_set_hl(0, "@lsp.type.number.cs", { fg = colors.number })
                vim.api.nvim_set_hl(0, "@lsp.type.comment.cs", { fg = colors.comment, italic = true })
                vim.api.nvim_set_hl(0, "@lsp.type.enum.cs", { fg = colors.structure })
                vim.api.nvim_set_hl(0, "@lsp.type.enumMember.cs", { fg = colors.field })
            end,

        },
    },
}

lspconfig.omnisharp.setup({
    cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    enable_import_completion = true,
    organize_imports_on_format = true,
})

vim.filetype.add({
    extension = {
        cs = "cs",
    },
})

lvim.keys.normal_mode["f"] = require("telescope.builtin").live_grep
-- telescope buffer find
lvim.keys.normal_mode["<C-q>"] = require("telescope.builtin").buffers
lvim.keys.visual_mode["<J>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<K>"] = ":m '<-2<CR>gv=gv"
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,

        -- Кастомний форматтер для C#
        {
            method = null_ls.methods.FORMATTING,
            filetypes = { "cs" },
            generator = null_ls.generator({
                command = "dotnet-format",
                args = { "--folder", "." },
                to_temp_file = false,
                from_stderr = false,
            }),
        },
    },
})

-- Neo-tree configuration
lvim.builtin.nvimtree.active = false
lvim.keys.normal_mode["<C-n>"] = ":Neotree toggle<CR>"
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argv(0) == "" then
            vim.cmd("Neotree show")
        end
    end,
})

lvim.format_on_save = true
lvim.autosave = true
