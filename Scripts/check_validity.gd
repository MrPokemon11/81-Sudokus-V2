extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var allowedInputs = get_parent().get_meta("validInputs")
	self.text_changed.connect(_on_text_changed.bind(self, allowedInputs))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_changed(textfield: TextEdit, allowedInputs: Array) -> void:
	pass # Replace with function body.


# the above class needs to do the following:
# - ensure there is only one character per box (unless they're notes)
#	- or i could just not have notes, but they are QoL
# - check if there are any duplicates in the same row, column, or region (or other errors in harder puzzles)
#	- this uses the metadata of the TextEdit fields
#	- if there are errors, they should be highlighted in red
# - ensure that (for normal puzzles) only the digits 1 to 9 are present

func _handle_correctness_changed(textfield: TextEdit, isIncorrect: bool) -> void:
	if(isIncorrect):
		textfield.add_theme_color_override("errorColor",Color(.75,0,0))
	else:
		textfield.remove_theme_color_override("errorColor")
