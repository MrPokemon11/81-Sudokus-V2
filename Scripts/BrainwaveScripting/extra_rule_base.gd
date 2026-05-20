extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func connect_to_group_members():
	# get all the groups this node is a part of. This should really only be used for TextEdit fields
	var group_array = []
	for groups in get_groups():
		if not groups.begins_with("_"):
			group_array.push_back(groups)
	
	# connect text changing to a signal
	for groups in group_array:
		for members in get_tree().get_nodes_in_group(groups):
			if members != self:
				members.text_changed.connect(_on_receive_signal)
	

func _on_receive_signal() -> void:
	pass
