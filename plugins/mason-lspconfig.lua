return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        automatic_installation = true,
        ensure_installed = {
            "asm_lsp", "awk_ls", "bashls", "clangd", "clojure_lsp", "cmake",
            "docker_compose_language_service", "dockerls", "elixirls",
            "erlangls", "fortls", "gopls", "hls", "html", "jdtls", "jsonls",
            "lemminx", "ltex", "lua_ls", "ocamllsp", "omnisharp",
            "perlnavigator", "phpactor", "pyright", "rust_analyzer", "salt_ls",
            "solargraph", "sqlls", "svlangserver", "vimls", "yamlls"
        }
    },
}
