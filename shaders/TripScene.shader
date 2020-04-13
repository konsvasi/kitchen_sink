shader_type canvas_item;

const float PI = 3.1415926535897932384626433832795;
const float amp = 0.1;
const float freq = 0.05;
const float scale = 2.0;

void fragment() {
	vec2 image_size = vec2(textureSize(TEXTURE, 0));
	float x = UV.x * image_size.x;
	float y = UV.y * image_size.y;
	
	// Get the offset
	float distx = amp * sin(freq * y + scale * TIME) * PI;
	float disty = amp * 1.5 * tan(freq * x + scale * TIME) * PI;
	// Set the coordinate for where the color of a given pixel should come from.
	vec2 new_uv = UV + vec2(distx, 0.6);
	new_uv = mod(new_uv, disty);
	
	// Set the correct color for each fragment
	COLOR = texture(TEXTURE, fract(new_uv));
}