//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 new_color;
uniform float blend_per;



void main() {
	vec4 pix_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//check black
	if (pix_color.r <= 0.01) {
		if (pix_color.g <= 0.01) {
			if (pix_color.b <= 0.01) {
				pix_color = vec4(new_color.rgb * blend_per, pix_color.a);
			};
		};
	};
	
	//check white
	if (pix_color.r >= 0.99) {
		if (pix_color.g >= 0.99) {
			if (pix_color.b >= 0.99) {
				pix_color = vec4(vec3(1) - (new_color.rgb * blend_per), pix_color.a);
			};
		};
	};
	
    gl_FragColor = pix_color;
}
