extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_scene(lvlNum: String):
		#new level load system
	var next_scene_res

	if (lvlNum.containsn("Back")):
		next_scene_res = load_with_fallback("user://Scene/MainScene.tscn","res://Scenes/MainScene.tscn")
	else:
		next_scene_res = load_with_fallback("user://Scenes/Levels/" + str(lvlNum) + ".tscn","res://Scenes/Levels/" + str(lvlNum) + ".tscn")
	
	if next_scene_res == null:
		return
	
	var next_scene_inst = next_scene_res.instantiate()
	
	if (lvlNum.containsn("Back")):
		if lvlNum.containsn("BackToLevels"):
			get_tree().current_scene.add_to_group("CompletedLevels", true)
		
	else:
		var saved = next_scene_inst.get_saved_vals()
		HolderOfCells.hold(saved)
	
	get_tree().change_scene_to_node(next_scene_inst)
	await get_tree().scene_changed
	if (get_tree().current_scene.name != "MainScene"):
		get_tree().current_scene.load_saved_vals_held(HolderOfCells.get_held())

func load_with_fallback(userpath: String, respath: String):
	if(FileAccess.file_exists(userpath)):
		return ResourceLoader.load(userpath)
	elif(FileAccess.file_exists(respath)):
		return ResourceLoader.load(respath)
	
	print("File not found in either path")
	return null
