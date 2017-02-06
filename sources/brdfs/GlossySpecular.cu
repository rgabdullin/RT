#include "GlossySpecular.h"
#include "../Samplers.h"
#include "../Utils/HitRec.h"
#include "../Utils/cuda_double_math.h"

/* GlossySpecular */

__device__
void GlossySpecular::SetSampler(Sampler* ptr) {
	sampler_ptr = ptr;
}
__device__
void GlossySpecular::Set_ks(float l_ks){
	ks = l_ks;
}
__device__
void GlossySpecular::Set_exp(float l_exp){
	exp = l_exp;
}
__device__
void GlossySpecular::Set_color(float3 l_color) {
	color = l_color;
}

__device__
float3 GlossySpecular::f(HitRec* hr, float3& wi, float3& wo) {
	float3 col = make_float3(0.0f,0.0f,0.0f);
	float ndotwi = dot(hr->hit_normal, wi);
	float3 r = -1.0f * wi + 2.0f * hr->hit_normal * ndotwi;
	float rdotwo = dot(r, wo);

	if(rdotwo > 0.0f)
		col = color * pow(rdotwo, exp);
	return col;
}

__device__
float3 GlossySpecular::sample_f(HitRec * hr, float3 & wi, float3 & wo) {
	return make_float3(0.0f,0.0f,0.0f);
}

__device__
float3 GlossySpecular::rho(HitRec* hr, float3& wo) {
	return make_float3(0.0f,0.0f,0.0f);
}

__device__
GlossySpecular::~GlossySpecular() {}


