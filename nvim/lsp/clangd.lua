return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--function-arg-placeholders",
    },
    root_markers = { "compile_commands.json", "compile_flags.txt" },
    filetypes = { "c", "cpp" },
}
