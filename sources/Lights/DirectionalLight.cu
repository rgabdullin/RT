#include "DirectionalLight.h"
#include "../Utils/cuda_math.h"

/* DirectionLight */
__device__
DirectionalLight::DirectionalLight(float3 l_direction, float l_ls, float3 l_color) : ls(l_ls), color(l_color), direction(-1.0f * normalize(l_direction)) {}
__device__
float3 DirectionalLight::GetDirection(HitRec* hr) {
	return direction;
}
__device__
float3 DirectionalLight::L(HitRec* hr) {
	return color * ls;
}
__device__
DirectionalLight::~DirectionalLight() {}
