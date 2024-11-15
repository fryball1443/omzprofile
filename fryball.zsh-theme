#admin@hubble
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) admin@hubble %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display

#user@hubble
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg_bold[green]%}$USER@hubble %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display

#user@hostname
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display

# default
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[blue]%}%~%{$reset_color%}"

#git prompts below
PROMPT+='$(git_prompt_info)'
PROMPT+='\$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[cyan]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$fg[cyan]%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%})%{$fg[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})"
#end git prompts