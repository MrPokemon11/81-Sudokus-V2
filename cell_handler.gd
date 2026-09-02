extends Node

@export var saved_vals: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(saved_vals)
	var stringarray: Array[String]
	for str in get_meta("saved_values"):
		if str == null:
			stringarray.append("")
		else:
			stringarray.append(str)
	
	if saved_vals.size() == 0:
		saved_vals = stringarray
	
	#print(saved_vals)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_cell_value(cellnum: int, value: String) -> void:
	saved_vals[cellnum-1] = value
	pass

func get_saved_vals() -> Array[String]:
	return saved_vals

func load_saved_vals():
	var TextEditHolder = find_children("TextEdits")[0]
	for cell in TextEditHolder:
		var TEditCell = TextEditHolder.get_child(cell)
		TEditCell.text = saved_vals[cell]
		TEditCell.set_label()
	
func load_saved_vals_held(input: Array[String]):
	if input == null or input.size() == 0:
		return
	
	var TextEditHolder = find_children("TextEdits")[0]
	var iter = 0
	for cell in TextEditHolder.get_children():
		
		cell.text = input[iter]
		cell.set_label()
		iter += 1
