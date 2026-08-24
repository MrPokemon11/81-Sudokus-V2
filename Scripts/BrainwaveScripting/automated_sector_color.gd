@tool
extends EditorScript

var numSectors = 7

func _run() -> void:
	for sector in numSectors:
		var currSector = sector+1
		var currSectorGroup = "Sector" + currSector.to_string()
		for node in get_scene().get_tree().get_nodes_in_group(currSectorGroup):
			node.control.set_theme_item
	pass # Replace with function body.
