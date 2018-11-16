# Defined in /Users/d.otroshchenko/.config/up/up.fish @ line 81
function _up
	set --local p (string trim --chars=/ (dirname $PWD) | string split /)

  for d in $p 
    echo $d
  end
end
