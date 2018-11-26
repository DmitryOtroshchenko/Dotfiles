
function swap
    set nargs (count $argv)
    if [ $nargs = 1 ]
        set fname $argv[1]
        set base_name (file_basename $fname)
        if [ (file_ext $fname) = 'bak' ]
            echo "$fname -> $base_name"
            mv $fname $base_name
        else
            echo "$fname -> $fname.bak"
            mv $fname $fname'.bak'
        end
    else if [ $nargs = 2 ]
        set fname_a $argv[1]
        set fname_b $argv[2]
        echo "$fname_a <-> $fname_b"
        set tmpfile 'tmp.$$'
        mv $fname_a $tmpfile; and mv $fname_b $fname_a; and mv $tmpfile $fname_b
    else
        echo 'Usage:
swap FILE
    Moves FILE_A -> FILE_A.bak.
swap FILE_A FILE_B
    Swaps the respective files.'
    end
end
