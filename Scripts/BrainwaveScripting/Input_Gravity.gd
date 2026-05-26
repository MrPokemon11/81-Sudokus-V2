extends "res://Scripts/BrainwaveScripting/text_brain.gd"

func _on_text_changed(textfield: TextEdit) -> void:
	# debug
	#print(self.focus_neighbor_bottom)
	
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
	
	this_label.text = textfield.text
	
	# this should work recursively
	if (idNum + column_count < get_parent().get_child_count()) && self.text != "": # if this is false, this is the bottom of the grid
		var cell_below = get_node(self.focus_neighbor_bottom)
		var is_cell_below_given = false
		if cell_below.placeholder_text != "":
			is_cell_below_given = true
		
		if textfield.text == "-":
			self.text = ""
			if is_cell_below_given:
				pass
			elif cell_below.text != "":
				cell_below.text = ""
			else:
				cell_below.text = "-"
		else:
			if cell_below.get_value_special() != "":
				pass
			else:
				cell_below.text = self.text
				self.text = ""
	elif self.text != "":
		if self.text == "-":
			self.text = ""

	check_groups_for_errors()
	get_tree().call_group("hasError", "check_groups_for_errors")
