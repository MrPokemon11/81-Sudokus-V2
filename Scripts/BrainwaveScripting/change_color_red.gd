extends Node

# makes the given label red
func set_red(label: RichTextLabel) -> void:
	label.add_theme_color_override("errorColor",Color(.75,0,0))

# removes the red from a given label
func clear_red(label: RichTextLabel) -> void:
	label.remove_theme_color_override("errorColor")
