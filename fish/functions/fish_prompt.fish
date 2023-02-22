function fish_prompt
  set -l last_status $status
  set -l normal (set_color normal)
  set -l status_color (set_color purple)
  set -l cwd_color (set_color yellow)
  set -l vcs_color (set_color green)

  set -q fish_prompt_pwd_dir_length
  or set -lx fish_prompt_pwd_dir_length 0

  set -l suffix '❯'
  if functions -q fish_is_root_user; and fish_is_root_user
      set suffix '#'
  end

  if test $last_status -ne 0
      set status_color (set_color brred)
  end

  echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) ' '
  echo -n -s $status_color $suffix ' ' $normal
end
