extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signal and bind the button's name as an argument
	self.pressed.connect(_on_pressed.bind(self.name))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed(lvlNum: String) -> void:
	if (lvlNum.containsn("Back")):
		get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	else:
		if(FileAccess.file_exists("res://Scenes/" + str(lvlNum) + ".tscn")):
			get_tree().change_scene_to_file("res://Scenes/" + str(lvlNum) + ".tscn")
		else:
			printerr("Level " + str(lvlNum) + " not found.")
