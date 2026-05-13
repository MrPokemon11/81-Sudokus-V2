extends Node

var quitConf = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	if(!quitConf):
		self.text = "Click to confirm."
		quitConf = true
	else:
		get_tree().quit()
