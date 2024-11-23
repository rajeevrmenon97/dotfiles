local dimens <const> = require("config.dimens")

return {
  text = "MesloLGS Nerd Font",
  numbers = "MesloLGS Nerd Font",
  icons = function(size)
    local font = "sketchybar-app-font:Regular:"
    return size and font .. size or font .. dimens.text.icon
  end,
  styles = {
    regular = "Regular",
    bold = "Bold",
  }
}