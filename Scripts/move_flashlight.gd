extends Node

var mat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = self.material as ShaderMaterial
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	var rel_mouse_pos = Vector2(remap(mouse_pos.x, 0, screen_size.x, 0, 1.0),remap(mouse_pos.y, 0, screen_size.y, 0, 1.0))
	mat.set_shader_parameter("center", rel_mouse_pos)
