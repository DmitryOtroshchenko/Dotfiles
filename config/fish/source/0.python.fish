# Anaconda
source ~/anaconda3/etc/fish/conf.d/conda.fish

which conda
if [ $status -ne 0 ]
    set -x has_conda 0
end

function pt --wraps pytest
    pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb $argv
end
