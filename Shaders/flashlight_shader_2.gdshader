shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius : hint_range(0.0, 1.0) = 0.15;

// copied directly from Google
void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = SCREEN_UV;
	uv.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
    vec2 adj_center = center;
    adj_center.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;

    // Calculate distance from the pixel to the circle center
    float dist = distance(uv, adj_center);

    // Everything inside the radius is invisible (alpha 0), outside is visible (alpha 1)
    if (dist < radius) {
        COLOR.a = 0.0;
    } else {
        COLOR.a = 1.0;
    }
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
