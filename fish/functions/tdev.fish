function tdev
  if test -n "$TMUX"
    echo 'Error: Currently in a tmux environment.'
    return 1
  end

  argparse 'n/name=' 'p/path=' -- $argv
  or return

  if set -ql _flag_p
    if not test -d $_flag_p
      echo 'Error: Path not found.'
      return 1
    end

    set -f path $_flag_p
  else
    set -f path $PWD
  end

  if set -ql _flag_n
    set -f name $_flag_n
  else
    set -f name (basename $PWD)
  end

  tmux has -t $name
  
  if test $status -ne 0
    tmux new -d -s $name -c $PWD

    if test $status -eq 0
      tmux renamew -t $name:1 'editor'
      tmux neww -t $name -n 'shell'
      tmux splitw -t $name:2
      tmux splitw -t $name:2
      tmux selectl -t $name:2 tiled
      tmux selectp -t $name:2.1
      tmux selectw -t $name:1
    end
  end

  tmux a -t $name
end
