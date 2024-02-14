fish_add_path -P /opt/homebrew/bin

set -U fish_greeting ""
set -U HOMEBREW_PREFIX /opt/hombrew

alias lsaf="ls -AF"

source /opt/homebrew/opt/asdf/libexec/asdf.fish

if test -n $TMUX
  fish_add_path -Pm /opt/homebrew/bin
  fish_add_path -Pm "$ASDF_DIR/bin"
  if test -z $ASDF_DATA_DIR
    fish_add_path -Pm "$HOME/.asdf/shims"
  else
    fish_add_path -Pm "$ASDF_DATA_DIR/shims"
  end
end
