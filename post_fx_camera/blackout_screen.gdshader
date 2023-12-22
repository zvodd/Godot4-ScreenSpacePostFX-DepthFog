shader_type canvas_item;

uniform float black_amount;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

const vec4 blackcol = vec4(0.0,0.0,0.0,1.0);

void fragment() {
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
	float inv_amount = 1.0 - black_amount;
	col = (col * inv_amount) + (blackcol * black_amount);
	COLOR = col;
}

//void fragment() {
//    vec2 uv = SCREEN_UV;
//    float mask = 1.0 - abs(0.5 - uv.y);
//    mask = smoothstep(0.0, 1.0, mask / progress);
//    vec4 col = texture(SCREEN_TEXTURE, uv);
//    COLOR = vec4(col.rgb, mask);
//}