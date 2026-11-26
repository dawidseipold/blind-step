// Adapted from Bodycam footage (cyanone), radial optics by jamesfrize, grain by zuwiwano. CC0.
shader_type canvas_item;
render_mode unshaded;
uniform sampler2D scene : hint_screen_texture, filter_linear, repeat_disable;
uniform float distortion = 0.22;
uniform float vignette = 0.32;
uniform float noise_amount = 0.12;

void fragment() {
	vec2 p = 2.0 * SCREEN_UV - 1.0;
	float aspect = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	vec2 radial = p * vec2(aspect, 1.0);
	float r = length(radial) / length(vec2(aspect, 1.0));
	float bend = min(0.995, r * sqrt(clamp(distortion * 1.5, 0.0, 0.98)));
	float scale = bend > 0.001 ? asin(bend) / bend : 1.0;
	vec2 uv = 0.5 + 0.5 * p * scale;
	vec2 fringe = 1.5 * SCREEN_PIXEL_SIZE * p * r * r;
	vec3 image = vec3(texture(scene, uv + fringe).r, texture(scene, uv).g, texture(scene, uv - fringe).b);
	float seed = dot(floor(FRAGCOORD.xy), vec2(0.06711056, 0.00583715)) + floor(TIME * 20.0) * 0.031;
	float grain = fract(52.98292 * fract(seed)) - 0.5;
	image += grain * noise_amount * 0.12;
	float edge = max(abs(uv.x - 0.5), abs(uv.y - 0.5));
	float matte = (1.0 - smoothstep(0.48, 0.50, edge)) * (1.0 - smoothstep(0.83, 1.0, r));
	COLOR = vec4(max(image, vec3(0.0)) * matte * (1.0 - vignette * smoothstep(0.25, 0.98, r)), 1.0);
}
