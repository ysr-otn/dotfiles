if status is-interactive
    # Commands to run in interactive sessions can go here
end


# for peco z
function peco_z
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end


# key bindings
function fish_user_key_bindings
  # for peco
  # C-r
  bind \cr 'peco_select_history (commandline -b)'
  # C-x C-k
  bind \cx\ck peco_kill

  # for peco + z
  # C-x C-z
  bind \cx\cx peco_z
end
