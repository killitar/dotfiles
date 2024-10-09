return {
  -- "hrsh7th/nvim-cmp",
  "iguanacucumber/magazine.nvim",
  version = false,
  event = "InsertEnter",
  enabled = false,
  name = "nvim-cmp",
  dependencies = {
    {
      "garymjr/nvim-snippets",
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = {
        friendly_snippets = true,
      },
    },

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    {
      url = "https://codeberg.org/FelipeLema/cmp-async-path.git",
    },
    "folke/lazydev.nvim",
    "lukas-reineke/cmp-under-comparator",
  },
  config = function()
    local cmp = require("cmp")

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    vim.opt.shortmess:append("c")

    cmp.setup({
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = {
        priority_weight = 1,
        comparators = {
          cmp.config.compare.locality,
          cmp.config.compare.recently_used,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.offset,
          cmp.config.compare.order,
        },
      },

      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true,
      },
      view = {
        entries = {
          name = "custom",
          selection_order = "top_down",
          follow_cursor = true,
        },
      },
      window = {
        completion = {
          border = border("CmpBorder"),
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
          scrollbar = false,
          max_width = 80,
          max_height = 20,
        },
        documentation = {
          border = border("CmpDocBorder"),
          winhighlight = "Normal:CmpDoc",
          max_width = 80,
          max_height = 20,
        },
      },
      preselect = cmp.PreselectMode.Item,
      completion = {
        -- Remove open paren, comma and "" from completion triggers.
        get_trigger_characters = function(trigger_characters)
          local new_trigger_characters = {}
          for _, char in ipairs(trigger_characters) do
            if char ~= "(" and char ~= "," and char ~= '"' and char ~= "'" then
              table.insert(new_trigger_characters, char)
            end
          end
          return new_trigger_characters
        end,
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),

        -- Use TAB and Shift-TAB to scroll through suggestions
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),
      formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = function(_, item)
          local mini_icon = require("mini.icons").get("lsp", item.kind)
          item.kind = string.format("%s %s", mini_icon, item.kind or "")
          return item
        end,
      },
      sources = {
        { name = "nvim_lsp", priority = 50, max_item_count = 5 },
        { name = "lazydev", priority = 50, group_index = 0 },
        {
          name = "snippets",
          priority = 100,
          entry_filter = function()
            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("string") and not context.in_treesitter_capture("String")
          end,
          max_item_count = 3,
        },
        { name = "async_path", priority = 99 },
        { name = "buffer", priority = 50, max_item_count = 5 },
      },
    })
  end,
}
