# Anaconda
source ~/anaconda3/etc/fish/conf.d/conda.fish
conda activate

function pt --wraps pytest
    pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb $argv
end
