shader_type canvas_item;

const float amp = 0.3;
const float freq = 0.02;
const float scale = 3.0;
uniform vec4 color:hint_color;

void fragment()
{
	vec2 u_res = (1.0 / TEXTURE_PIXEL_SIZE).xy;
	vec2 st = FRAGCOORD.xy/u_res.xy;
	st.x *= u_res.x/u_res.y;
	float d = 0.0;

  // Remap the space to -1. to 1.
//  st = st *1.-1.;
	st = st * 1.-1.;

  // Make the distance field
 d = sin(length( abs(st)-.3 )) * TIME * 0.5;
//   d = sin(length( min(abs(st)-.3,0.) )) * TIME;
  //d = sin(length( max(abs(st)-.3,0.01) )) * TIME * 0.5;
//  COLOR = texture(TEXTURE, vec2(fract(d*4.0), fract(d*5.0)));
  // Visualize the distance field
  COLOR = vec4(fract(d*1.0), fract(d*5.0), fract(d*2.5),0.3);
}