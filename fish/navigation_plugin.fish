set -g __nav_internal 0

function __nav_save
    if set -q __nav_stack
        printf "%s\n" $__nav_stack >~/.nav_history
        echo $__nav_index >~/.nav_index
    end
end

function __nav_load
    if test -f ~/.nav_history
        set -g __nav_stack (cat ~/.nav_history)
    end

    if test -f ~/.nav_index
        set -g __nav_index (cat ~/.nav_index)
    end

    # fallback seguro
    if not set -q __nav_stack
        set -g __nav_stack $PWD
        set -g __nav_index 1
    end
end

# cargar al iniciar fish
__nav_load

function __nav_on_cd --on-variable PWD
    # Si el cambio viene de back/forward → ignorar
    if test "$__nav_internal" = 1
        return
    end

    if not set -q __nav_stack
        set -g __nav_stack $PWD
        set -g __nav_index 1
        return
    end

    if test $__nav_stack[$__nav_index] = $PWD
        return
    end

    # cortar forward history
    set -g __nav_stack $__nav_stack[1..$__nav_index]

    # agregar nuevo
    set -ga __nav_stack $PWD
    set -g __nav_index (count $__nav_stack)

    __nav_save
end

function back
    if test $__nav_index -le 1
        echo "Inicio del historial"
        return 1
    end

    set -g __nav_index (math $__nav_index - 1)

    set -g __nav_internal 1
    cd $__nav_stack[$__nav_index]
    set -g __nav_internal 0

    __nav_save
end

function forward
    if test $__nav_index -ge (count $__nav_stack)
        echo "Final del historial"
        return 1
    end

    set -g __nav_index (math $__nav_index + 1)

    set -g __nav_internal 1
    cd $__nav_stack[$__nav_index]
    set -g __nav_internal 0

    __nav_save
end

function nav
    echo ""
    if not type -q fzf
        echo "fzf no está instalado"
        return 1
    end

    set selection (printf "%s\n" $__nav_stack | tac | fzf --height 40% --reverse --prompt="nav> ")

    if test -n "$selection"
        cd "$selection"
    end
end

# Shift + ←  (back)
bind \e\[1\;2D back

# Shift + →  (forward)
bind \e\[1\;2C forward

# Ctrl + g → abrir navegador de dirs
bind \cg nav

function navhist
    for i in (seq (count $__nav_stack))
        if test $i -eq $__nav_index
            echo "> $__nav_stack[$i]"
        else
            echo "  $__nav_stack[$i]"
        end
    end
end
