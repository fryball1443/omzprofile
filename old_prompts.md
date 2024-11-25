# original user@hostname
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display


# original default
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[blue]%}%~%{$reset_color%}"


# new user@hostname where user@hostname doesnt turn red when previous prompt was dirty.
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg_bold[green]%}$USER@%M %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display
