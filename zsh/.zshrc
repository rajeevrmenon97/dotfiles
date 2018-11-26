export ZSH="/home/r2m/.oh-my-zsh"
ZSH_THEME="rkj-repos"
plugins=(
  git
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias --enable-experimental-instant-mode)
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
