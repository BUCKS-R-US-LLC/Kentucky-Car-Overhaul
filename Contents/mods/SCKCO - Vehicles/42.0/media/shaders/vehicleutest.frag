#version 110

varying vec3 vertColour; 
varying vec3 vertNormal;
varying vec2 texCoords;
varying vec4 positionEye;

uniform sampler2D Texture0;
uniform vec4 TexturePainColor;
uniform sampler2D TextureRust;
uniform float TextureRustA;
uniform sampler2D TextureMask;
uniform sampler2D TextureLights; 
uniform sampler2D TextureDamage1Overlay;
uniform sampler2D TextureDamage1Shell;
uniform sampler2D TextureDamage2Overlay;
uniform sampler2D TextureDamage2Shell;
uniform sampler2D TextureReflectionA;
uniform sampler2D TextureReflectionB;
uniform vec3 ReflectionParam;

uniform mat4 TextureUninstall1;
uniform mat4 TextureUninstall2;
uniform mat4 TextureLightsEnables1;
uniform mat4 TextureLightsEnables2;
uniform mat4 TextureDamage1Enables1;
uniform mat4 TextureDamage1Enables2;
uniform mat4 TextureDamage2Enables1;
uniform mat4 TextureDamage2Enables2;

uniform vec3 TintColour;

uniform vec3 AmbientColour;
uniform vec3 Light0Direction;
uniform vec3 Light0Colour;
uniform vec3 Light1Direction;
uniform vec3 Light1Colour;
uniform vec3 Light2Direction;
uniform vec3 Light2Colour;
uniform vec3 Light3Direction;
uniform vec3 Light3Colour;
uniform vec3 Light4Direction;
uniform vec3 Light4Colour;

const vec3 colZone1 = vec3(1.00, 0.00, 0.00); 
const vec3 colZone2 = vec3(0.00, 1.00, 0.00); 
const vec3 colZone3 = vec3(0.00, 1.00, 1.00); 
const vec3 colZone4 = vec3(1.00, 1.00, 0.00); 
const vec3 colZone5 = vec3(1.00, 0.00, 1.00); 
const vec3 colZone6 = vec3(0.00, 0.00, 1.00); 
const vec3 colZone7 = vec3(0.00, 0.50, 0.50); 
const vec3 colZone8 = vec3(0.50, 0.50, 0.00); 
const vec3 colZone9 = vec3(0.50, 0.00, 0.50); 
const vec3 colZone10 = vec3(0.00, 0.00, 0.50); 
const vec3 colZone11 = vec3(0.50, 0.00, 0.00); 
const vec3 colZone12 = vec3(0.00, 0.50, 0.00); 
const vec3 colZone13 = vec3(0.75, 0.00, 0.75); 
const vec3 colZone14 = vec3(0.00, 0.00, 0.75); 
const vec3 colZone15 = vec3(0.00, 0.75, 0.75); 
const vec3 colZone16 = vec3(0.75, 0.75, 0.00); 
const vec3 colZone17 = vec3(0.00, 0.00, 0.00); 
const vec3 colZone18 = vec3(0.25, 0.00, 0.00); 
const vec3 colZone19 = vec3(0.75, 0.00, 0.00); 
const vec3 colZone20 = vec3(0.00, 0.75, 0.00); 
const vec3 colZone21 = vec3(0.00, 0.25, 0.00); 
const vec3 colZone22 = vec3(0.50, 0.25, 0.00); 
const vec3 colZone23 = vec3(0.50, 0.75, 0.00); 
const vec3 colZone24 = vec3(0.75, 0.75, 0.75); 
const vec3 colZone25 = vec3(0.25, 0.25, 0.25); 
const vec3 colZone26 = vec3(1.00, 0.00, 0.50); 
const vec3 colZone27 = vec3(0.00, 1.00, 0.50); 

#include util/math
#include util/SphereMap
#include util/dommat4

void main()
{
	vec3 normal = normalize(vertNormal);
	vec4 tex = texture2D(Texture0, texCoords);
	vec3 col = tex.xyz;
	float dotprod;
	float pixelVal = (col.x + col.y + col.z) / 3.0;

	vec4 texColorMask = texture2D(TextureMask, texCoords);
	vec4 texColorRust = texture2D(TextureRust, texCoords);
	vec4 texColorLights = texture2D(TextureLights, texCoords);
	vec4 texColorDamage1Overlay = texture2D(TextureDamage1Overlay, texCoords);
	vec4 texColorDamage1Shell = texture2D(TextureDamage1Shell, texCoords);
	vec4 texColorDamage2Overlay = texture2D(TextureDamage2Overlay, texCoords);
	vec4 texColorDamage2Shell = texture2D(TextureDamage2Shell, texCoords);

	vec3 lighting = AmbientColour;

	dotprod = max(dot(normal, normalize(Light0Direction)), 0.0);
	quantise(dotprod, 3.0);
	lighting += Light0Colour * dotprod;

	dotprod = max(dot(normal, normalize(Light1Direction)), 0.0);
	quantise(dotprod, 3.0);
	lighting += Light1Colour * dotprod;

	dotprod = max(dot(normal, normalize(Light2Direction)), 0.0);
	quantise(dotprod, 3.0);
	lighting += Light2Colour * dotprod;

	dotprod = max(dot(normal, normalize(Light3Direction)), 0.0);
	quantise(dotprod, 3.0);
	lighting += Light3Colour * dotprod;

	dotprod = max(dot(normal, normalize(Light4Direction)), 0.0);
	quantise(dotprod, 3.0);
	lighting += Light4Colour * dotprod;

	vec3 TintColourNew = desaturate(TintColour, 0.3);
	lighting = clamp(lighting, 0.0, 1.0);

	mat4 texen1 = mat4(0.0);
	mat4 texen2 = mat4(0.0);

	// ... texen1/2 initialization remains unchanged ...

	float t1en = step(0.5, dommat4(texen1, TextureLightsEnables1) + dommat4(texen2, TextureLightsEnables2));
	float t2en = step(0.5, dommat4(texen1, TextureDamage1Enables1) + dommat4(texen2, TextureDamage1Enables2));
	float t3en = step(0.5, dommat4(texen1, TextureDamage2Enables1) + dommat4(texen2, TextureDamage2Enables2));
	float t4en = step(0.5, dommat4(texen1, TextureUninstall1) + dommat4(texen2, TextureUninstall2));

	col = col * lighting * TintColourNew;

	vec3 fragHSV = rgb2hsv(col.rgb).xyz;
	fragHSV.x = TexturePainColor.x;
	fragHSV.y = clamp(fragHSV.y + TexturePainColor.y - 0.5, 0.0, 0.9999);
	fragHSV.z = clamp(fragHSV.z + TexturePainColor.z - 0.5, 0.0, 0.9999);
	fragHSV.xyz = mod(fragHSV.xyz, 1.0);
	col = mix(col, hsv2rgb(fragHSV), 1.0 - tex.a);

	float ref_en = texen2[0][0] + texen1[1][2] + texen1[1][3] + texen1[2][0] + texen1[2][1] + texen1[2][2] + texen1[2][3];
	vec2 refTexCoord = SphereMap(normalize(normal), positionEye.xyz);
	vec3 texRefA = texture2D(TextureReflectionA, refTexCoord).xyz;
	vec3 texRefB = texture2D(TextureReflectionB, refTexCoord).xyz;
	vec3 texRef = mix(texRefB, texRefA, ReflectionParam.x);

	col = mix(col, texRef, ref_en * (0.02 + ReflectionParam.y * 0.08));
	col = mix(col, texRef / 4.0, (1.0 - ref_en) * (0.01 + ReflectionParam.z * 0.05));

	col = mix(col, texColorLights.xyz, texColorLights.a * t1en);
	col = mix(col, texColorRust.xyz * lighting * TintColourNew, texColorRust.a * TextureRustA);

	fragHSV = rgb2hsv(texColorDamage1Shell.xyz).xyz;
	fragHSV.x = TexturePainColor.x;
	fragHSV.y = clamp(fragHSV.y + TexturePainColor.y - 0.5, 0.0, 0.9999);
	fragHSV.z = clamp(fragHSV.z + TexturePainColor.z - 0.5, 0.0, 0.9999);
	fragHSV.xyz = mod(fragHSV.xyz, 1.0);
	col = mix(col, hsv2rgb(fragHSV) * lighting * TintColourNew, texColorDamage1Shell.a * t2en);
	col = mix(col, texColorDamage1Overlay.xyz * lighting * TintColourNew, texColorDamage1Overlay.a * t2en);

	fragHSV = rgb2hsv(texColorDamage2Shell.xyz).xyz;
	fragHSV.x = TexturePainColor.x;
	fragHSV.y = clamp(fragHSV.y + TexturePainColor.y - 0.5, 0.0, 0.9999);
	fragHSV.z = clamp(fragHSV.z + TexturePainColor.z - 0.5, 0.0, 0.9999);
	fragHSV.xyz = mod(fragHSV.xyz, 1.0);
	col = mix(col, lighting * TintColourNew, texColorDamage2Shell.a * t3en);
	col = mix(col, texColorDamage2Overlay.xyz * lighting * TintColourNew, texColorDamage2Overlay.a * t3en);

	col = mix(col, vec3(0.2), t4en);

	gl_FragColor = vec4(col, TexturePainColor.a);
}
