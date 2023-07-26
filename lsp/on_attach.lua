return function(client, bufnr)
  local diagnostics_active = true
  vim.keymap.set("n", "<leader>lt", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end, { buffer = bufnr, desc = "Toggle diagnostics" })

  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if inlayhints_avail then
      inlayhints.on_attach(client, bufnr)
      inlayhints.toggle()
    end
  end

  if client.name == "omnisharp" then
    local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
    for i, v in ipairs(tokenModifiers) do
      tokenModifiers[i] = v:gsub(" ", "_")
    end
    local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
    for i, v in ipairs(tokenTypes) do
      tokenTypes[i] = v:gsub(" ", "_")
    end
  end
end
