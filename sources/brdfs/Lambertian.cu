#include "Lambertian.h"
#include "../Samplers.h"
#include "../Utils/HitRec.h"

/* Lambertian */

__device__
void Lambertian::SetSampler(Sampler* ptr) {
	sampler_ptr = ptr;
}
__device__
void Lambertian::Set_kd(float l_kd){
	kd = l_kd;
}
__device__
void Lambertian::Set_color(float3 l_color) {
	color = l_color;
}

__device__
float3 Lambertian::f(HitRec* hr, float3& wi, float3& wo) {
	return kd * color / M_PI;
}

__device__
float3 Lambertian::sample_f(HitRec * hr, float3 & wi, float3 & wo) {
	return make_float3(0.0f,0.0f,0.0f);
}

__device__
float3 Lambertian::rho(HitRec* hr, float3& wo) {
	return kd * color;
}

__device__
Lambertian::~Lambertian() {}
