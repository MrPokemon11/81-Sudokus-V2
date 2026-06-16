@tool
extends EditorScript

var grid_values = []
var grid_locations = []
var cell_regions = []
var clear_grid = false

# called when the tool is run
func _run() -> void:
	# given values (ie 1, 2, A, B, etc) go in here
	grid_values = [7,9,8,5,1,8,6,3,9,6,3,1,5,2,4,7,5,2,8,3]
	# the locations of the above given values go here. Note that the grid is 1 indexed.
	grid_locations = [40,49,50,53,56,58,59,60,62,65,67,68,69,71,73,74,76,77,78,80]
	# each array is a region, containing every cell within that region.
	# it still needs to be manually filled, but it's faster than setting them in the editor. Probably.
	# also, the grid is still 1 indexed.
	cell_regions = [[1,2,3,4,5,10,12,13,19],
					[6,7,8,9,14,15,16,18,27],
					[11,17,20,21,22,23,24,25,26],
					[28,29,30,37,38,39,40,47,48],
					[31,32,33,34,35,36,41,50,51],
					[42,43,44,45,52,53,54,62,63],
					[46,49,55,56,57,58,65,66,67],
					[59,60,61,68,69,70,71,72,81],
					[64,73,74,75,76,77,78,79,80]]
	
	# default regions for the classic 9x9 grid (replace cell_regions with the below)
	# 	cell_regions = [[1,2,3,10,11,12,19,20,21], #top left
					#[4,5,6,13,14,15,22,23,24], # top middle
					#[7,8,9,16,17,18,25,26,27], # top right
					#[28,29,30,37,38,39,46,47,48], # middle left
					#[31,32,33,40,41,42,49,50,51], # true middle
					#[34,35,36,43,44,45,52,53,54], # middle right
					#[55,56,57,64,65,66,73,74,75], # bottom left
					#[58,59,60,67,68,69,76,77,78], # bottom middle
					#[61,62,63,70,71,72,79,80,81]] # bottom right
	
	# ensure that the number of locations and number of values is the same.
	# if not, print an error and stop execution.
	if grid_locations.size() != grid_values.size():
		printerr ("Error during grid setup! The list of values and list of locations are different sizes!
		Number of values: " + str(grid_values.size()) +"
		Number of locations: " + str(grid_locations.size()))
		return
	
	var scene_root = EditorInterface.get_edited_scene_root()
	
#	if clear_grid:
#		pass
	
	if scene_root:
		# add values to their proper locations
		for index in range(0,grid_locations.size()):
			var target_node = scene_root.find_child("TextEdit" + str(grid_locations[index]), true, false)
			if (target_node):
				target_node.placeholder_text = str(grid_values[index])
			else:
				printerr("Target node not found in current scene. Attempted to find " + target_node.name + " at index " + str(index))
				return

		# assign cells to regions
		var region_index = 0
		for region in cell_regions:
			for cell in range(0,region.size()):
				var target_node = scene_root.find_child("TextEdit" + str(cell_regions[region_index][cell]), true, false)
				if (target_node):
					target_node.add_to_group("Region" + str(region_index+1), true)
				else:
					printerr("Target node not found in current scene. Attempted to find " + target_node.name)
					return
			region_index += 1
	else:
		printerr("No scene is current open in the editor.")
		
	pass
