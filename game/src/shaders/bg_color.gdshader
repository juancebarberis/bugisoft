shader_type canvas_item;

uniform float bg_r: hint_range(0.0, 1.0) = 1; 
uniform float bg_g: hint_range(0.0, 1.0) = 1; 
uniform float bg_b: hint_range(0.0, 1.0) = 1; 

void fragment() {
	vec4 background = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = vec4(background.r * bg_r, background.g * bg_g, background.b * bg_b, 1f);
	
}
