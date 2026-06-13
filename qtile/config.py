# Minimal qtile config
from libqtile import bar, layout, widget
from libqtile.config import Key, Group, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig

mod = "mod4"

wl_input_rules = {
    "type:touchpad": InputConfig(
        natural_scroll=True,
        tap=True,
        accel_profile="flat",
        pointer_accel=0.5,
        scroll_factor=0.1
    )
}

groups = [Group(i) for i in "123456789"]

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Return", lazy.spawn("ghostty")),
    Key([mod], "b", lazy.spawn("brave")),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),

]

for i in groups:
    keys.append(
        Key(
            [mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc=f"Switch to group {i.name}"
        )
    )
    keys.append(
        Key(
            [mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc=f"Move window to group {i.name}"
        )
    )



layouts = [layout.Max(), layout.Stack(num_stacks=2)]

screens = [
    Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName(
    ), widget.Clock(format='%Y-%m-%d %a %H:%M')], 24))
]

main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
