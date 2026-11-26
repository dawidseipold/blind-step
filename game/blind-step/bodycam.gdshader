shader_type canvas_item;
render_mode unshaded;
uniform sampler2D scene : hint_screen_texture, repeat_disable, filter_linear;
uniform float distortion = 0.22;
uniform float vignette = 0.32;
uniform float noise_amount = 0.12;

void fragment() {
	vec2 p = SCREEN_UV * 2.0 - 1.0;
	float aspect = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	vec2 metric = p * vec2(aspect, 1.0);
	float r2 = dot(metric, metric) / (aspect * aspect + 1.0);
	vec2 uv = 0.5 + 0.5 * p * (1.0 + distortion * r2) / (1.0 + distortion);
	vec3 rgb = texture(scene, uv).rgb;
	float luma = dot(rgb, vec3(0.2126, 0.7152, 0.0722));
	float grain = fract(sin(dot(floor(FRAGCOORD.xy) + mod(floor(TIME * 18.0), 97.0), vec2(12.9898,78.233))) * 43758.5453) - 0.5;
	rgb += grain * noise_amount * 0.20 * (1.0 - smoothstep(0.04, 0.45, luma));
	COLOR = vec4(max(rgb, vec3(0.0)) * (1.0 - vignette * smoothstep(0.12, 1.0, r2)), 1.0);
}
