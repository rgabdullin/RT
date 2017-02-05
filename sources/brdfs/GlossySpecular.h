#ifndef __GlossySpecular__
#define __GlossySpecular__

#include "brdf.h"

class GlossySpecular : public BRDF {
private:
	float ks;
	float exp;
	float3 color;
public:
	__device__
	void SetSampler(Sampler* ptr);
	__device__
	void Set_ks(float ks);
	__device__
	void Set_exp(float exp);
	__device__
	void Set_color(float3 color);
	__device__
	virtual float3 f(HitRec* hr, float3& wi, float3& wo);
	__device__
	virtual float3 sample_f(HitRec* hr, float3& wi, float3& wo);
	__device__
	virtual float3 rho(HitRec* hr, float3& wo);
	__device__
	virtual ~GlossySpecular();
};

#endif
