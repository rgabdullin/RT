#include "AmbientLight.h"
#include "../Utils/cuda_math.h"

/* AmbientLight */
__device__
AmbientLight::AmbientLight(float l_ls, float3 l_color) : ls(l_ls), color(l_color) {}
__device__
float3 AmbientLight::GetDirection(HitRec* hr) {
	return make_float3(0.0f, 0.0f, 0.0f);
}
__device__
float3 AmbientLight::L(HitRec* hr) {
	return color * ls;
}
__device__
AmbientLight::~AmbientLight() {}
