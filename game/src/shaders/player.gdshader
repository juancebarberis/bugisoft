shader_type canvas_item;

uniform vec4 player_color: hint_color = vec4(1.0);
uniform float player_color_modifier: hint_range(0.0, 1.0) = 0; 

// fragment shader, pixel colors
void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, player_color.rgb, player_color_modifier);
	COLOR = color;
}  