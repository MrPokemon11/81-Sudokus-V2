extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed.bind(self.get_meta("Destination")))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed(target: String):
	if(FileAccess.file_exists(target)):
		get_tree().change_scene_to_file(target)
	else:
		printerr("Scene \"" + target + "\" not found!")
	pass
