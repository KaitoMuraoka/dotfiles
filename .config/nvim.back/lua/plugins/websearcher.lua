-- return {
-- 	{
-- 		dir = "~/personalDevelop/neovim-plugin/websearcher.nvim/",
-- 		config = {
-- 			open_cmd = "",
-- 			search_engine = "Google",
-- 		},
-- 	},
-- }

return {
	"KaitoMuraoka/websearcher.nvim",
	config = {
		-- The shell command to use to open the URL.
		-- As an empty string, it defaults to your OS defaults("open" for macOS, "xdg-open" for Linux)
		open_cmd = "",

		-- Specify search engine. Default is Google.
		-- See the search_engine section for currently registered search engines
		search_engine = "Google",
	},
}
