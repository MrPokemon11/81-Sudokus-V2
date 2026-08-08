@tool
extends EditorScript

var grid_values = []
var grid_locations = []
var cell_regions = []
var clear_grid = false

# called when the tool is run
func _run() -> void:
	# given values (ie 1, 2, A, B, etc) go in here
	grid_values = ['D',4,8,'B','G',7,9,4,3,5,'G','C',8,1,3,'E','F',1,2,4,4,'G','B','A',3,
		6,'C','B',2,7,'D',3,5,9,4,1,'G','D',2,4,7,6,'E',8,4,5,9,6,'G','E','C',3,3,8,'E','G',9,'A',4,
		4,5,'D','C','F',5,'A',3,'E','D',6,4,8,2,'G','D',8,'G',4,6,7,'A',5,'B','E','C','E',1,5,4,'D','A',
		3,7,'A','E',8,'G',4,5,4,7,6,'D','A','G','B','C',4,'G',1,'D','B','C',8,'F','A','C',1,4,8,9,'F',7,'E',5]
	# the locations of the above given values go here. Note that the grid is 1 indexed.
	grid_locations = [5,9,10,13,15,17,19,20,22,25,28,30,31,32,34,36,37,44,45,46,55,56,58,60,61,62,
		67,69,71,72,73,74,75,76,79,80,81,82,83,84,86,88,90,95,96,98,99,100,101,106,107,109,111,113,114,117,118,119,121,124,
		129,139,140,143,144,145,147,149,151,152,153,155,158,159,160,162,163,164,165,166,170,172,173,174,176,177,179,182,184,190,192,
		195,196,197,198,200,206,207,210,211,213,215,217,218,219,223,224,225,227,228,230,232,234,237,238,239,242,247,248,249,251,252,253,254,255]
	# each array is a region, containing every cell within that region.
	# it still needs to be manually filled, but it's faster than setting them in the editor. Probably.
	# also, the grid is still 1 indexed.
	cell_regions = [[1,2,3,4,17,18,19,20,33,34,35,36,49,50,51,52],
					[5,6,7,8,21,22,23,24,37,38,39,40,53,54,55,56],
					[9,10,11,12,25,26,27,28,41,42,43,44,57,58,59,60],
					[13,14,15,16,29,30,31,32,45,46,47,48,61,62,63,64],
					[65,66,67,68,81,82,83,84,97,98,99,100,113,114,115,116],
					[69,70,71,72,85,86,87,88,101,102,103,104,117,118,119,120],
					[73,74,75,76,89,90,91,92,105,106,107,108,121,122,123,124],
					[77,78,79,80,93,94,95,96,109,110,111,112,125,126,127,128],
					[129,130,131,132,145,146,147,148,161,162,163,164,177,178,179,180],
					[133,134,135,136,149,150,151,152,165,166,167,168,181,182,183,184],
					[137,138,139,140,153,154,155,156,169,170,171,172,185,186,187,188],
					[141,142,143,144,157,158,159,160,173,174,175,176,189,190,191,192],
					[193,194,195,196,209,210,211,212,225,226,227,228,241,242,243,244],
					[197,198,199,200,213,214,215,216,229,230,231,232,245,246,247,248],
					[201,202,203,204,217,218,219,220,233,234,235,236,249,250,251,252],
					[205,206,207,208,221,222,223,224,237,238,239,240,253,254,255,256]]
	
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
