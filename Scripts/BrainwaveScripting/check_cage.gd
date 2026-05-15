extends "res://Scripts/BrainwaveScripting/extra_rule_base.gd"

var cage_value: int
var cage_group_name: String
var color_default

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cage_value = get_meta("CageValue")
	color_default = self.default_color
	
	# the cage should be in exactly one (non-internal) group. If it isn't, throw an error
	var cage_check = []
	for group in get_groups():
		if not group.begins_with("_"):
			cage_check.push_back(group)
	if cage_check.size() != 1:
		printerr("The cage " + self.name + " has a group error! It is in the following groups: " + cage_check)
	else:
		cage_group_name = cage_check[0]
	
	connect_to_group_members()
	print(cage_check)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_receive_signal() -> void:
	check_cage()

func check_groups_for_errors():
	check_cage()

func check_cage():
	# make variables
	var sum : int = 0
	var hasEmptyCell = false
	
	# check for self-reflection, unfilled cells, and cells that contain letters
	# if a cell reaches the else statement, add it's value to the sum
	for values in get_tree().get_nodes_in_group(cage_group_name):
		if values == self:
			continue
		elif values.text == "":
			hasEmptyCell = true
			continue
		elif values.text.is_valid_int() == false:
			continue
		else:
			sum += values.text.to_int()
	
	# compare the sum of the cage to the assigned value
	# if it exceeds the value, or the cage is full, add to hasError and set the color to red
	# when the error is cleared, reset the color and remove from hasError
	if (sum > cage_value) or (hasEmptyCell == false and sum != cage_value):
		self.add_to_group("hasError", true)
		self.default_color = Color(1.0, 0.247, 0.184, 1.0)
		get_child(0).add_theme_color_override("default_color",Color(1.0, 0.247, 0.184, 1.0))
	else:
		self.remove_from_group("hasError")
		self.default_color = color_default
		get_child(0).remove_theme_color_override("default_color")
	pass
	
	# things this script must do:
	# - throw an error if the sum of the values within the cage exceeds the cage's value
	# - throw an error if all cells within the cage are full, but are lower than the cage's value
