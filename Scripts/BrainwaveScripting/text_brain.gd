extends Node

# this is the "main brain" of the cells within each puzzle.

var idNum
var allowedInputs
var hasError = false
var error_checked = false
var this_label
var column_count
@export var allow_multiple_regions = false
@export var auto_focus = true
@export var saved_input: String = ""

func _ready() -> void:
	if saved_input != "":
		self.text = saved_input
	
	idNum = self.name.right(-8).to_int() # this will remove "TextEdit" from the name, leaving just the number
	allowedInputs = get_parent().get_meta("validInputs")
	self.text_changed.connect(_on_text_changed.bind(self))
	this_label = get_child(0)
	self.tab_input_mode = false
	
	# ensure that each cell is part of exactly 1 region, unless multiple regions are explicitly allowed.
	# regions are done manually, but that can lead to human error so better safe than sorry
	var region_check = 0
	for groups in get_groups():
		if groups.begins_with("Region"):
			region_check += 1
	if region_check != 1 and !allow_multiple_regions:
		printerr("The cell " + self.name + " has a region error! It is in this many regions: " + str(region_check))
	
	# the below code block may look silly, but it handles the various ways i've set up the cells
	# why not go back and change things? I'm lazy and this works.
	# Update: The code no longer looks silly, because things no longer worked and I went back and changed things.
	if(self.placeholder_text != ""):
		self.editable = false
		this_label.text = self.placeholder_text
		self["theme_override_colors/font_placeholder_color"] = 00000000
		#self.focus_mode = 0
	
	set_label_font()
	#debug
	#self.focus_entered.connect(focus_debug)
	
	# this code adds each node to a row and column automatically.
	# regions needs to be done manually because they're not always square,
	# but at least i only need to do 1/3 of the work :P
	column_count = get_parent().columns
	var this_row = floor((idNum-1) / column_count)
	var this_column = idNum % column_count
	self.add_to_group("Row" + str(this_row), true)
	self.add_to_group("Column" + str(this_column), true)
	
	if auto_focus:
		apply_focusing()

# handles traversing focus neighbors using arrow keys, since TextEdits usually use them to move the carets
func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			# since there is always only one line and I don't care (much) about the caret's position,
			# i can ignore those (for now)
			
			KEY_UP:
				# if there is a top neighbor, move up
				var top_neighbor = get_node_or_null(self.focus_neighbor_top)
				if top_neighbor:
					top_neighbor.grab_focus()
					get_viewport().set_input_as_handled()
			
			KEY_DOWN:
				# if there is a bottom neighbor, move down
				var bottom_neighbor = get_node_or_null(self.focus_neighbor_bottom)
				if bottom_neighbor:
					bottom_neighbor.grab_focus()
					get_viewport().set_input_as_handled()
			
			KEY_LEFT:
				# if there is a left neighbor, move left
				var left_neighbor = get_node_or_null(self.focus_neighbor_left)
				if left_neighbor:
					left_neighbor.grab_focus()
					get_viewport().set_input_as_handled()
			
			KEY_RIGHT:
				# if there is a right neighbor, move right
				var right_neighbor = get_node_or_null(self.focus_neighbor_right)
				if right_neighbor:
					right_neighbor.grab_focus()
					get_viewport().set_input_as_handled()

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
	
	this_label.text = textfield.text
	

	check_groups_for_errors()
	get_tree().call_group("hasError", "check_groups_for_errors")

# checks text within groups for errors.
# this is separated so that fields with errors can re-check themselves
func check_groups_for_errors():
	hasError = false
	# Gets the cell's row, column, and region
	var regular_cell_groups = []
	for group in get_groups():
		if str(group).begins_with("Region") or str(group).begins_with("Row") or str(group).begins_with("Column"):
			regular_cell_groups.push_back(group)
	
	# get the nodes in the same row, column, and region as this node (there will be duplicates but w/e)
	var nodes = []
	for group in regular_cell_groups:
		for node in get_tree().get_nodes_in_group(group):
			if not node.name == self.name:
				nodes.push_back(node)
	
	# check each row, column, and region for duplicate values
	for node in nodes:
		var eqChecker = node.check_for_issues(self.get_value_special())
		if(eqChecker):
			hasError = true
	
	if(hasError):
		set_red(this_label)
		#add_to_group("hasError", true)
	else:
		clear_red(this_label)
		remove_from_group("hasError")
	
	get_parent().check_completion()

# check whether the comparison string is the same as this node's text, and if so, make the label red
# current issues: this will clear red even if there are still other errors
func check_for_issues(comparator: String) -> bool:
	var isEqual = check_equality(self.get_value_special(), comparator)
	if (isEqual):
		#set_red(this_label)
		add_to_group("hasError", true)
	#else:
		#clear_red(this_label)
	return isEqual

# returns a boolean based on if the given values are identical
func check_equality(input1: String, input2: String) -> bool:
	if (input1.capitalize() == input2.capitalize()):
		return true
	else:
		return false

# makes the given label red
func set_red(label: RichTextLabel) -> void:
	label.add_theme_color_override("default_color",Color(.75,0,0))

# removes the red from a given label
func clear_red(label: RichTextLabel) -> void:
	label.remove_theme_color_override("default_color")

func reset():
	if self.placeholder_text == "":
		self.text = ""
		get_child(0).text = ""
	
	if self.is_in_group("hasError"):
		clear_red(this_label)
		remove_from_group("hasError")

func set_label_font():
	if self.editable:
		this_label.add_theme_font_override("normal_font", load("res://Fonts/Halogen.ttf"))
	else:
		this_label.add_theme_font_override("normal_font", load("res://Fonts/KIN668.TTF"))

# if the cell has placeholder text, return that. Otherwise, return the normal text.
func get_value_special() -> String:
	if self.placeholder_text != "":
		return self.placeholder_text
	else:
		return self.text

func apply_focusing() -> void: # apply Focus via code
	# if this node isn't in the top row, give it a top neighbor
	if idNum > column_count: 
		self.focus_neighbor_top = "../TextEdit" + str(idNum - column_count)
	# if this node isn't in the bottom row, give it a bottom neighbor
	# ONLY WORKS FOR SQUARE GRIDS (which is admittedly true for all that run this code)
	if idNum + column_count < column_count * column_count:
		self.focus_neighbor_bottom = "../TextEdit" + str(idNum + column_count)
	# if this node isn't in the leftmost column, give it a left neighbor
	if idNum % column_count != 1:
		self.focus_neighbor_left = "../TextEdit" + str(idNum - 1)
	# if this node isn't in the rightmost column, give it a right neighbor
	if idNum % column_count != 0:
		self.focus_neighbor_right = "../TextEdit" + str(idNum + 1)
	pass

func save():
	saved_input = self.text

# debug
#func focus_debug():
	#print(get_groups())
