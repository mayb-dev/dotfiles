local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font({
  family = "GeistMono NFP SemiBold"
})
config.font_size = 13.5

config.enable_tab_bar = false
config.window_decorations = "NONE"

config.color_scheme = "rose-pine"

config.window_padding = {
  left = 45,
  right = 45,
  top = 45,
  bottom = 30
}

config.window_background_opacity = 0.75
-- config.macos_window_background_blur = 20

config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 100

return config
