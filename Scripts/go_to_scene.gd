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
	#if (lvlNum.containsn("Next")): # proceed to the next uncompleted level
		#lvlNum = handle_next_level()	
	
	if (lvlNum.containsn("Back")): # return to the level select screen
		save_level()
		get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	else: # go to a specific level
		if(FileAccess.file_exists("res://Scenes/Levels/" + str(lvlNum) + ".tscn")):
			get_tree().change_scene_to_file("res://Scenes/Levels/" + str(lvlNum) + ".tscn")
		else:
			printerr("Level " + str(lvlNum) + " not found.")

func save_level():
	var completeScreen = get_tree().root.find_child("SudokuCompleteScreen", true, false)
	var currLevelName = get_tree().root.name
	#var packed_scene = PackedScene.new()
	
	if completeScreen:
		completeScreen.free()
	
	#packed_scene.take_over_path("res://Scene/Levels/" + str(currLevelName) + "./tscn")
	#packed_scene.pack(get_tree().current_scene)
	#ResourceSaver.save(packed_scene, "res://Scene/Levels/" + str(currLevelName) + "./tscn")
	
	
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
		
	
	
