if set -q is_criteo
debug_echo 'Loading Criteo-specific config ...'


if [ $has_conda != 0 ]
    conda activate ufom
end

function bootstrapgit
    set gitdir (git rev-parse --git-dir)
    scp -p -P 29418 (whoami)@review.criteois.lan:hooks/commit-msg $gitdir/hooks/
end

end
