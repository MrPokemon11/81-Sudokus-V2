extends Node

# this is the "main brain" of the cells within each puzzle.

var idNum
var allowedInputs
var hasError = false
var error_checked = false
var this_label

func _ready() -> void:
	idNum = self.name.right(-8).to_int() # this will remove "TextEdit" from the name, leaving just the number
	allowedInputs = get_parent().get_meta("validInputs")
	self.text_changed.connect(_on_text_changed.bind(self))
	this_label = get_child(0)
	
	#debug
	#self.focus_entered.connect(focus_debug)
	
	# this code adds each node to a row and column automatically.
	# regions needs to be done manually because they're not always square,
	# but at least i only need to do 1/3 of the work :P
	var column_count = get_parent().columns
	var this_row = floor((idNum-1) / column_count)
	var this_column = idNum % column_count
	self.add_to_group("Row" + str(this_row), true)
	self.add_to_group("Column" + str(this_column), true)

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
	# Stores the node's non-internal groups only (as an array of StringNames).
	# taken directly from the docs
	var non_internal_groups = []
	for group in get_groups():
		if not str(group).begins_with("_"):
			non_internal_groups.push_back(group)	
	
	# get the nodes in the same row, column, and region as this node (there will be duplicates but w/e)
	var nodes = []
	for group in non_internal_groups:
		for node in get_tree().get_nodes_in_group(group):
			if not node.name == self.name:
				nodes.push_back(node)
	
	# check each row, column, and region for duplicate values
	for node in nodes:
		var eqChecker = node.check_for_issues(self.text)
		if(eqChecker):
			hasError = true
	
	if(hasError):
		set_red(this_label)
		#add_to_group("hasError", true)
	else:
		clear_red(this_label)
		remove_from_group("hasError")

# check whether the comparison string is the same as this node's text, and if so, make the label red
# current issues: this will clear red even if there are still other errors
func check_for_issues(comparator: String) -> bool:
	var isEqual = check_equality(self.text, comparator)
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

# debug
#func focus_debug():
	#print(get_groups())
