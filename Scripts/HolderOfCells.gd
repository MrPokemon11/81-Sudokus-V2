extends Node

@export var heldvalues: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hold(input: Array[String]):
	heldvalues = input

func get_held() -> Array[String]:
	return heldvalues
