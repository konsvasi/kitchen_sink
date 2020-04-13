shader_type canvas_item;

void fragment() {
	float amp = 0.1;
	float freq = 0.05;
	float scale = 5.0;
	
	// Convert the y coordinate from a 0 -> 1 to a 0 -> height value.
	vec2 image_size = vec2(textureSize(TEXTURE, 0));
	float y = UV.y * image_size.y;
	float x = UV.x * image_size.x;
	
	// Get the offset
	float disty = amp * sin(freq * x + scale * TIME);
	
	// Set the coordinate for where the color of a given pixel should come from.
	vec2 new_uv = UV + vec2(disty, 0.0);
	new_uv = mod(new_uv, vec2(1.0));
	
	// Set the correct color for each fragment
	COLOR = texture(TEXTURE, new_uv);
}