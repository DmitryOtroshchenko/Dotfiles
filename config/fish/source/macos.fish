if uname | grep -i '^darwin' > /dev/null
debug_echo 'Loading MacOS-specific config ...'

set -gx PATH '/usr/local/opt/coreutils/libexec/gnubin' $PATH
set -gx PATH '/usr/local/opt/unzip/bin' $PATH
set -gx PATH '/usr/local/opt/gnu-sed/libexec/gnubin' $PATH

function concat_pdf
    /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py $argv
end

set brew_prefix (brew --prefix)
function gnu_manpath -a name
    echo $brew_prefix'/opt/'$name'/libexec/gnuman/'
end

function q --wraps man
    set -l brew_man_path (gnu_manpath 'coreutils') (gnu_manpath 'gnu-sed') (gnu_manpath 'gawk')
    set -l brew_man_path (string join ':' $brew_man_path)

    man -M $brew_man_path $argv 1>/dev/null 2>&1
    if test $status -eq 0
        man -M $brew_man_path $argv
    else
        man $argv
    end
end

function setup_osx_defaults
    defaults write -g InitialKeyRepeat -int 25
    defaults write -g KeyRepeat -int 2
    # Properly set locale for R.
    defaults write org.R-project.R force.LANG en_US.UTF-8
end

end
