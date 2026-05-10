extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		self.text_change_rejected.connect(_on_text_change_rejected)
		self.text_changed.connect(_on_text_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# use LineEdit (max 1 character)
# when text is changed, check if there are any conflicts
#	if the inserted character isn't valid for the puzzle, clear the LineEdit
# when text change is rejected (ie entered when there's already something it it) replace the current text with the rejected text
func _on_text_change_rejected(rejected_substring) -> void:
	self.text = rejected_substring
	
func _on_text_changed(textfield: LineEdit) -> void:
	pass
