const float FlowSpeed = 0.5;

uniform float timer;

vec4 Process(vec4 color)
{
	vec2 texCoord = gl_TexCoord[0].st;
	vec2 offset = vec2(0,0);
	
	offset.y = offset.y + timer * FlowSpeed;
	texCoord += offset;
	
	return getTexel(texCoord) * color;
}