return function(client, _)
  if client.name == 'solargraph' then
    local mason_registry = require('mason-registry')

    -- Set up some extras for Solargraph
    local solargraph = mason_registry.get_package('solargraph')
    local solargraph_install_path = solargraph:get_install_path()
    vim.fn.jobstart(
      {"gem", "install", "solargraph-rails", "rubocop-rspec"},
      {
        env = {
          ['GEM_HOME'] = solargraph_install_path,
          ['GEM_PATH'] = solargraph_install_path,
        }
      }
    )
  end
end
