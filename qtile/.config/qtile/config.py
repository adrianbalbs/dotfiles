# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, ScratchPad, Screen, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from themes.tokyonight import colors

mod = "mod1"
terminal = guess_terminal()

class Apps:
    rofi_drun = "rofi -show drun"
    browser = "firefox"

class Utils:
    rofi_walls = "rofi_walls.sh"
    rofi_power = "rofi_power.sh"
    screenshot_full = "flameshot screen --number 1"
    screenshot_gui = "flameshot gui"
    clipboard = "rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), 
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the right"),

    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating",
    ),
    Key([mod], "comma", lazy.prev_screen(), desc="Move to prev screen"),
    Key([mod], "period", lazy.next_screen(), desc="Move to next screen"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "p", lazy.spawn(Apps.rofi_drun), desc="Launch app launcher"),
    Key([mod, "Shift"], "w", lazy.spawn(Utils.rofi_walls), desc="Launch wallpaper changer"),
    Key([mod, "Shift"], "p", lazy.spawn(Utils.rofi_power), desc="Launch power settings"),
    Key([mod], "Print", lazy.spawn(Utils.screenshot_full), desc="Screenshot primary monitor"),
    Key([mod], "c", lazy.spawn(Utils.clipboard), desc="Screenshot primary monitor"),
    Key([mod, "control"], "Print", lazy.spawn(Utils.screenshot_gui), desc="Screenshot select"),
    Key([mod, "shift"], "b", lazy.spawn(Apps.browser), desc="Launch browser"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "Shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]
groups = [
        Group("1", layout="monadtall"),
        Group("2", layout="monadwide"),
        Group("3", layout="monadtall"),
        Group("4", layout="monadwide"),
        Group("5", layout="monadtall"),
        Group("6", layout="monadwide"),
        Group("7", layout="monadtall"),
        Group("8", layout="monadwide"),
        ]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

groups.append(ScratchPad("scratchpad", [
        DropDown("mixer", "alacritty -e pulsemixer", width=0.6, height=0.6, x=0.2, y=0.2),
        DropDown("drop-term", "alacritty", width=0.6, height=0.6, x=0.2, y=0.2),
        DropDown("file-browser", "alacritty -e lf", width=0.6, height=0.6, x=0.2, y=0.2),
        DropDown("btop", "alacritty -e btop", width=0.8, height=0.8, x=0.1, y=0.1),
    ])
)

keys.extend([
    Key([mod], "x", lazy.group["scratchpad"].dropdown_toggle("mixer")),
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("drop-term")),
    Key([mod, "Shift"], "f", lazy.group["scratchpad"].dropdown_toggle("file-browser")),
    Key([mod], "b", lazy.group["scratchpad"].dropdown_toggle("btop")),
])

colors = colors["night"]

layout_theme = {"border_width": 2,
                "margin": 5,
                "border_focus": colors["magenta"],
                "border_normal": colors["black"]
                }

layouts = [
    #layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    fontsize=17,
    padding=10,
    foreground = colors["fg"],
    background = colors["bg"],
)
extension_defaults = widget_defaults.copy()

def get_bar1():
    return [
        widget.GroupBox(
                highlight_method="line", 
                active=colors["magenta"], # not current active font color
                inactive=colors["fg"],
                rounded=False,
                disable_drag=True,
                highlight_color=colors["bg"],
                this_current_screen_border=colors["blue"], # current active font color - MAIN
                this_screen_border=colors["magenta"],
                other_current_screen_border=colors["bg"],
                other_screen_border=colors["bg"],
                urgent_alert_method="line",
                urgent_border=colors["red"],
                urgent_text=colors["red"],
                #foreground = colors["fg"],
                #background = colors["red"],
                hide_unused=True,
                ),
            widget.CurrentLayoutIcon(
                use_mask=True, # needs to be on for the icon to use our foreground
                scale=0.5,
                padding=5, # Don't delete this or the bar will go transparent, for some reason
            ),
            widget.Spacer(),
            #widget.Net(
             #   interface='wlp3s0',
              #  format='{down} ↓↑ {up}',
            #),
            widget.CheckUpdates(
                display_format="󰚰 {updates}",
                no_update_string="󰚰 0",
                distro="Arch_yay",
                colour_have_updates=colors["magenta"],
                colour_no_updates=colors["fg"]
            ),
            # widget.PulseVolume(
            # device="Focusrite Scarlett 6i6 Analog Surround 2.1",
            # fmt=" {}"
            # ),
            # widget.ThermalSensor(
            #     format=' {temp:.0f}{unit}',
            #     tag_sensor='Tctl',
            #     threshold=60,
            #     foreground_alert=colors["red"],
            #     foreground = colors["fg"],
            # ),
            # widget.CPU(
            #     format=' {load_percent}%'
            # ),
            # widget.Memory(
            #     format=' {MemPercent}%'
            # ),
            widget.Wlan(
                #format='  {essid} {percent:2.0%}',
                format='  {percent:2.0%}',
                interface='wlp3s0'
            ),
            widget.Clock(format="%b %d, %I:%M %p "),
        ]

def get_bar2():
    return [
        widget.GroupBox(
                highlight_method="line", 
                active=colors["magenta"], # not current active font color
                inactive=colors["fg"],
                rounded=False,
                disable_drag=True,
                highlight_color=colors["bg"],
                this_current_screen_border=colors["blue"], # current active font color - MAIN
                this_screen_border=colors["magenta"],
                other_current_screen_border=colors["bg"],
                other_screen_border=colors["bg"],
                urgent_alert_method="line",
                urgent_border=colors["red"],
                urgent_text=colors["red"],
                #foreground = colors["fg"],
                #background = colors["red"],
                hide_unused=True,
                ),
            widget.CurrentLayoutIcon(
                use_mask=True, # needs to be on for the icon to use our foreground
                scale=0.5,
                padding=5, # Don't delete this or the bar will go transparent, for some reason
            ),
            widget.Spacer(),
            widget.Clock(format="%b %d, %I:%M %p "),
        ]

screens = [
    Screen(
        top=bar.Bar(
            get_bar1(),
            35, # bar height
            #border_color = [0, 0, 0, 0],    # Borders are transparent
            #border_width = [0, 0, 0, 0],    # Draw top and bottom borders
            #margin =      [15, 60, 6, 60], # Draw top and bottom borders
            #margin =      [0, 10, 10, 10], # Draw top and bottom borders   [ top, right, bottom, left ]
        ), 
    ),
    Screen(
        top=bar.Bar(
            get_bar2(),
            35, # bar height
        ), 
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    border_focus=colors["magenta"],
    border_normal=colors["black"],
    border_width=2,
    margin=5,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
