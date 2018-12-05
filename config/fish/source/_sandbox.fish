# j --complete sav | awk -F'__' '{ OFS = ""; $1 = $2 = ""; print $0 }' | uniq | fzf +m

# sed -i'' 's/[[:space:]]*$//g' *.sql
# sed -i'' 's/\t/    /g' *.sql
# https://stackoverflow.com/questions/16768776/convert-line-endings

# function sudo
#     if test "$argv" = !!
#         eval command sudo $history[1]
#     else
#         command sudo $argv
#     end
# end

# function fuck
#     echo $argv
#     set ev "sudo $argv"
#     echo $ev
#     eval $ev
# end

# abbr -a !! 'fuck $history[1]'
