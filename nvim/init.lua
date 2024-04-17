-- Behaviour
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300

-- Apperance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "nzzzv")
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")

-- Tab title for wezterm
vim.api.nvim_create_autocmd({"BufEnter"}, {
    callback = function(event)
        local title = "vim"
        if event.file ~= "" then
            title = string.format("%s", vim.fs.basename(event.file))
        end

        vim.fn.system({"wezterm", "cli", "set-tab-title", title})
    end,
})
