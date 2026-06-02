source /usr/share/cachyos-fish-config/cachyos-config.fish

alias cls='clear'
alias y='yazi'
alias lg='lazygit'
alias ff='fastfetch'
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
fnm env --use-on-cd | source
