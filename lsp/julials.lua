local cmd = {
  "julia",
  "--project=@lsp",
  "--startup-file=no",
  "--history-file=no",
  "-e",
  [[
    using LanguageServer
    const depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
    const project_path = Base.current_project() |> dirname
    function (@main)(args)
    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
    server.runlinter = true
    run(server)
    end
  ]],
}

---@type vim.lsp.Config
return {
  cmd = cmd,
  filetypes = { "julia" },
  root_markers = { "Project.toml" },
  workspace_required = true
}
