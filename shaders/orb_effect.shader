shader_type canvas_item;

void fragment() {
	vec4 curr_color = abs(sin(texture(TEXTURE,UV) * TIME));
	COLOR = curr_color;
}