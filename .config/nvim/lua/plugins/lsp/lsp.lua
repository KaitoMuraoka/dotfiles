return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP Actions",
			callback = function()
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
			end,
		})

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})

		lspconfig.ts_ls.setup({})

		-- swift
		lspconfig.sourcekit.setup({
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
			cmd = {
				"sourcekit-lsp",
				"-Xswiftc",
				"-sdk",
				"-Xswiftc",
				"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator17.5.sdk",
				"-Xswiftc",
				"-target",
				"-Xswiftc",
				"x86_64-apple-ios17.5-simulator",
			},
		})

		lspconfig.svelte.setup({
			capabilities = capabilities,
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						-- Here use ctx.match instead of ctx.file
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		-- 一応のts_ls
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
		})

		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"astro",
				"css",
				"eruby",
				"html",
				"htmldjango",
				"javascriptreact",
				"less",
				"pug",
				"sass",
				"scss",
				"svelte",
				"typescriptreact",
				"vue",
				"htmlangular",
			},
		})

		lspconfig.rust_analyzer.setup({
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		})

		--lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			setting = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- bashls
		lspconfig.bashls.setup({
			cmd = { "bash-language-server", "start" },
			filetypes = { "bash", "sh" },
		})

		-- ccls
		lspconfig.ccls.setup({
			capabilities = capabilities,
		})

		-- spectal
		lspconfig.spectral.setup({
			capabilities = capabilities,
			cmd = { "spectral-language-server", "--stdio" },
			filetypes = { "yaml", "json", "yml" },
			setting = {
				enable = true,
				run = "onType",
				validateLanguages = { "yaml", "json", "yml" },
			},
		})
	end,
}
