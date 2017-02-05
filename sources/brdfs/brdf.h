#ifndef __brdf__
#define __brdf__

#include "cuda_runtime.h"

class Sampler;
struct HitRec;

class BRDF {
protected:
	Sampler * sampler_ptr;
public:
	__device__
	virtual float3 f(HitRec* hr, float3& wi, float3& wo) = 0;
	__device__
	virtual float3 sample_f(HitRec* hr, float3& wi, float3& wo) = 0;
	__device__
	virtual float3 rho(HitRec* hr, float3& wo) = 0;
	__device__
	virtual ~BRDF();
};

#endif
