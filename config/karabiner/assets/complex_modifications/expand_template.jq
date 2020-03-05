
# def substitute:
#     if . | type == "string" then
#         .
#         | sub("\\$main_layout"; "com.apple.keylayout.Colemak")
#         | sub("\\$aux_layout"; "org.sil.ukelele.keyboardlayout.rulemak.rulemak")
#         | sub("\\$modifier"; "left_command")
#     else .
#     end;
# . | walk(substitute)

def substitute:
    if . | type == "string" then
        . as $template
        | [
            ["\\$main_layout", "com.apple.keylayout.Colemak"],
            ["\\$aux_layout", "org.sil.ukelele.keyboardlayout.rulemak.rulemak"],
            ["\\$modifier", "left_command"]
        ]
        | reduce .[] as $substitution ($template; sub($substitution[0]; $substitution[1]))
    else .
    end;
. | walk(substitute)
