#version 330

out vec3 vertColour;
out vec3 vertNormal;
out vec2 texCoords;
//out vec2 refTexCoord;
out vec4 positionEye;

layout (location = 0) in vec4 vertex;
layout (location = 1) in vec4 normal;
layout (location = 2) in vec4 boneWeights;
layout (location = 3) in vec4 boneIndices;
layout (location = 4) in vec2 uv;

uniform mat4 ModelViewProjection;
uniform mat4 MatrixPalette[60];
uniform float targetDepth = 0.5;

vec2 SphereMap(in vec3 normal, in vec3 ecPosition3)
{
   float  m;
   vec3   r,u;

   u = normalize(ecPosition3);
   r = reflect(u, normal);
   m = 2.0 * sqrt(r.x * r.x + r.y * r.y + (r.z + 1.0) * (r.z + 1.0));

   return vec2 (r.x / m + 0.5, r.y / m + 0.5);
}

void main()
{
	vec4 position = vec4(vertex.xyz, 1.0);
	vec4 normal = vec4(normal.xyz, 0.0);

	texCoords = uv.st;

	mat4 boneEffect = mat4(0.0);
	if(boneWeights.x > 0.0)
		boneEffect += MatrixPalette[int(boneIndices.x)] * boneWeights.x;
	if(boneWeights.y > 0.0)
		boneEffect += MatrixPalette[int(boneIndices.y)] * boneWeights.y;
	if(boneWeights.z > 0.0)
		boneEffect += MatrixPalette[int(boneIndices.z)] * boneWeights.z;
	if(boneWeights.w > 0.0)
		boneEffect += MatrixPalette[int(boneIndices.w)] * boneWeights.w;

	normal = boneEffect * normal;
	vertNormal = normal.xyz;
	vertColour = vec3(1.0,1.0,1.0);
	positionEye = (ModelViewProjection * boneEffect * position) - vec4(-0.2, 0.2, 0.2, 0);

	vec4 o = ModelViewProjection * boneEffect * position;
	float clip = ((o.z+1.0) / 2.0); // -1,+1 -> 0,2 -> 0,1
	clip += targetDepth - 0.5;
	o.z = (clip*2)-1; // 0-1 -> 0-2 -> -1,+1
	gl_Position = o;

//	vec3 posEyeRaw = vec3(0.5, 0.5, 0) - position.xyz;
//	vec4 PositionEye = ModelViewProjection * vec4(posEyeRaw, 1.0);
//	refTexCoord = SphereMap( normalize(normal.xyz), PositionEye.xyz );
}
