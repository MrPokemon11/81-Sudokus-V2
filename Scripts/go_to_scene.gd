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
	
	GlobalSceneLoad.load_scene(lvlNum)
	
	#if (lvlNum.containsn("Next")): # proceed to the next uncompleted level
		#lvlNum = handle_next_level()	
	

	
	
	
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
	
	if not DirAccess.dir_exists_absolute("user://Scenes/Levels/"):
		DirAccess.make_dir_recursive_absolute("user://Scenes/Levels/")
	
	# returning to level select throws an error
	
	if(get_tree().current_scene.name == "MainScene"):
		if !FileAccess.file_exists("user://Scenes/MainScene.tscn"):
			if FileAccess.file_exists("res://Scenes/MainScene.tscn"):
				DirAccess.copy_absolute("res://Scenes/MainScene.tscn","user://Scenes/MainScene.tscn")
		
		packed_scene.take_over_path("user://Scenes/MainScene.tscn")
		packed_scene.pack(get_tree().current_scene)

		ResourceSaver.save(packed_scene, "user://Scenes/MainScene.tscn")

	else:
		if !FileAccess.file_exists("user://Scenes/Levels/" + get_tree().current_scene.name + ".tscn"):
			if FileAccess.file_exists("res://Scenes/Levels/" + get_tree().current_scene.name + ".tscn"):
				DirAccess.copy_absolute("res://Scenes/Levels/" + get_tree().current_scene.name + ".tscn","user://Scenes/Levels/" + get_tree().current_scene.name + ".tscn")
		
		packed_scene.take_over_path("user://Scenes/Levels/" + get_tree().current_scene.name + ".tscn")
		packed_scene.pack(get_tree().current_scene)
		
		ResourceSaver.save(packed_scene, "user://Scenes/Levels/" + get_tree().current_scene.name + ".tscn")



	



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
		
	
	
