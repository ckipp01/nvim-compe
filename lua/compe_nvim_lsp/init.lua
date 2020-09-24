local compe = require'compe'
local Source = require'compe_nvim_lsp.source'

local sources = {}

return {
  attach = function()
    vim.fn.execute('augroup compe_nvim_lsp')
    vim.fn.execute('autocmd InsertEnter * lua require"compe_nvim_lsp".register()')
    vim.fn.execute('augroup END')
  end;
  register = function()
    -- unregister
    for id in pairs(sources) do
      compe:unregister_source(id)
    end

    -- register
    for _, client in pairs(vim.lsp.get_active_clients()) do
      local id = 'nvim_lsp:' .. client.id
      sources[id] = Source.new(client)
      compe:register_lua_source(id, sources[id])
    end
  end;
}


