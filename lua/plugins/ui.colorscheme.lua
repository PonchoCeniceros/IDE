return {
  -- tema onedark
  {
    "navarasu/onedark.nvim",
    name = "onedark", -- importante para que LazyVim lo encuentre
    config = function()
      require("onedark").setup({
        -- style = "dark",
        -- style = "darker",
        -- style = "deep",
        -- style = "warm",
        -- style = "warmer",
        style = "cool",
      })
    end,
  },

  -- tema catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- flavour = "latte",
      -- flavour = "frappe",
      -- flavour = "macchiato",
      flavour = "mocha",
    },
  },

  -- tema carbonfox (negro/gris profesional)
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false, -- fondo opaco para mejor contraste
          terminal_colors = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        palettes = {
          carbonfox = {
            -- Personalizaciones sutiles si quieres ajustar tonos
            bg0 = "#161616", -- fondo más oscuro
            bg1 = "#1a1a1a",
          },
        },
      })
    end,
  },

  -- Configura LazyVim para cargar un tema de color dinámicamente
  {
    "LazyVim/LazyVim",
    opts = function()
      local chosen_colorscheme = os.getenv("NVIM_THEME")
      if chosen_colorscheme == "onedark" then
        return { colorscheme = "onedark" }
      elseif chosen_colorscheme == "catppuccin" then
        return { colorscheme = "catppuccin" }
      elseif chosen_colorscheme == "carbonfox" then
        return { colorscheme = "carbonfox" }
      else
        -- Por defecto usa carbonfox (tonos negro/gris)
        return { colorscheme = "carbonfox" }
      end
    end,
  },
}
