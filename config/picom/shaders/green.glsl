#version 140

uniform bool invert_color;

uniform float opacity;
uniform float time;

uniform sampler2D tex;

// bool is_night_time() {
//     float timeEpoch = time;
//     float hour = mod(timeEpoch, 24.0);
//
//     return is_between_time_inclusive(6.0, 18.0);
// }


void main() {
	vec4 c = texture(tex, gl_TexCoord[0].xy);

	// if (is_night_time())
		c = vec4(c.r, c.g, c.b * 0.4, c.a);

	if (invert_color)
		c = vec4(vec3(c.a, c.a, c.a) - vec3(c), c.a);

	c *= opacity;
	gl_FragColor = c;
}

