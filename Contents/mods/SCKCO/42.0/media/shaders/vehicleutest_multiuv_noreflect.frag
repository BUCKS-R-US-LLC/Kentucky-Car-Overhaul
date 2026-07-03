#version 120

varying vec3 vertColour; 
varying vec3 vertNormal;
varying vec2 texCoords;
varying vec2 texCoords1;

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

uniform mat4 TextureUninstall1;
uniform mat4 TextureUninstall2;
uniform mat4 TextureLightsEnables1;
uniform mat4 TextureLightsEnables2;
uniform mat4 TextureDamage1Enables1;
uniform mat4 TextureDamage1Enables2;
uniform mat4 TextureDamage2Enables1;
uniform mat4 TextureDamage2Enables2;
uniform mat4 MatBlood1Enables1;
uniform mat4 MatBlood1Enables2;
uniform mat4 MatBlood2Enables1;
uniform mat4 MatBlood2Enables2;

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

#include "util/math"
#include "util/dommat4"

const vec3 colZone1 = vec3(1.00, 0.00, 0.00); // Head
const vec3 colZone2 = vec3(0.00, 1.00, 0.00); // Tail
const vec3 colZone3 = vec3(0.00, 1.00, 1.00); // Door RH
const vec3 colZone4 = vec3(1.00, 1.00, 0.00); // Door RT
const vec3 colZone5 = vec3(1.00, 0.00, 1.00); // Door LH
const vec3 colZone6 = vec3(0.00, 0.00, 1.00); // Door LT
const vec3 colZone7 = vec3(0.00, 0.50, 0.50); // Window RH
const vec3 colZone8 = vec3(0.50, 0.50, 0.00); // Window RT
const vec3 colZone9 = vec3(0.50, 0.00, 0.50); // Window LH
const vec3 colZone10 = vec3(0.00, 0.00, 0.50); // Window LT
const vec3 colZone11 = vec3(0.50, 0.00, 0.00); // Window T
const vec3 colZone12 = vec3(0.00, 0.50, 0.00); // Window H
const vec3 colZone13 = vec3(0.75, 0.00, 0.75); // Guard RH
const vec3 colZone14 = vec3(0.00, 0.00, 0.75); // Guard RT
const vec3 colZone15 = vec3(0.00, 0.75, 0.75); // Guard LH
const vec3 colZone16 = vec3(0.75, 0.75, 0.00); // Guard LT
const vec3 colZone17 = vec3(0.00, 0.00, 0.00); // Roof
const vec3 colZone18 = vec3(0.25, 0.00, 0.00); // Lights R H
const vec3 colZone19 = vec3(0.75, 0.00, 0.00); // Lights L H
const vec3 colZone20 = vec3(0.00, 0.75, 0.00); // Lights R T
const vec3 colZone21 = vec3(0.00, 0.25, 0.00); // Lights L T
const vec3 colZone22 = vec3(0.50, 0.25, 0.00); // StopLights R
const vec3 colZone23 = vec3(0.50, 0.75, 0.00); // StopLights L
const vec3 colZone24 = vec3(0.75, 0.75, 0.75); // LightBar R
const vec3 colZone25 = vec3(0.25, 0.25, 0.25); // LightBar L
const vec3 colZone26 = vec3(1.00, 0.00, 0.50); // Hood
const vec3 colZone27 = vec3(0.00, 1.00, 0.50); // Boot

// Paint-tint a damage shell via luminance so the dent takes a single paint hue.
// Lighting-agnostic: global lighting is applied later in main().
vec3 addDamage(vec3 baseCol, vec4 shell, vec3 paintColor, vec3 lighting, vec3 tint, float enable)
{
	float lum = dot(shell.rgb, vec3(0.299, 0.587, 0.114));
	return mix(baseCol, lum * paintColor, shell.a * enable);
}

// Overlay blood, gated by zone intensity and a location alpha (window vs body).
// Lighting-agnostic to match addDamage and the global lighting pass.
vec3 addBlood(vec4 bloodTex, vec4 mask, float intensity, float alpha, vec3 lighting, vec3 tint, vec3 baseCol)
{
	float a = bloodTex.a * mask.a * clamp(intensity, 0.0, 1.0) * alpha;
	return mix(baseCol, bloodTex.rgb, a);
}

void main()
{
	vec3 normal = normalize(vertNormal);
	vec4 tex = texture2D(Texture0, texCoords);

	vec3 col = tex.xyz;
	float dotprod;

	vec4 texColorMask = texture2D(TextureMask, texCoords);
	vec4 texColorRust = texture2D(TextureRust, texCoords1);
	vec4 texColorLights = texture2D(TextureLights, texCoords);
	vec4 texColorDamage1Overlay = texture2D(TextureDamage1Overlay, texCoords1);
	vec4 texColorDamage1Shell = texture2D(TextureDamage1Shell, texCoords1);
	vec4 texColorDamage2Overlay = texture2D(TextureDamage2Overlay, texCoords1);
	vec4 texColorDamage2Shell = texture2D(TextureDamage2Shell, texCoords1);

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
	lighting.x = clamp(lighting.x, 0.0, 1.0);
	lighting.y = clamp(lighting.y, 0.0, 1.0);
	lighting.z = clamp(lighting.z, 0.0, 1.0);

	mat4 texen1 = mat4( 0.0 );
	texen1[0][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone1)));
	texen1[0][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone2)));
	texen1[0][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone3)));
	texen1[0][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone4)));
	texen1[1][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone5)));
	texen1[1][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone6)));
	texen1[1][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone7)));
	texen1[1][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone8)));
	texen1[2][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone9)));
	texen1[2][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone10)));
	texen1[2][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone11)));
	texen1[2][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone12)));
	texen1[3][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone13)));
	texen1[3][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone14)));
	texen1[3][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone15)));
	texen1[3][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone16)));

	mat4 texen2 = mat4( 0.0 );
	texen2[0][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone17)));
	texen2[0][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone18)));
	texen2[0][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone19)));
	texen2[0][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone20)));
	texen2[1][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone21)));
	texen2[1][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone22)));
	texen2[1][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone23)));
	texen2[1][3] = (1.0-step(0.01,length(texColorMask.xyz-colZone24)));
	texen2[2][0] = (1.0-step(0.01,length(texColorMask.xyz-colZone25)));
	texen2[2][1] = (1.0-step(0.01,length(texColorMask.xyz-colZone26)));
	texen2[2][2] = (1.0-step(0.01,length(texColorMask.xyz-colZone27)));

	float t1en = step(0.5, dommat4(texen1, TextureLightsEnables1) + dommat4(texen2, TextureLightsEnables2) );
	float t2en = step(0.5, dommat4(texen1, TextureDamage1Enables1) + dommat4(texen2, TextureDamage1Enables2) );
	float t3en = step(0.5, dommat4(texen1, TextureDamage2Enables1) + dommat4(texen2, TextureDamage2Enables2) );
	float t4en = step(0.5, dommat4(texen1, TextureUninstall1) + dommat4(texen2, TextureUninstall2) );

	float windowAlpha = clamp(texen1[1][2] + texen1[1][3] + texen1[2][0] + texen1[2][1] + texen1[2][2] + texen1[2][3], 0.0, 1.0);
	float frontAlpha = clamp(texen1[0][0] + texen2[0][1] + texen2[0][2], 0.0, 1.0);
	float tailAlpha = clamp(texen1[0][1] + texen2[0][3] + texen2[1][0] + texen2[1][1] + texen2[1][2], 0.0, 1.0);
	float noTintAlpha = clamp(windowAlpha + frontAlpha + tailAlpha, 0.0, 1.0);

	col = mix(col, texColorRust.xyz, texColorRust.a*TextureRustA);

	// NOTE: reference passes HSV here; swap to TexturePainColor.xyz for a true RGB paint tint.
	vec3 paintColor = rgb2hsv(tex.rgb).xyz;

	vec4 texColorBlood2 = texture2D(TextureDamage2Overlay, texCoords1);
	vec4 colmask = texture2D(TextureDamage1Overlay, texCoords1);
	float intensity = dommat4(texen1, MatBlood1Enables1) + dommat4(texen2, MatBlood1Enables2);
	float maskAlpha = step(0.5, dommat4(texen1, MatBlood2Enables1) + dommat4(texen2, MatBlood2Enables2));
	// Blood below damage on windows, ignore vehicle body.
	col = addBlood(texColorBlood2, colmask, intensity, maskAlpha * windowAlpha, lighting, TintColourNew, col);

	col = addDamage(col, texColorDamage1Shell, paintColor, lighting, TintColourNew, t2en*(1.0-noTintAlpha));
	col = mix(col, texColorDamage1Shell.xyz, texColorDamage1Shell.a*t2en*noTintAlpha);

	col = addDamage(col, texColorDamage2Shell, paintColor, lighting, TintColourNew, t3en*(1.0-noTintAlpha));
	col = mix(col, texColorDamage2Shell.xyz, texColorDamage2Shell.a*t3en*noTintAlpha);

	// Blood above damage on vehicle body, ignore windows.
	col = addBlood(texColorBlood2, colmask, intensity, maskAlpha * (1.0 - windowAlpha), lighting, TintColourNew, col);

	col = mix(col, vec3(0.2), t4en);

	col *= lighting * TintColourNew;

	// After ambient lighting so active headlights and taillights aren't dimmed.
	col = mix(col, texColorLights.xyz, texColorLights.a*t1en);

	gl_FragColor = vec4(col, TexturePainColor.a);
}
