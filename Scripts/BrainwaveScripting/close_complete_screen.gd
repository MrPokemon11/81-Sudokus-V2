extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	self.get_parent().get_parent().queue_free()
