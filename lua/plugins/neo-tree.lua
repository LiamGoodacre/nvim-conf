return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = function()
    -- Yoinked things from:
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#emulating-vims-fold-commands

    local renderer = require "neo-tree.ui.renderer"

    -- Expand a node and load filesystem info if needed.
    local function open_dir(state, dir_node)
      local fs = require "neo-tree.sources.filesystem"
      fs.toggle_directory(state, dir_node, nil, true, false)
    end

    -- Expand a node and all its children, optionally stopping at max_depth.
    local function recursive_open(state, node, max_depth)
      local max_depth_reached = 1
      local stack = { node }
      while next(stack) ~= nil do
        node = table.remove(stack)
        if node.type == "directory" and not node:is_expanded() then
          open_dir(state, node)
        end

        local depth = node:get_depth()
        max_depth_reached = math.max(depth, max_depth_reached)

        if not max_depth or depth < max_depth - 1 then
          local children = state.tree:get_nodes(node:get_id())
          for _, v in ipairs(children) do
            table.insert(stack, v)
          end
        end
      end

      return max_depth_reached
    end

    --- Open the fold under the cursor, recursing if count is given.
    local function neotree_zo(state, open_all)
      local node = state.tree:get_node()

      if open_all then
        recursive_open(state, node)
      else
        recursive_open(state, node, node:get_depth() + vim.v.count1)
      end

      renderer.redraw(state)
    end

    --- Recursively open the current folder and all folders it contains.
    local function neotree_zO(state)
      neotree_zo(state, true)
    end

    -- The nodes inside the root folder are depth 2.
    local MIN_DEPTH = 2

    --- Close the node and its parents, optionally stopping at max_depth.
    local function recursive_close(state, node, max_depth)
      if max_depth == nil or max_depth <= MIN_DEPTH then
        max_depth = MIN_DEPTH
      end

      local last = node
      while node and node:get_depth() >= max_depth do
        if node:has_children() and node:is_expanded() then
          node:collapse()
        end
        last = node
        node = state.tree:get_node(node:get_parent_id())
      end

      return last
    end

    --- Close a folder, or a number of folders equal to count.
    local function neotree_zc(state, close_all)
      local node = state.tree:get_node()
      if not node then
        return
      end

      local max_depth
      if not close_all then
        max_depth = node:get_depth() - vim.v.count1
        if node:has_children() and node:is_expanded() then
          max_depth = max_depth + 1
        end
      end

      local last = recursive_close(state, node, max_depth)
      renderer.redraw(state)
      renderer.focus_node(state, last:get_id())
    end

    -- Close all containing folders back to the top level.
    local function neotree_zC(state)
      neotree_zc(state, true)
    end

    return {
      window = {
        position = "right",
        mappings = {
          ["<space>"] = "none",
          ["z"] = "none",
          ["zo"] = neotree_zo,
          ["zO"] = neotree_zO,
          ["zc"] = neotree_zc,
          ["zC"] = neotree_zC,

          [">"] = neotree_zO,
          ["<"] = "close_all_subnodes",
        },
      },
    }
  end,
}
