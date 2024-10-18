#!/usr/bin/env python

import json
import sys
import enum


class Layout(enum.Enum):
    RULEMAK = "org.sil.ukelele.keyboardlayout.rulemak.rulemak"
    COLEMAK = "com.apple.keylayout.Colemak"


ctrl_w_to_delete_word = {
    "description": "Ctrl-W -> delete word",
    "manipulators": [
        {
            "from": {
                "key_code": "w",
                "modifiers": {"mandatory": ["left_control"], "optional": ["any"]},
            },
            "to": [{"key_code": "delete_or_backspace", "modifiers": ["left_option"]}],
            "type": "basic",
        }
    ],
}

swap_backtick_and_tilde = {
    "description": "Swap backtick and tilde",
    "manipulators": [
        {
            "from": {
                "key_code": "grave_accent_and_tilde",
                "modifiers": {"mandatory": ["left_shift"]},
            },
            "to": [{"key_code": "grave_accent_and_tilde"}],
            "type": "basic",
        },
        {
            "from": {"key_code": "grave_accent_and_tilde"},
            "to": [{"key_code": "grave_accent_and_tilde", "modifiers": ["left_shift"]}],
            "type": "basic",
        },
    ],
}


def holding_modifier_switches_to_colemak(modifier):
    return {
        "description": f"Holding {modifier} switches {Layout.RULEMAK.value.split('.')[-1]} -> {Layout.COLEMAK.value.split('.')[-1]}.",
        "manipulators": [
            {
                "to_after_key_up": [
                    {"select_input_source": {"input_source_id": Layout.RULEMAK.value}}
                ],
                "from": {"key_code": modifier, "modifiers": {"optional": ["any"]}},
                "to": [
                    {"select_input_source": {"input_source_id": Layout.COLEMAK.value}},
                    {"key_code": modifier},
                ],
                "conditions": [
                    {
                        "input_sources": [{"input_source_id": Layout.RULEMAK.value}],
                        "type": "input_source_if",
                    }
                ],
                "type": "basic",
            }
        ],
    }


modifiers_switch_to_colemak = [
    holding_modifier_switches_to_colemak(modifier)
    for modifier in (
        "left_command",
        "left_control",
        "left_option",
        "right_command",
        "right_control",
        "right_option",
    )
]


f20_turns_on_launcher_mode = {
    "description": "launcher -> activation",
    "manipulators": [
        {
            "from": {"key_code": "f20", "modifiers": {"optional": ["any"]}},
            "to": [
                {"set_variable": {"name": "launcher_mode", "value": 1}},
                {
                    "set_notification_message": {
                        "id": "launcher_mode_notification",
                        "text": "LAUNCHER",
                    }
                },
            ],
            "conditions": [
                {"name": "launcher_mode", "value": 0, "type": "variable_if"}
            ],
            "type": "basic",
        }
    ],
}


f20_in_launcher_mode_does_cmd_tab = {
    "description": "launcher -> f20 switches to the previous app",
    "manipulators": [
        {
            "from": {"key_code": "f20", "modifiers": {"optional": ["any"]}},
            "to": [
                {"set_variable": {"name": "launcher_mode", "value": 0}},
                {
                    "set_notification_message": {
                        "id": "launcher_mode_notification",
                        "text": "",
                    }
                },
                {"key_code": "tab", "modifiers": ["left_command"]},
            ],
            "conditions": [
                {"name": "launcher_mode", "value": 1, "type": "variable_if"}
            ],
            "type": "basic",
        }
    ],
}


any_key_in_launcher_mode_switches_it_off = {
    "description": "launcher -> deactivation",
    "manipulators": [
        {
            "from": {"any": "key_code", "modifiers": {"optional": ["any"]}},
            "to": [
                {"set_variable": {"name": "launcher_mode", "value": 0}},
                {
                    "set_notification_message": {
                        "id": "launcher_mode_notification",
                        "text": "",
                    }
                },
            ],
            "conditions": [
                {"name": "launcher_mode", "value": 1, "type": "variable_if"}
            ],
            "type": "basic",
        }
    ],
}


def launcher_mode_select_input_source(key_code, to_layout):
    return {
        "description": f"launcher {key_code} -> switch to {to_layout}",
        "manipulators": [
            {
                "from": {"key_code": key_code, "modifiers": {"optional": ["any"]}},
                "to": [
                    {"set_variable": {"name": "launcher_mode", "value": 0}},
                    {
                        "set_notification_message": {
                            "id": "launcher_mode_notification",
                            "text": "",
                        }
                    },
                    {"select_input_source": {"input_source_id": to_layout}},
                ],
                "conditions": [
                    {"name": "launcher_mode", "value": 1, "type": "variable_if"}
                ],
                "type": "basic",
            }
        ],
    }


def launcher_mode_shell_command(key_code, shell_command, *, description=None):
    return {
        "description": description or f"launcher_{key_code} -> {shell_command}",
        "manipulators": [
            {
                "from": {"key_code": key_code, "modifiers": {"optional": ["any"]}},
                "to": [
                    {"set_variable": {"name": "launcher_mode", "value": 0}},
                    {
                        "set_notification_message": {
                            "id": "launcher_mode_notification",
                            "text": "",
                        }
                    },
                    {"shell_command": shell_command},
                ],
                "conditions": [
                    {"name": "launcher_mode", "value": 1, "type": "variable_if"}
                ],
                "type": "basic",
            }
        ],
    }


def launcher_mode_to_open_app(key_code, app):
    shell_command = f"open -a '{app}'"
    description = f"launcher_{key_code} -> {app}"
    return launcher_mode_shell_command(key_code, shell_command, description=description)


launcher_mode_commands = [
    launcher_mode_to_open_app("spacebar", "kitty.app"),
    launcher_mode_to_open_app("j", "Brave Browser.app"),
    launcher_mode_to_open_app("k", "Visual Studio Code.app"),
    launcher_mode_to_open_app("d", "Spotify.app"),
    launcher_mode_to_open_app("f", "Telegram.app"),
    launcher_mode_to_open_app("u", "Obsidian.app"),
    launcher_mode_select_input_source("hyphen", Layout.COLEMAK.value),
    launcher_mode_select_input_source("equal_sign", Layout.RULEMAK.value),
    f20_in_launcher_mode_does_cmd_tab,
]


launcher_mode_modifications = [f20_turns_on_launcher_mode]
launcher_mode_modifications += launcher_mode_commands
launcher_mode_modifications += [any_key_in_launcher_mode_switches_it_off]

complex_modifications = modifiers_switch_to_colemak
complex_modifications += [ctrl_w_to_delete_word, swap_backtick_and_tilde]
complex_modifications += launcher_mode_modifications


simple_modifications = [
    {"from": {"key_code": "caps_lock"}, "to": [{"key_code": "left_shift"}]},
    {"from": {"key_code": "right_command"}, "to": [{"key_code": "left_control"}]},
    {"from": {"key_code": "non_us_backslash"}, "to": [{"key_code": "f20"}]},
]


def output(conf):
    print(json.dumps(conf, indent=4))


def main():
    if len(sys.argv) > 2:
        raise Exception("Bad args.")

    if len(sys.argv) == 1:
        output(complex_modifications)
    else:
        with open(sys.argv[1]) as config:
            initial = json.load(config)

        replacement_point = initial
        complex_modifications_pointer = (
            "profiles",
            0,
            "complex_modifications",
            "rules",
        )
        for pt in complex_modifications_pointer[:-1]:
            replacement_point = replacement_point[pt]
        replacement_point[complex_modifications_pointer[-1]] = complex_modifications

        replacement_point = initial
        simple_modifications_pointer = (
            "profiles",
            0,
            "simple_modifications",
        )
        for pt in simple_modifications_pointer[:-1]:
            replacement_point = replacement_point[pt]
        replacement_point[simple_modifications_pointer[-1]] = simple_modifications

        output(initial)


if __name__ == "__main__":
    main()
