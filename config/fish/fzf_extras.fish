
function ask_confirmation -a prompt
    while true
        read -P $prompt' ' -l is_confirmed
        switch (string lower $is_confirmed)
            case 'yes' 'y'
                return 0
            case 'no' 'n'
                return 1
            case '*'
        end
    end
end

function fkill -a signal
    set -q signal[1]; or set signal '-9'
    set pids_to_kill (
        ps -efww \
        | fzf -m -i +x -e --header-lines=1 \
        | awk '{print $2}'
    )
    if set -q pids_to_kill[1]
        kill $signal $pids_to_kill
        return 0
    else
        echo 'Kill aborted.'
        return 1
    end
end

function array_to_multiline -a arr
    for el in $argv
        echo $el
    end
end

function n
    set -l location_candidates (
        j --complete $argv | awk -F'__' '{ OFS = ""; $1 = $2 = ""; print $0 }'
    ); or return 1
    switch (count $location_candidates)
        case 0
            echo 'No jump location candidates.'
            return 1
        case 1
            cd $location_candidates[1]
            return 0
        case '*'
            set -l jump_location \
                (array_to_multiline $location_candidates | fzf --no-sort +m); \
                and cd $jump_location
            return $status
    end
end
