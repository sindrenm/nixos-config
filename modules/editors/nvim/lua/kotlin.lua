-- Give Kotlin import sections their own fold, and automatically fold it on
-- buffer open. The import section is retrieved using tree-sitter.

local import_range_cache = {}

local function node_is_import_list(node)
  return node:type() == "import_list"
end

local function get_import_range(bufnr)
  local tick = vim.api.nvim_buf_get_changedtick(bufnr)
  local cached = import_range_cache[bufnr]

  if cached and cached.tick == tick then
    return cached.start_row, cached.end_row
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "kotlin")

  if not ok or parser == nil then
    return nil
  end

  local root = parser:parse()[1]:root()

  local imports = vim
      .iter(root:iter_children())
      :find(node_is_import_list)

  local start_row, end_row
  if imports then
    local sr, _, er = imports:range()

    start_row, end_row = sr, er
  end

  import_range_cache[bufnr] = {
    tick = tick,
    start_row = start_row,
    end_row = end_row,
  }

  return start_row, end_row
end

function _G.__kotlin_import_foldexpr(lnum)
  local start_row, end_row = get_import_range(vim.api.nvim_get_current_buf())

  if not start_row then
    return "0"
  end

  local row = lnum - 1 -- tree-sitter rows start at 0

  if row < start_row or row > end_row then return "0" end
  if row == start_row then return ">1" end
  if row == end_row then return "<1" end
  return "1"
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "kotlin",
  callback = function(args)
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.__kotlin_import_foldexpr(v:lnum)"
    -- Only the imports fold exists in this expr, so opening everything else
    -- by default is a no-op; we just need the imports themselves closed.
    vim.wo.foldlevel = 99

    local start_row = get_import_range(args.buf)

    if start_row then
      vim.schedule(function()
        if vim.api.nvim_get_current_buf() == args.buf then
          vim.cmd(string.format("%dfoldclose", start_row + 1))
        end
      end)
    end
  end,
})
