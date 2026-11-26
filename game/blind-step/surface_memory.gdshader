shader_type spatial;

uniform sampler2D exposure_map : filter_nearest, repeat_disable;
uniform float clock_seconds;
uniform float trace_until;
uniform float full_exposure = 2.5;
uniform float dots_per_metre = 10.0;
uniform vec2 trace_limits;
varying flat ivec3 face_grid;
varying vec2 surface_position;

void vertex() {
	face_grid = ivec3(round(CUSTOM0.xyz));
	// The course has axis-aligned faces. Project in metres to keep dot spacing
	// consistent across narrow props, wide walls and the floor.
	surface_position = abs(NORMAL.y) > 0.5 ? VERTEX.xz :
			(abs(NORMAL.x) > 0.5 ? VERTEX.zy : VERTEX.xy);
}

// Cubic B-spline weights for four adjacent samples on one axis.
vec4 weights(float t) {
	float s = 1.0 - t;
	return vec4(s*s*s, 4.0 - 6.0*t*t + 3.0*t*t*t,
			1.0 + 3.0*t + 3.0*t*t - 3.0*t*t*t, t*t*t) / 6.0;
}

vec2 sample_trace(ivec2 cell, int atlas_width) {
	cell = clamp(cell, ivec2(0), face_grid.yz - ivec2(1));
	int i = face_grid.x + cell.y * face_grid.y + cell.x;
	vec4 stamp = texelFetch(exposure_map, ivec2(i % atlas_width, i / atlas_width), 0);
	// RG stores expiry, BA stores the lifetime earned by each source.
	vec2 life = stamp.ba;
	vec2 fade = clamp((stamp.rg - clock_seconds) / max(life, vec2(0.0001)), vec2(0.0), vec2(1.0));
	vec2 onset = smoothstep(vec2(0.0), trace_limits * (0.25 / full_exposure), life);
	return fade * onset * pow(clamp(life / trace_limits, vec2(0.0), vec2(1.0)), vec2(0.55));
}

void fragment() {
	vec2 trace = vec2(0.0);
	vec2 grid = surface_position * dots_per_metre;
	float footprint = max(length(dFdx(grid)), length(dFdy(grid)));
	if (clock_seconds < trace_until) {
		ivec2 base = ivec2(floor(UV)) - ivec2(1);
		vec4 wx = weights(fract(UV.x));
		vec4 wy = weights(fract(UV.y));
		int width = textureSize(exposure_map, 0).x;
		for (int y = 0; y < 4; y++) {
			for (int x = 0; x < 4; x++) {
				trace += wx[x] * wy[y] * sample_trace(base + ivec2(x,y), width);
			}
		}
	}
	ALBEDO = COLOR.rgb;
	ROUGHNESS = 0.95;
	grid.x += mod(floor(grid.y), 2.0) * 0.5;
	vec2 cell = floor(grid);
	float grain = fract(sin(dot(cell, vec2(12.9898, 78.233))) * 4375.5453);
	vec2 center = vec2(0.5) + 0.18 * vec2(grain - 0.5, fract(grain * 13.7) - 0.5);
	float radius = 0.075 + 0.045 * grain;
	float aa = max(0.015, footprint * 0.6);
	float dot_mask = 1.0 - smoothstep(radius - aa, radius + aa, length(fract(grid) - center));
	// Keep average coverage when distant floor dots project below a pixel.
	dot_mask = mix(dot_mask, 3.14159 * radius * radius, smoothstep(0.35, 0.9, footprint));
	// Individual returns appear in sequence as local exposure builds up.
	float threshold = 0.015 + 0.38 * grain;
	vec2 returns = smoothstep(vec2(threshold), vec2(threshold + 0.12), trace) * trace;
	vec3 torch_color = vec3(0.42, 0.68, 0.74);
	vec3 dots = dot_mask * (torch_color * returns.y + vec3(0.45, 0.23, 0.095) * returns.x);
	vec3 remembered_match = COLOR.rgb * vec3(0.29, 0.16, 0.075) * trace.x;
	EMISSION = remembered_match + dots + COLOR.rgb * torch_color * trace.y * 0.045;
}
