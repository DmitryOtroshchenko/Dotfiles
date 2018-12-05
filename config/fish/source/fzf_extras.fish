
function fkill -a signal
    set -q signal[1]; or set signal '-9'
    set pids_to_kill (
        ps -efww \
        | fzf -m -i +x -e --header-lines=1 \
        | awk '{print $2}'
    )
    if set -q pids_to_kill[1]
        kill $signal $pids_to_kill
    else
        echo 'Kill aborted.'
    end
end
