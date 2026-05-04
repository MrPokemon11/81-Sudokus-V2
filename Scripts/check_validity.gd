extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text_changed.connect(_on_text_changed.bind(self))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_changed(textfield: TextEdit) -> void:
	pass # Replace with function body.

# the above class needs to do the following:
# - ensure there is only one character per box (unless they're notes)
# - check if there are any duplicates in the same row, column, or region (or other errors in harder puzzles)
#	- this uses the metadata of the TextEdit fields
#	- if there are errors, they should be highlighted in red
# - ensure that (for normal puzzles) only the digits 1 to 9 are present
