# -*- coding: utf-8 -*-
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
import platform

mod = "mod4"
hostname = platform.node()
num_screens = {
    'clay': 2,
    'meyer': 1
}.get(hostname, 1)

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_up()
    ),

    # Grow and shrink
    Key(
        [mod], "h",
        lazy.layout.decrease_ratio(),
        lazy.layout.shrink(),
        lazy.layout.next()
    ),
    Key(
        [mod], "l",
        lazy.layout.increase_ratio(),
        lazy.layout.grow(),
        lazy.layout.previous()
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize()
    ),
    Key(
        [mod], "m",
        lazy.layout.maximize()
    ),


    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),

    Key(
        [mod, "control"], "space",
        lazy.layout.flip()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key(
        [mod, "shift"], "l",
        lazy.layout.client_to_next()
    ),
    Key(
        [mod, "shift"], "h",
        lazy.layout.client_to_previous()
    ),

    Key(
        [mod, "shift"], "f",
        lazy.window.toggle_floating()
    ),
Key(
        [mod, "shift"], "1",
        lazy.to_screen(0),
        lazy.group.toscreen(0)
    ),
    Key(
        [mod, "shift"], "2",
        lazy.to_screen(1),
        lazy.group.toscreen(1)
    ),

    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "F10", lazy.spawn("import -window root /tmp/screenshot.png")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.nextlayout()),
    Key([mod, "control"], "t", lazy.group.setlayout('tree')),
    Key([mod, "control"], "s", lazy.group.setlayout('stack')),
    Key([mod, "control"], "n", lazy.group.setlayout('monadtall')),
    Key([mod, "control"], "m", lazy.group.setlayout('max')),

    Key([mod, "shift"],"c", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.Stack(num_stacks=2, autosplit=True),
    layout.TreeTab(name='tree'),
    layout.MonadTall(),
    layout.Max(name='max'),
]

widget_defaults = dict(
    font='Arial',
    fontsize=14,
    padding=3,
)

if num_screens == 2:
    screens = [
        Screen(
            top=bar.Bar(
                [
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Notify(),
                    widget.CurrentScreen(),
                    widget.CurrentLayout(),
                    widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                ],
                30,
            ),
            bottom=bar.Bar(
                [
                    widget.MemoryGraph(),
                    widget.CPUGraph(),
                    widget.NetGraph(),
                    widget.HDDBusyGraph(),
                    widget.Sep(),
                    widget.BitcoinTicker(),
                    widget.Spacer(),
                    widget.YahooWeather( woeid='12769084', metric=False, format='{condition_text} {condition_temp}°{units_temperature} Chill={wind_chill}°{units_temperature} Hum={atmosphere_humidity}% Press={atmosphere_rising}{atmosphere_pressure}{units_pressure} Vis={atmosphere_visibility}{units_distance} Wind={wind_speed}{units_speed}@{wind_direction}°'),
                    widget.DF(warn_space=30),
                ],
                30,
            ),
        ),
        Screen(
            top=bar.Bar(
                [
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Clipboard(timeout=None, width=bar.STRETCH, max_width=None),
                    widget.Notify(),
                    widget.CurrentScreen(),
                    widget.CurrentLayout(),
                    widget.Systray(),
                ],
                30,
            ),
        ),
    ]
else:
    screens = [
        Screen(
            top=bar.Bar(
                [
                    widget.GroupBox(),
                    widget.Prompt(),
                    widget.WindowName(),
                    widget.Systray(),
                    widget.Notify(),
                    widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                ],
                30,
            ),
            bottom=bar.Bar(
                [
                    widget.BatteryIcon(),
                    widget.MemoryGraph(),
                    widget.CPUGraph(),
                    widget.NetGraph(),
                    widget.HDDBusyGraph(),
                    widget.Sep(),
                    widget.BitcoinTicker(),
                    widget.Spacer(),
                    widget.YahooWeather(
                        woeid='2375810',
                        metric=False,
                        format="  {astronomy_sunrise} sunrise, {astronomy_sunset} sunset  {condition_temp} deg {condition_text}"),
                    widget.DF(warn_space=30),
                ],
                30,
            ),
        ),
    ]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
float_rules = [dict(wmclass='vtk')]
floating_layout = layout.Floating(float_rules=float_rules)
auto_fullscreen = True
wmname = "qtile"

@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog'
        or window.window.get_wm_transient_for()):
        window.floating = True

@hook.subscribe.startup_once
def startup():
    import subprocess

    # startup-script is simple a list of programs to run
    if hostname == 'ethan':
        subprocess.Popen(['setxkbmap', 'dvorak'])
        subprocess.Popen(['/home/matt/.config/dotfiles/bin/synaptics.conf.sh'])
        subprocess.Popen(['firefox'])
        subprocess.Popen(['nm-applet'])
        subprocess.Popen(['prime-indicator'])
    subprocess.Popen(['urxvt'])
