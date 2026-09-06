extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# check whether the level is complete
func check_completion() -> bool:
	# debug
	if(get_tree().get_node_count_in_group("hasError") > 0):
		print("Child has error, num errors:" + str(get_tree().get_node_count_in_group("hasError"))) 
	else:
		print("No errors.")
	
	var cellsFilled = true
	for node in get_children():
		if node.get_value_special() == "":
			#print("Child is empty") # debug
			cellsFilled = false
			return false
	
	
	get_tree().call_group("hasError", "check_groups_for_errors")
	
	# if any child has an error, the level is not complete
	if(get_tree().get_node_count_in_group("hasError") > 0):
		#print("Child has error, num errors:" + str(get_tree().get_node_count_in_group("hasError"))) # debug
		return false
	
	# if there are no errors, check if every cell is filled. if not, the level is not complete

	
	# if both previous checks pass without returning, the level is complete
	#print("Level complete!") # debug
	get_tree().root.add_to_group("CompletedLevels", true) # adds the root node for the current level to the CompletedLevels group
	
	# loads the Sudoku Complete Screen
	var result: Node = null
	if ResourceLoader.exists("res://Scenes/SudokuComplete.tscn"): 
		result = ResourceLoader.load("res://Scenes/SudokuComplete.tscn").instantiate()
		if result:
				get_tree().root.add_child(result)
	
	return true
