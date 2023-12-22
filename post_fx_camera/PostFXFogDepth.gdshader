shader_type spatial;
render_mode cull_disabled, unshaded;
uniform sampler2D depth_texture : source_color, hint_depth_texture;
uniform sampler2D screen_texture : source_color, hint_screen_texture, repeat_disable, filter_nearest;

uniform vec3 fog_color : source_color;
uniform vec3 noise_color : source_color;
uniform float noise_time_fac : hint_range(0.1, 10);
uniform float fog_distance : hint_range(1, 200);

// Old fasioned sine based noise function found at https://www.shadertoy.com/view/4djSRW
float hashOld12(vec2 p){
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453 + (mod(TIME, 10) / noise_time_fac)) ;
}

// The order of the input colors seems to matter here. Black doesn't work as the second argument
vec3 color_mix(vec3 a, vec3 b, float f ){
	f = clamp(abs(f), 0,1);
	float invf = 1.0 - f;
	return (a*f) + (b*invf);
}

// https://docs.godotengine.org/en/4.0/tutorials/shaders/advanced_postprocessing.html

void vertex() {
  POSITION = vec4(VERTEX, 1.0);
}

void fragment(){
	vec3 screen_color = texture(screen_texture, SCREEN_UV).rgb;
	vec2 screen_coords = SCREEN_UV * 2.0 - 1.0;
	float depth = texture(depth_texture, SCREEN_UV).x;
	vec3 ndc = vec3(screen_coords, depth);
	
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	
	float linear_depth = -view.z;
	float depth_mask_inv = linear_depth / fog_distance;
	
	vec3 twocolornoise = color_mix(fog_color, noise_color, hashOld12(screen_coords));
	ALBEDO = color_mix(twocolornoise, screen_color, depth_mask_inv);
	
//	ALBEDO = vec3(linear_depth) * (1.0 / fog_distance); // uncomment to view the distance as a greyscale image
}

