//
// Invert color shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 OC = texture2D(gm_BaseTexture, v_vTexcoord);
	
	float red = 1.0 - OC.r;
	float green = 1.0 - OC.g;
	float blue = 1.0 - OC.b;
	float alpha = OC.a;
	
	vec4 Color = vec4(red,blue,green,alpha);
	
	gl_FragColor = Color;
}