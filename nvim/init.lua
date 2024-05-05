-- Behaviour
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 500

-- Apperance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "nzzzv")
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>fe", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>fc", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Tab title for wezterm
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(event)
		local title = "vim"
		if event.file ~= "" then
			title = string.format("%s", vim.fs.basename(event.file))
		end

		vim.fn.system({ "wezterm", "cli", "set-tab-title", title })
	end,
})


-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {
			tabkey = "",
		},
	},
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "neotab.nvim", },
		keys = {
			{
				"<Tab>",
				function()
					return require("luasnip").jumpable(1)
					and "<Plug>luasnip-jump-next"
					or "<Plug>neotab-out"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
		},
	},
	"cohama/lexima.vim", -- Auto close paranthesis
	"iagorrr/noctis-high-contrast.nvim",
})
vim.cmd.colorscheme "noctishc"

-- LSP
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_setup = function(server)
	require("lspconfig")[server].setup({
		capabilities = lsp_capabilities,
		settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		}
	})
end

require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = { default_setup, },
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local neotab = require("neotab")
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				neotab.tabout()
			end
		end)
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})


-- Plugin keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
