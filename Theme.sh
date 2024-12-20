#!/usr/bin/env bash
#   █████╗ ███╗   ██╗██████╗ ██████╗ ███████╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ███████║██╔██╗ ██║██║  ██║██████╔╝█████╗  ███████║    ██████╔╝██║██║     █████╗
#  ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██╔══╝  ██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ██║  ██║██║ ╚████║██████╔╝██║  ██║███████╗██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Andrea
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 70
	bspc config bottom_padding 2
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#161616"
	bspc config active_border_color "#161616"
	bspc config focused_border_color "#605692"
	bspc config presel_feedback_color "#67d4f1"
}

pidof -q bspc && pkill -9 bspc >/dev/null

# Set alacritty colorscheme
set_alacritty_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# Color scheme for Andrea Rice
# Dark Pride
# A dark trans pride colour inspired theme

# Primary colors
[colors.primary]
background = '#0d0d1b'
foreground = '#ccccce'

# Colors used for 'custom_cursor_colors'
[colors.cursor]
text = '#bbbbbb'
cursor = '#ff0017'

# Colors 0 through 7
[colors.normal]
black = '#282828'
red = '#ca1444'
green = '#789aba'
yellow = '#b3879f'
blue = '#95569b'
magenta = '#cb6fa1'
cyan = '#fb6e93'
white = '#cf98c1'

# Colors 8 through 15
[colors.bright]
black = '#98218e'
red = '#cb515d'
green = '#5a87b1'
yellow = '#9c61ab'
blue = '#9a77b1'
magenta = '#f2a297'
cyan = '#f4436f'
white = '#ebdbb2'
EOF
}

# Set kitty colorscheme
set_kitty_config() {
  cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
## This file is autogenerated, do not edit it, instead edit the Theme.sh file inside the rice directory.
## Color scheme for Andrea Rice

## name: Dark Pride
## author: apathyrecharge
## license: GPLv3
## blurb: Dark trans-pride colour inspired theme

background            #0d0d1b
foreground            #ccccce
selection_background  #002a3a
selection_foreground  #0d0f18
cursor                #ff0017
color0                #282828
color1                #ca1444
color2                #789aba
color3                #b3879f
color4                #94469b
color5                #cb6fa1
color6                #fb6e93
color7                #cf98c1
color8                #98218e
color9                #cb515d
color10               #5a87b1
color11               #9c61ab
color12               #9a77b1
color13               #f2a297
color14               #f4436f
color15               #ebdbb2

EOF

killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 1/g" \
		-e "s/frame_color = .*/frame_color = \"#0d0d1b\"/g" \
		-e "s/separator_color = .*/separator_color = \"#605692\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#605692'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#0d0d1b"
		foreground = "#FDF0ED"

		[urgency_normal]
		timeout = 6
		background = "#0d0d1b"
		foreground = "#FDF0ED"

		[urgency_critical]
		timeout = 0
		background = "#0d0d1b"
		foreground = "#FDF0ED"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
// Eww colors for Andrea rice
\$bg: #FDF0ED;
\$bg-alt: #F0E9E2;
\$fg: #151515;
\$black: #16161C;
\$lightblack: #262831;
\$red: #DA103F;
\$blue: #65C7E3;
\$cyan: #2eccca;
\$magenta: #b0a5ed;
\$green: #1EB980;
\$yellow: #FFCC57;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Andrea
set_jgmenu_colors() {
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #FDF0ED/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #151515/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #F0E9E2/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #151515/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #1A1C23/'
}

# Set rofi colors
set_launcher_config() {
	cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Andrea

* {
    font: "JetBrainsMono NF Bold 9";
    background: #0d0d1b;
    background-alt: #0d0d1b;
    foreground: #ccccce;
    selected: #67d4f1;
    active: #b0a5ed;
    urgent: #F43E5C;
    
    img-background: url("~/.config/bspwm/rices/andrea/rofi.webp", width);
}
EOF
}

# Launch the bar
launch_bars() {
	eww -c "${rice_dir}"/andy open --toggle bar
}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_alacritty_config
set_kitty_config
set_picom_config
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
launch_bars
