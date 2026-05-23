shader_type spatial;

instance uniform float ex_rotation : hint_range(0,360) = 0;
instance uniform float speed = 1.0;
instance uniform bool change_over_time = false;

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

void vertex() {
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 rotated_view = rotate(SCREEN_UV, vec2(0.5), ex_rotation);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
