extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _save_data() -> bool:
	
	
	var packed_scene = PackedScene.new()
	
	# returning to level select throws an error
	
	if(self.name == "MainScene"):
		packed_scene.take_over_path("user://Scene/" + self.name + "./tscn")
		packed_scene.pack(get_tree().current_scene)
		if FileAccess.file_exists("user://Scene/" + self.name + "./tscn"):
			ResourceSaver.save(packed_scene, "user://Scene/" + self.name + "./tscn")
			return true
		else:
			return false
	else:
		packed_scene.take_over_path("user://Scene/Levels/" + self.name + "./tscn")
		packed_scene.pack(get_tree().current_scene)
		if FileAccess.file_exists("user://Scene/Levels/" + self.name + "./tscn"):
			ResourceSaver.save(packed_scene, "user://Scene/Levels/" + self.name + "./tscn")
			return true
		else:
			return false
	

func _load_data() -> void:
	pass
