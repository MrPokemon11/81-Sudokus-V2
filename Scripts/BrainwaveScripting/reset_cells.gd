extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(perform_reset)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# calls the reset function in every cell
func perform_reset():
	var sibling = get_parent().get_node("TextEdits")
	for nibling in sibling.get_children(): # nibling is a gender-neutral variant of niece/nephew
		nibling.reset()
