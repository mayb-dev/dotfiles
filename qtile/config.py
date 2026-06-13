# Minimal qtile config
    from libqtile import bar, layout, widget, hook
    from libqtile.config import Key, Group, Screen
    from libqtile.lazy import lazy
    mod = "mod4"

    keys = [
      Key([mod], "h", lazy.layout.left()),
      Key([mod], "l", lazy.layout.right()),
      Key([mod], "Return", lazy.spawn("ghostty")),
      Key([mod], "b", lazy.spawn("/home/mpatel/.nix-profile/bin/brave")),
      Key([mod, "control"], "r", lazy.reload_config()),
      Key([mod, "control"], "q", lazy.shutdown()),
    ]

    groups = [Group(i) for i in "123456789"]

    layouts = [layout.Max(), layout.Stack(num_stacks=2)]

    screens = [
      Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName(), widget.Clock(format='%Y-%m-%d %a %H:%M')], 24))
    ]

    main = None
    follow_mouse_focus = True
    bring_front_click = False
    cursor_warp = False

    @hook.subscribe.startup_once
    def autostart():
      import subprocess
      subprocess.call(['sh', '-c', 'xrandr --auto &'])
