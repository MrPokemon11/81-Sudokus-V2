@tool
extends EditorScript

var numSectors = 7

func _run() -> void:
	for sector in numSectors:
		var currSector : int = sector+1
		var currSectorGroup = "Sector" + str(currSector)
		for node in get_scene().get_tree().get_nodes_in_group(currSectorGroup):
			node.theme = load("res://Themes/Sectors/" + currSectorGroup +".tres")
	pass # Replace with function body.
