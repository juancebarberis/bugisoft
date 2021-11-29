shader_type canvas_item;

uniform float offset = 1f;

void fragment() {
	vec4 g_channel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 r_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	vec4 b_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	COLOR = vec4(r_channel.r, g_channel.g, b_channel.b, 1f);
}

