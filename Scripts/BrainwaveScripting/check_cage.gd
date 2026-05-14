extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_cage():
	pass
	
	# things this script must do:
	# - throw an error if the sum of the values within the cage exceeds the cage's value
	# - throw an error if all cells within the cage are full, but are lower than the cage's value
