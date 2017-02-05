#include "PointLight.h"
#include "../Utils/cuda_math.h"

/* PointLight */
__device__
PointLight::PointLight(float3 l_location, float l_ls, float3 l_color) : ls(l_ls), color(l_color), location(l_location) {}
__device__
float3 PointLight::GetDirection(HitRec* hr) {
	return normalize(location - hr->hit_point);
}
__device__
float3 PointLight::L(HitRec* hr) {
	return color * ls;
}
__device__
PointLight::~PointLight() {}
