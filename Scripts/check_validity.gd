extends Node

var allowedInputs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allowedInputs = get_parent().get_meta("validInputs")
	self.text_changed.connect(_on_text_changed.bind(self))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_text_changed(textfield: TextEdit) -> void:
	# ensure no more than 1 line
	if (textfield.get_line_count() > 1):
		textfield.remove_line_at(1)

	# ensure no more than 1 character, setting it to the most recent (valid) input
	if (textfield.text.length() > 1):
		var isValid = false
		for valid_inputs in allowedInputs:
			if (textfield.text.right(1) == str(valid_inputs)):
				isValid = true
				textfield.text = textfield.text.right(1)
				textfield.set_caret_column(1)
				break
		if (!isValid):
			textfield.text = textfield.text.left(1)
			textfield.set_caret_column(1)
		

	# check the row for errors
	for fields in textfield.get_meta("Row"):
		if(get_node(fields) != textfield):
			_check_for_errors(get_node(fields), textfield.text)


# the above class needs to do the following:
# - ensure there is only one character per box (unless they're notes)
#	- or i could just not have notes, but they are QoL
# - check if there are any duplicates in the same row, column, or region (or other errors in harder puzzles)
#	- this uses the metadata of the TextEdit fields
#	- if there are errors, they should be highlighted in red
# - ensure that (for normal puzzles) only the digits 1 to 9 are present

func _check_for_errors(textfield: TextEdit, compare_value: Variant) -> void:
	if(str(compare_value) == textfield.text):
		_handle_correctness_changed(textfield, true)
	else:
		_handle_correctness_changed(textfield, false)

func _handle_correctness_changed(textfield: TextEdit, isIncorrect: bool) -> void:
	if(isIncorrect):
		textfield.add_theme_color_override("errorColor",Color(.75,0,0))
	else:
		textfield.remove_theme_color_override("errorColor")
