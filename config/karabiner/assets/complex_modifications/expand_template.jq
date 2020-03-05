def substitute(mod):
    if . | type == "string" then
        . as $template
        | [
            ["\\$main_layout", "com.apple.keylayout.Colemak"],
            ["\\$aux_layout", "org.sil.ukelele.keyboardlayout.rulemak.rulemak"],
            ["\\$modifier", mod]
        ]
        | reduce .[] as $substitution ($template; sub($substitution[0]; $substitution[1]))
    else .
    end;

def substitute_rec(mod): walk(. | substitute(mod));

. as $input
| ["left_control", "left_option", "left_command",
   "right_control", "right_option", "right_command"]
| map($input | substitute_rec(.)) as $manipulators
| $manipulators
