# Setup fzf
# ---------
if [[ ! "$PATH" == */home/son_nguyen_meruhealth_com/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/son_nguyen_meruhealth_com/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/son_nguyen_meruhealth_com/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/son_nguyen_meruhealth_com/.fzf/shell/key-bindings.bash"

export FZF_DEFAULT_OPTS='--height 25% --color=dark,hl:2,hl+:1,bg+:0,gutter:0,info:3,prompt:4,pointer:1'


