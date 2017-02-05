#ifndef __Lambertian__
#define __Lambertian__

#include "brdf.h"

class Lambertian : public BRDF {
private:
	float kd;
	float3 color;
public:
	__device__
	void SetSampler(Sampler* ptr);
	__device__
	void Set_kd(float kd);
	__device__
	void Set_color(float3 color);
	__device__
	virtual float3 f(HitRec* hr, float3& wi, float3& wo);
	__device__
	virtual float3 sample_f(HitRec* hr, float3& wi, float3& wo);
	__device__
	virtual float3 rho(HitRec* hr, float3& wo);
	__device__
	virtual ~Lambertian();
};

#endif
