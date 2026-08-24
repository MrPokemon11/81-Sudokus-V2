@tool
extends EditorScript

var grid_values = []
var grid_locations = []
var cell_regions = []
var clear_grid = false

# called when the tool is run
func _run() -> void:
	# given values (ie 1, 2, A, B, etc) go in here
	grid_values = [
		2,4,7,9,5,6,
		4,9,5,6,3,7,2,1,
		1,8,9,3,4,
		5,6,3,1,4,7,
		7,3,4,8,6,
		6,1,7,4,3,
		1,7,4,6,5,3,
		8,4,3,9,5,7,2,6,
		2,7]
	# the locations of the above given values go here. Note that the grid is 1 indexed.
	grid_locations = [
		2,4,5,6,7,8,
		10,11,13,14,15,16,17,18,
		22,24,25,26,27,
		30,31,32,34,35,36,
		37,38,39,40,43,
		46,47,49,51,52,
		55,56,59,60,62,63,
		64,65,66,67,68,69,70,72,
		73,80]
	# each array is a region, containing every cell within that region.
	# it still needs to be manually filled, but it's faster than setting them in the editor. Probably.
	# also, the grid is still 1 indexed.
	cell_regions = [[1,2,3,10,11,12,19,20,21], #top left
					[4,5,6,13,14,15,22,23,24], # top middle
					[7,8,9,16,17,18,25,26,27], # top right
					[28,29,30,37,38,39,46,47,48], # middle left
					[31,32,33,40,41,42,49,50,51], # true middle
					[34,35,36,43,44,45,52,53,54], # middle right
					[55,56,57,64,65,66,73,74,75], # bottom left
					[58,59,60,67,68,69,76,77,78], # bottom middle
					[61,62,63,70,71,72,79,80,81]] # bottom right
	
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
	
	# default regions for 16x16
	# 	cell_regions = [[1,2,3,4,17,18,19,20,33,34,35,36,49,50,51,52],
					#[5,6,7,8,21,22,23,24,37,38,39,40,53,54,55,56],
					#[9,10,11,12,25,26,27,28,41,42,43,44,57,58,59,60],
					#[13,14,15,16,29,30,31,32,45,46,47,48,61,62,63,64],
					#[65,66,67,68,81,82,83,84,97,98,99,100,113,114,115,116],
					#[69,70,71,72,85,86,87,88,101,102,103,104,117,118,119,120],
					#[73,74,75,76,89,90,91,92,105,106,107,108,121,122,123,124],
					#[77,78,79,80,93,94,95,96,109,110,111,112,125,126,127,128],
					#[129,130,131,132,145,146,147,148,161,162,163,164,177,178,179,180],
					#[133,134,135,136,149,150,151,152,165,166,167,168,181,182,183,184],
					#[137,138,139,140,153,154,155,156,169,170,171,172,185,186,187,188],
					#[141,142,143,144,157,158,159,160,173,174,175,176,189,190,191,192],
					#[193,194,195,196,209,210,211,212,225,226,227,228,241,242,243,244],
					#[197,198,199,200,213,214,215,216,229,230,231,232,245,246,247,248],
					#[201,202,203,204,217,218,219,220,233,234,235,236,249,250,251,252],
					#[205,206,207,208,221,222,223,224,237,238,239,240,253,254,255,256]]
	
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
