shader_type canvas_item;

uniform float progress;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 offset = vec2(progress, 0);
	vec2 uv = UV + offset;
	uv = vec2(uv.x - floor(uv.x), uv.y - floor(uv.y));
	COLOR = texture(TEXTURE, uv);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
