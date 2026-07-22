vim.b.did_ftplugin = 1

vim.opt.wildignore:append({
  -- Output
  "output/*",
  "*.pdf",
  -- SVG,
  "svg-inkscape/*",
  -- Aux files
  "*.aux",
  "*.bbl*",
  "*.bcf",
  "*.blg",
  "*.fdb_latexmk",
  "*.fls",
  "*.out",
  "*.run.xml",
  "*.toc",
  -- Tikz externalization
  "*.figlist",
  "*.dep",
  "*.dpth",
  "*.md5",
})

vim.bo.commentstring = "% %s"

-- vim.bo.formatoptions = "r"
-- vim.bo.formatlistpat = [[^\s*\\\<item\>\s]]
-- vim.bo.formatprg = "tex-fmt --stdin -q"
