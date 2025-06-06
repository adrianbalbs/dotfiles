return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".clang-tidy", ".clang-format" },
    filetypes = { "c", "cpp" },
}
