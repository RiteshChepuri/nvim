vim.g.mapleader = " "

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"

-- Line Wrapping
vim.opt.wrap = false

-- Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Appearence
vim.opt.termguicolors = true

-- Scrolling
vim.opt.scrolloff = 10

-- Update
vim.opt.updatetime = 50

-- Window Split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Easy Escape
vim.keymap.set("i", "jj", "<ESC>", { desc = "Better Escape" })

-- Open Line above or below
vim.keymap.set("n", "<A-o>", "o<ESC>")
vim.keymap.set("n", "<A-O>", "O<ESC>")

-- Open Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Close a Buffer
vim.keymap.set("n", "<A-e>", vim.cmd.bd)

-- Clear searches
vim.keymap.set("n", "<ESC>", "<Cmd>noh<CR><ESC>")

-- Delete a character without copying into the register
vim.keymap.set("n", "x", '"_x')

-- Scroll Page down (Center the cursor)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Disable Space
vim.keymap.set("n", "<Space>", "<NOP>")

-- Keep The Search results in middle of the screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Replace the Current word within entire file from ThePrimeagen config
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Go to start or end of line easier from jdhao config
vim.keymap.set({ "n", "x" }, "H", "^")
vim.keymap.set({ "n", "x" }, "L", "g_")

-- Use Alt with h,j,k,l to navigate in insert mode without using Arrow keys
vim.keymap.set("i", "<A-h>", "<Left>")
vim.keymap.set("i", "<A-l>", "<Right>")
vim.keymap.set("i", "<A-j>", "<Up>")
vim.keymap.set("i", "<A-k>", "<Down>")

-- Shift text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when in a comment and you press o to go into a new line, don't make that line a comment line.
local comment_group = vim.api.nvim_create_augroup("fix comment enter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "o" })
		vim.opt.formatoptions:append({ "c" })
	end,
	group = comment_group,
	pattern = "*",
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"undotree",
		"DiffviewFiles",
		"vim",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	-- group = vim.api.nvim_create_augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Colorscheme
vim.cmd([[colorscheme industry]])
