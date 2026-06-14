# Minimal qtile config
from libqtile import bar, layout, widget
from libqtile.config import Key, Group, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig
from qtile_extras.layout.decorations import RoundedCorners


mod = "mod4"

wl_input_rules = {
    "type:touchpad": InputConfig(
        natural_scroll=True,
        tap=True,
        accel_profile="flat",
        pointer_accel=0.7,
    )
}

groups = [Group(i) for i in "12345678"]

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



layouts = [
        layout.Spiral(
            ratio=0.618,
            main_pane="left",
            clockwise=True,
            border_focus=RoundedCorners(colour="31748f"),
            border_normal=RoundedCorners(colour="c4a7e7"),
            # border_focus="#31748f",
            # border_normal="#c4a7e7",
            border_width=3,
            margin=6
        ),
]

screens = [
        Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName(
            ), widget.Clock(format='%Y-%m-%d %a %H:%M')], 24))
        ]

main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False


