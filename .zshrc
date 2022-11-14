# Shell Prompt
# autoload -Uz vcs_info
# autoload -Uz compinit && compinit -D
# setopt prompt_subst
# zstyle ':vcs_info:*' enable git 
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' stagedstr '●'
# zstyle ':vcs_info:*' unstagedstr '○'
# zstyle ':vcs_info:git:*' formats '%b %m%c%u'
# zstyle ':vcs_info:git:*' actionformats '%b (%a) %c%u'
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# +vi-git-untracked() {
# 	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
# 	[[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
# 	hook_com[unstaged]+='◊'
# 	fi
# }
# precmd() {
# 	vcs_info
# 	PROMPT=$'%B%* %F{cyan}%~%f %F{yellow}${vcs_info_msg_0_}%f\n%(!.%F{red}root %f.)%(?.%F{green}→%f.%F{red}→%f)%b '
# }

# Shell Configuration
HISTSIZE=0
SAVEHIST=0
SHELL_SESSIONS_DISABLE=1
setopt sharehistory

alias lsaf="ls -AF"

export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
