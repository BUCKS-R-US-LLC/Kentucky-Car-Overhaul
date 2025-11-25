#version 330

out vec3 vertColour;
out vec3 vertNormal;
out vec2 texCoords;
out vec4 positionEye;

layout (location = 0) in vec4 vertex;
layout (location = 1) in vec4 normal;
layout (location = 2) in vec2 uv;
layout (location = 3) in vec2 uv2;

uniform mat4 ModelViewProjection;
uniform mat4 transform;
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
	vec4 position = vec4(vertex.xyz, 1);
	vec4 normal = vec4(normal.xyz, 0);

	texCoords = uv.st;

	vertNormal = (transform * normal).xyz;
	vertColour = vec3(1,1,1);

	vec4 o = ModelViewProjection * transform * position;
	float clip = ((o.z+1.0) / 2.0); // -1,+1 -> 0,2 -> 0,1
	clip += targetDepth - 0.5;
	o.z = (clip*2)-1; // 0-1 -> 0-2 -> -1,+1
	gl_Position = o;

    positionEye = (ModelViewProjection * transform * position) - vec4(-0.2, 0.2, 0.2, 0);
}
