//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 new_color;
uniform float blend_per;

void main()
{
	vec4 pix_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//if (vec3(pix_color.rgb) <= vec3(0.2)) {
	if (pix_color.r <= 0.01) if (pix_color.g <= 0.01) if (pix_color.b <= 0.01) {
		
		//pix_color = vec4(vec3((pix_color.rgb + (new_color.rgb * blend_per))), pix_color.a);
		pix_color = vec4(new_color.rgb * blend_per, pix_color.a);
		
	};
	if (pix_color.r >= 0.99) if (pix_color.g >= 0.99) if (pix_color.b >- 0.99) {
		
		//pix_color = mix(pix_color, new_color, blend_per)
		pix_color = vec4(vec3(1) - (new_color.rgb * blend_per), pix_color.a);
		//pix_color = vec4( lerp(vec3(1), new_color.rgb, blend_per), pix_color.a );
		
	};
	
    gl_FragColor = pix_color;//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
