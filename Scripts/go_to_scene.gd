extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signal and bind the button's name as an argument
	self.pressed.connect(_on_pressed.bind(self.name))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# loads the relevant scene/level
func _on_pressed(lvlNum: String) -> void:
	
	save_level() #need to do more work on this func but it still goes first
	
	#if (lvlNum.containsn("Next")): # proceed to the next uncompleted level
		#lvlNum = handle_next_level()	
	
	#new level load system
	var next_scene_res

	if (lvlNum.containsn("Back")):
		next_scene_res = load_with_fallback("user://Scene/MainScene.tscn","res://Scenes/MainScene.tscn")
	else:
		next_scene_res = load_with_fallback("user://Scenes/Levels/" + str(lvlNum) + ".tscn","res://Scenes/Levels/" + str(lvlNum) + ".tscn")
	
	var next_scene_inst = next_scene_res.instantiate()
	
	if (lvlNum.containsn("Back")):
		if lvlNum.containsn("BackToLevels"):
			get_tree().current_scene.add_to_group("CompletedLevels", true)
		
	else:
		next_scene_inst.load_saved_vals()
	
	
	
	
	
	#old level load system
	#if (lvlNum.containsn("Back")): # return to the level select screen
		#if FileAccess.file_exists("user://Scene/MainScene.tscn"):
			#get_tree().change_scene_to_file("user://Scenes/MainScene.tscn")
		#else:
			#get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	#else: # go to a specific level
		#if(FileAccess.file_exists("user://Scenes/Levels/" + str(lvlNum) + ".tscn")):
			#get_tree().change_scene_to_file("user://Scenes/Levels/" + str(lvlNum) + ".tscn")		
		#elif(FileAccess.file_exists("res://Scenes/Levels/" + str(lvlNum) + ".tscn")):
			#get_tree().change_scene_to_file("res://Scenes/Levels/" + str(lvlNum) + ".tscn")
		#else:
			#printerr("Level " + str(lvlNum) + " not found.")

func save_level():
	var packed_scene = PackedScene.new()
	
	# returning to level select throws an error
	
	if(get_tree().current_scene.name == "MainScene"):
		packed_scene.take_over_path("user://Scene/MainScene.tscn")
		packed_scene.pack(get_tree().current_scene)
		if FileAccess.file_exists("user://Scene/MainScene.tscn"):
			ResourceSaver.save(packed_scene, "user://Scene/MainScene.tscn")
			return true
		else:
			return false
	else:
		packed_scene.take_over_path("user://Scene/Levels/" + get_tree().root.name + ".tscn")
		packed_scene.pack(get_tree().current_scene)
		if FileAccess.file_exists("user://Scene/Levels/" + get_tree().root.name + ".tscn"):
			ResourceSaver.save(packed_scene, "user://Scene/Levels/" + get_tree().root.name + ".tscn")
			return true
		else:
			return false
	

func load_with_fallback(userpath: String, respath: String):
	if(FileAccess.file_exists(userpath)):
		return ResourceLoader.load(userpath)
	elif(FileAccess.file_exists(respath)):
		return ResourceLoader.load(respath)
	
	print("File not found in either path")
	return null

# to do: make a Next Level loader that doesn't lag the larger the gap/# of completed levels
#func handle_next_level() -> String:
	#var result: Node = null
	#if ResourceLoader.exists("res://Scenes/LoadingLabel.tscn"): 
		#result = ResourceLoader.load("res://Scenes/LoadingLabel.tscn").instantiate()
		#if result:
				#get_tree().root.add_child(result)
	#
	#var this_level = get_tree().root.name.right(-5)
	#for i in range(this_level+1,82,1):
		
	
	
