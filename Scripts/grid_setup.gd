@tool
extends EditorScript

var grid_values = []
var grid_locations = []
var cell_regions = []

# Called when the node enters the scene tree for the first time.
func _run() -> void:
	# values (ie 1, 2, A, B, etc) go in here
	grid_values = []
	# the locations of the above values go here. Note that the grid is 1 indexed.
	grid_locations = []
	# each array is a region, containing every cell within that region.
	# it still needs to be manually filled, but it's faster than setting them in the editor. Probably.
	# also, the grid is still 1 indexed.
	cell_regions = []
	
	# ensure that the number of locations and number of values is the same.
	# if not, print an error and stop execution.
	if grid_locations.size() != grid_values.size():
		printerr ("Error during grid setup! The list of values and list of locations are different sizes!
		Number of values: " + str(grid_values.size()) +"
		Number of locations: " + str(grid_locations.size()))
		return
	
	var scene_root = get_editor_interface().get_edited_scene_root()
	
	if scene_root:
		# add values to their proper locations
		for index in grid_locations:
			var target_node = scene_root.find_child("TextEdit" + str(grid_locations[index]), true, false)
			if (target_node):
				target_node.placeholder_text = grid_values[index]
			else:
				printerr("Target node not found in current scene. Attempted to find " + target_node.name + " at index " + str(index))
				return

		# assign cells to regions
		for region in cell_regions:
			for cell in region:
				var target_node = scene_root.find_child("TextEdit" + str(grid_locations[cell]), true, false)
				if (target_node):
					target_node.add_to_group("Region" + str(region+1), true)
				else:
					printerr("Target node not found in current scene. Attempted to find " + target_node.name)
					return
		
	else:
		printerr("No scene is current open in the editor.")
		
	pass
