# Anaconda

set conda_path '/usr/local/anaconda3/bin/conda'
test -f $conda_path; and eval $conda_path "shell.fish" "hook" $argv | source

function pt --wraps pytest
    pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb $argv
end
