shader_type canvas_item;
render_mode unshaded;
uniform float scanLineCount : hint_range(0, 1080) = 50.0;

vec2 uv_curve(vec2 uv) {
//	uv = (uv - 0.5) * 2.0;
//	uv.x *= uv.y;
//	uv = (uv / 2.0) + 0.5;
	return uv;
}


void fragment() {
	float PI = 3.14159;
	vec4 color = texture(TEXTURE, uv_curve(UV));
	
	float r = texture(TEXTURE, uv_curve(UV) + vec2(SCREEN_PIXEL_SIZE.x * 1.0), 0.0).r;
	float g = texture(TEXTURE, uv_curve(UV) + vec2(SCREEN_PIXEL_SIZE.x * 3.0), 0.0).g;
	float b = texture(TEXTURE, uv_curve(UV) + vec2(SCREEN_PIXEL_SIZE.x * 2.0), 0.0).b;
	
	float s = sin(uv_curve(UV).y * scanLineCount * PI * 2.0);
	s = (s * 0.5 + 0.5) * 0.9 + 0.1;
	
	vec4 scanLine = vec4(vec3(pow(s, 0.25)), 1.0);
	COLOR = vec4(r,g,b, 1.0) * scanLine;
}