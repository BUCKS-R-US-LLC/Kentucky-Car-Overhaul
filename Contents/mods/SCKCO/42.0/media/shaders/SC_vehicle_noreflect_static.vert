#version 330

out vec3 vertColour;
out vec3 vertNormal;
out vec2 texCoords;
out vec2 texCoords1;

uniform mat4 ModelViewProjection;
uniform mat4 transform;
uniform float targetDepth = 0.5;

layout (location = 0) in vec4 vertex;
layout (location = 1) in vec4 normal;
layout (location = 2) in vec2 uv;
layout (location = 3) in vec2 uv2;

void main()
{
	vec4 position = vec4(vertex.xyz, 1);
	vec4 normal = vec4(normal.xyz, 0);

	texCoords = uv.st;
#ifdef MULTI_UV
	texCoords1 = uv2.st;
#else
	texCoords1 = uv.st;
#endif

	vertNormal = (transform * normal).xyz;
	vertColour = vec3(1,1,1);

	vec4 o = ModelViewProjection * transform * position;
	float clip = ((o.z+1.0) / 2.0); // -1,+1 -> 0,2 -> 0,1
	clip += targetDepth - 0.5;
	o.z = (clip*2)-1; // 0-1 -> 0-2 -> -1,+1
	gl_Position = o;
}
