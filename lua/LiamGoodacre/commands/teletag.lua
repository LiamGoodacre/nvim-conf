-- replicating :tselect but with telescope
local function teletag(opts)
  local word = vim.fn.expand("<cword>")
  local matches = vim.fn.taglist("^" .. word .. "$")
  if vim.tbl_isempty(matches) then
    vim.notify("No tags found for '" .. word .. "'", vim.log.levels.INFO)
    return
  end

  local entries = {}
  for _, tag in ipairs(matches) do
    -- format as 'tags\tfile\tlnum'
    local line = string.format(
      "%s\t%s\t%s",
      tag.name, tag.filename, tag.cmd
    )
    table.insert(entries, line)
  end

  opts = opts or {}
  opts.bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  local gen_from_ctags = require('telescope.make_entry').gen_from_ctags(opts)

  local displayer = require('telescope.pickers.entry_display').create {
    separator = " ",
    items = { { remaining = true } },
  }

  local make_display = function(entry)
    return displayer { entry.filename }
  end

  require('telescope.builtin').tags(vim.tbl_extend("force", {
    finder = require('telescope.finders').new_table {
      results = entries,
      entry_maker = function(entry)
        return vim.tbl_extend("force", gen_from_ctags(entry), {
          display = make_display,
        })
      end,
    },
  }, opts))
end

return {
  teletag = teletag,
  setup = function()
  end,
}
