
function is_ssh
    set -q SSH_TTY ; or set -q SSH_CLIENT
    return $status
end

function path_relative_to_home
    set resolved_path (realpath $argv --relative-base=(echo ~))
    switch "$resolved_path"
        case '/*'
            echo $resolved_path
        case '.'
            echo '~'
        case '*'
            echo '~/'$resolved_path
    end
end

function fish_title
    if [ is_ssh ]
        path_relative_to_home (pwd)
    else
        echo '[S] '(whoami)'@'(hostname)' - '(path_relative_to_home (pwd))
    end
end
