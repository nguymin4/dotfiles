#!/usr/bin/env bash
tmux_get() {
  local value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
  # $1: option; $2: value
  tmux set-option -gq "$1" "$2"
}

# Icons
RIGHT_ARROW=''
LEFT_ARROW=''

# Colors
BLUE='blue'
GREEN='#A7C080'
WHITE='#FFFFFF'
YELLOW='#E5C07B'

STATUS_FG='#767676'
STATUS_BG='#464646'

case $(tmux_get '@tmux_theme' 'dark') in
  'dark' )
    FG='#626262'
    BG='#262626'
    PANE_FG='#626262'
    ;;
  'light' )
    FG=$BLUE
    BG='gray90'
    PANE_FG='gray60'
    ;;
esac

# Status options
tmux_set status-interval 1
tmux_set status on

# Basic status bar colors
tmux_set status-fg  "$FG"
tmux_set status-bg  "$BG"
tmux_set status-attr none

# Left side of status bar
SESSION_SEGMENT="#[fg=$STATUS_BG,bg=$GREEN]  #S  #[fg=$GREEN,bg=$BG]$RIGHT_ARROW"

tmux_set status-left-bg       "$STATUS_BG"
tmux_set status-left-fg       "$STATUS_FG"
tmux_set status-left-length   150
tmux_set status-left          "$SESSION_SEGMENT"

# Right side of status bar
DATE_TIME_SEGMENT="#[fg=$YELLOW,bg=$BG]$LEFT_ARROW#[fg=$STATUS_BG,bg=$YELLOW]  %F %T "

tmux_set status-right-bg      "$BG"
tmux_set status-right-fg      "$STATUS_FG"
tmux_set status-right-length  150
tmux_set status-right         "$DATE_TIME_SEGMENT"

# Window status format
tmux_set window-status-format         "#[fg=$BG,bg=$BG]$RIGHT_ARROW#[fg=$BLUE,bg=$BG] #I: #W #[fg=$BG,bg=$BG]$RIGHT_ARROW"
tmux_set window-status-current-format "#[fg=$BG,bg=$BLUE]$RIGHT_ARROW#[fg=$WHITE,bg=$BLUE] #I: #W #[fg=$BLUE,bg=$BG]$RIGHT_ARROW"

# Window status style
tmux_set window-status-style          "fg=$BLUE,bg=$BG"
tmux_set window-status-last-style     "fg=$BLUE,bg=$BG"
tmux_set window-status-activity-style "fg=$BLUE,bg=$BG"
tmux_set window-status-separator      ""

# Pane border
tmux_set pane-border-style        "fg=$PANE_FG,bg=default"
tmux_set pane-active-border-style "fg=$GREEN,bg=default"

# Pane number indicator
tmux_set display-panes-colour         "$PANE_FG"
tmux_set display-panes-active-colour  "$GREEN"

# Message
tmux_set message-style          "fg=$STATUS_BG,bg=$YELLOW"
tmux_set message-command-style  "fg=$STATUS_BG,bg=$YELLOW"
tmux_set mode-style             "fg=$STATUS_BG,bg=$YELLOW"
