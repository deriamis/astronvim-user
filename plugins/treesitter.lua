return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        ensure_installed = {
            "ada", "awk", "bash", "c", "c_sharp", "clojure", "cmake", "commonlisp", "cpp", "css",
            "diff", "dockerfile", "dot", "ebnf", "elixir", "elm", "embedded_template", "erlang",
            "fennel", "fish", "fortran", "git_config", "git_rebase", "gitcommit", "gitignore", "go",
            "gomod", "gosum", "gowork", "hack", "haskell", "haskell_persistent", "html", "http",
            "ini", "java", "javascript", "jq", "json", "json5", "jsonc", "julia", "kotlin", "latex",
            "llvm", "lua", "luadoc", "make", "markdown", "markdown_inline", "meson", "ninja",
            "objc", "ocaml", "ocaml_interface", "ocamllex", "pascal", "passwd", "pem", "perl",
            "php", "phpdoc", "proto", "puppet", "python", "r", "racket", "regex", "ruby", "rust",
            "scala", "scheme", "sparql", "sql", "swift", "systemtap", "tablegen", "terraform",
            "tlaplus", "todotxt", "toml", "typescript", "verilog", "vim", "vimdoc", "yaml",
        }
    }
}
