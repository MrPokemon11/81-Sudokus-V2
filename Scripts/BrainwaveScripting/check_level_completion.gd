extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# check whether the level is complete
func check_completion() -> bool:
	# if any child has an error, the level is not complete
	if(get_tree().get_node_count_in_group("hasError") > 0):
		print("Child has error") # debug
		return false
	
	# if there are no errors, check if every cell is filled. if not, the level is not complete
	for node in get_children():
		if node.text == "":
			print("Child is empty") # debug
			return false
	
	# if both previous checks pass without returning, the level is complete
	print("Level complete!") # debug
	return true
