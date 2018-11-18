if echo $OSTYPE | grep '^darwin' > /dev/null

    function concat_pdf
        /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py $argv
    end

    function q --wraps man
        set brew_man_path (brew --prefix)'/opt/coreutils/libexec/gnuman'
        man -M $brew_man_path $argv 1>/dev/null 2>&1
        if [ $status = 0 ]
            man -M $brew_man_path $argv
        else
            man $argv
        end
    end

    set -gx PATH '/usr/local/opt/coreutils/libexec/gnubin' $PATH
    set -gx PATH '/usr/local/opt/unzip/bin' $PATH
    set -gx PATH '/usr/local/opt/gnu-sed/libexec/gnubin' $PATH

end
