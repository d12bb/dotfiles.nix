vim.g.mapleader = " "

local wk = require("which-key")

local telescope = require("telescope.builtin")
wk.register({
	f = {
		name = "Find (Telescope)",
		b = { telescope.buffers, "Buffers" },
		f = { telescope.find_files, "Find Files" },
		F = { telescope.file_browser, "File Browser" },
		g = { telescope.live_grep, "Live Grep" },
		G = { telescope.grep_string, "Grep" },
		h = { telescope.help_tags, "Vim Help" },
		m = { telescope.man_pages, "Man Pages" },
		q = { telescope.quickfix, "Quickfix list" },
		j = { telescope.jumplist, "Jumplist" },
		r = { telescope.lsp_references, "List References" },
		s = { telescope.lsp_document_symbols, "Document Symbols" },
		S = { telescope.lsp_workspace_symbols, "Workspace Symbols" },
	},
	s = { require("symbols-outline").toggle_outline, "Toggle Symbols Outline" },
}, { prefix = "<leader>" })

local lsbuf = vim.lsp.buf
wk.register({
	gd = { telescope.lsp_definitions, "Jump to Definition" },
	gtd = { telescope.lsp_type_definitions, "Jump to Definition of Type" },
	gD = { lsbuf.declaration, "Jump to Declaration" },
	gi = { telescope.lsp_implementations, "List Implementations" },
	gr = { telescope.lsp_references, "List References" },
	K = { lsbuf.hover, "Display Information" },
	["C-k"] = { lsbuf.signature_help, "Display Signature Help" },
	["<leader>c"] = {
		name = "Act on Code",
		c = { telescope.lsp_code_actions, "LSP Code Action" },
		r = { lsbuf.rename, "Rename Symbol Everywhere" },
		-- f = { lb.formatting, "Format File" }, TODO: more info needed
	},
	["<leader>w"] = {
		name = "LSP Workspace",
		a = { lsbuf.add_workspace_folder, "Add Folder" },
		r = { lsbuf.remove_workspace_folder, "Remove Folder" },
		l = { vim.pretty_print(lsbuf.list_workspace_folders), "Workspace Folders" },
		s = { telescope.lsp_workspace_symbols, "Workspace Symbols" },
	},
})
