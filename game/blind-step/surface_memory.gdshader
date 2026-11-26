shader_type spatial;

uniform sampler2D exposure_map : filter_nearest, repeat_disable;
uniform float clock_seconds;
uniform float trace_until;
varying flat ivec3 face_grid;

void vertex() {
	face_grid = ivec3(round(CUSTOM0.xyz));
}

// Cubic B-spline weights for four adjacent samples on one axis.
vec4 weights(float t) {
	float s = 1.0 - t;
	return vec4(s*s*s, 4.0 - 6.0*t*t + 3.0*t*t*t,
			1.0 + 3.0*t + 3.0*t*t - 3.0*t*t*t, t*t*t) / 6.0;
}

float sample_trace(ivec2 cell, int atlas_width) {
	cell = clamp(cell, ivec2(0), face_grid.yz - ivec2(1));
	int i = face_grid.x + cell.y * face_grid.y + cell.x;
	vec4 stamp = texelFetch(exposure_map, ivec2(i % atlas_width, i / atlas_width), 0);
	vec2 fade = clamp((stamp.rg - clock_seconds) / vec2(1.8, 3.5), vec2(0.0), vec2(1.0));
	return max(fade.x * stamp.b * 0.13, fade.y * stamp.a * 0.22);
}

void fragment() {
	float remembered = 0.0;
	if (clock_seconds < trace_until) {
		ivec2 base = ivec2(floor(UV)) - ivec2(1);
		vec4 wx = weights(fract(UV.x));
		vec4 wy = weights(fract(UV.y));
		int width = textureSize(exposure_map, 0).x;
		for (int y = 0; y < 4; y++) {
			for (int x = 0; x < 4; x++) {
				remembered += wx[x] * wy[y] * sample_trace(base + ivec2(x,y), width);
			}
		}
	}
	ALBEDO = COLOR.rgb;
	ROUGHNESS = 0.95;
	EMISSION = COLOR.rgb * vec3(0.65, 0.78, 1.0) * remembered;
}
