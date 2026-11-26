shader_type spatial;

uniform bool manor = false;
varying vec3 local_position;
varying vec2 surface_position;

void vertex() {
	local_position = VERTEX;
	surface_position = abs(NORMAL.y) > 0.5 ? VERTEX.xz :
			(abs(NORMAL.x) > 0.5 ? VERTEX.zy : VERTEX.xy);
}

void fragment() {
	ALBEDO = COLOR.rgb;
	if (manor) {
		vec2 q = surface_position;
		float grain = sin(q.x * 44.0 + 1.8 * sin(q.y * 2.4)) * 0.035;
		if (abs(local_position.y) < 0.01) {
			vec2 tile = floor(q * 1.3);
			float checker = mod(tile.x + tile.y, 2.0);
			ALBEDO = mix(vec3(0.16,0.10,0.066), vec3(0.43,0.32,0.21), checker);
			ALBEDO += 0.025 * sin(q.x * 12.0 + 3.0 * sin(q.y * 5.0));
		} else if (local_position.y < 1.35 || abs(local_position.y - 6.0) < 0.03) {
			ALBEDO = vec3(0.24,0.12,0.065) * (1.0 + grain * 4.0);
		} else {
			float motif = pow(abs(cos(q.x * 9.0) * cos(q.y * 8.0 + 1.3 * sin(q.x * 9.0))), 5.0);
			ALBEDO = mix(vec3(0.43,0.30,0.17), vec3(0.29,0.18,0.11), motif);
		}
	}
	ROUGHNESS = 0.95;
}
