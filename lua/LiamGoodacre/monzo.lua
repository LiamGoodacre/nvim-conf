local M = {}

M.setup = function()

  vim.opt.wildignore:append({
    '*.firehose.go',
    '*.pb.go',
    '*.proto.desc',
    '*.router.go',
    '*.streams.go',
    '*.typhon.go',
    '*.validator.go',
    '*.rule',
  })


  local monzo_group = vim.api.nvim_create_augroup('Monzo', { clear = true })
  local ro_patterns = {
    vim.env.GOPATH .. '/src/github.com/monzo/wearedev/vendor/*',
    vim.env.GOPATH .. '/src/github.com/monzo/wearedev/{service,cron}.*/manifests/*-template.{yml,yaml}',
    vim.env.GOPATH .. '/src/github.com/monzo/wearedev/{service,cron}.*/proto/*.{firehose.go,pb.go,proto.desc,router.go,streams.go,typhon.go,validator.go}',
    vim.env.GOPATH .. '/src/github.com/monzo/wearedev/service.*/crons/crons.json',
    vim.env.GOPATH .. '/src/github.com/monzo/wearedev/CODEOWNERS',
  }

  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = monzo_group,
    pattern = ro_patterns,
    callback = function()
      vim.opt_local.readonly = true
    end,
  })

  vim.opt.path:append({
    vim.env.HOME .. '/src',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/tools',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/libraries',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/catalog/components',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/catalog/owners',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/catalog/systems',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/bin',
    vim.env.HOME .. '/src/github.com/monzo/wearedev',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/vendor/github.com/monzo',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/vendor/github.com/gocql',
    vim.env.HOME .. '/src/github.com/monzo/wearedev/vendor/github.com/Shopify',
    vim.env.HOME .. '/src/github.com/monzo',
  })

end

return M
