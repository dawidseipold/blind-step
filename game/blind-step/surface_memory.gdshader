shader_type spatial;

uniform sampler2D exposure_map : filter_nearest, repeat_disable;
uniform float clock_seconds;
varying float remembered;

void vertex() {
	vec4 expiry = texelFetch(exposure_map, ivec2(UV2), 0);
	float match_trace = clamp((expiry.x - clock_seconds) / 1.8, 0.0, 1.0);
	float torch_trace = clamp((expiry.y - clock_seconds) / 3.5, 0.0, 1.0);
	remembered = max(match_trace * expiry.b * 0.13, torch_trace * expiry.a * 0.22);
}

void fragment() {
	ALBEDO = COLOR.rgb;
	ROUGHNESS = 0.95;
	EMISSION = COLOR.rgb * vec3(0.65, 0.78, 1.0) * remembered;
}
