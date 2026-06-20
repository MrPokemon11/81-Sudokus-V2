extends "res://Scripts/BrainwaveScripting/check_cage.gd"

func _ready() -> void:
	var cage_value_value = get_child(0).text
	if cage_value_value != "":
		if cage_value_value.begins_with("[i]"):
			cage_value_value = cage_value_value.right(-3)
		elif cage_value_value.begins_with(":[i] "):
			cage_value_value = cage_value_value.right(-5)
			
		if cage_value_value.is_valid_int():
			cage_value = cage_value_value.to_int()
		else:
			printerr("Sector " + self.name + " does not have a valid value! Sector value is: " + cage_value_value)
	else:
		cage_value = get_meta("CageValue")
	color_default = Color("white")
	
	# the cage should be in exactly one (non-internal) group. If it isn't, throw an error
	var cage_check = []
	for group in get_groups():
		if not group.begins_with("_"):
			cage_check.push_back(group)
	if cage_check.size() != 1:
		printerr("The sector " + self.name + " has a group error! It should be in exactly 1 group, but is in the following groups: " + str(cage_check))
	else:
		cage_group_name = cage_check[0]
	
	# if the sector is the only member of its group, throw an error
	if get_tree().get_nodes_in_group(cage_group_name).size() <= 1:
		printerr("The sector group " + cage_group_name + " has no cells in it!")
	
	connect_to_group_members()
	%RestartButton.pressed.connect(_on_receive_signal)
	#print(cage_check)

func check_cage():
	# make variables
	var sum : int = 0
	var hasEmptyCell = false
	
	# check for self-reflection, unfilled cells, and cells that contain letters
	# if a cell reaches the else statement, add its value to the sum
	for values in get_tree().get_nodes_in_group(cage_group_name):
		if values == self:
			continue
		var cellText = values.get_value_special().to_upper()
		if cellText == "":
			hasEmptyCell = true
			continue
		elif isHex and cellText.is_valid_int() == false:
				match cellText:
					"A":
						sum += 10
					"B":
						sum += 11
					"C":
						sum += 12
					"D":
						sum += 13
					"E":
						sum += 14
					"F":
						sum += 15
		elif cellText.is_valid_int() == false:
			continue
		else:
			sum += cellText.to_int()
	
	# compare the sum of the cage to the assigned value
	# if it exceeds the value, or the cage is full, add to hasError and set the color to red
	# when the error is cleared, reset the color and remove from hasError
	if (sum > cage_value) or (hasEmptyCell == false and sum != cage_value):
		self.add_to_group("hasError", true)
		get_child(0).add_theme_color_override("default_color",Color(1.0, 0.247, 0.184, 1.0))
	else:
		self.remove_from_group("hasError")
		get_child(0).remove_theme_color_override("default_color")
