#ifndef __Matte__
#define __Matte__

#include "Material.h"

class Matte : public Material {
	Lambertian * ambient_brdf;
	Lambertian * diffuse_brdf;
public:
	__device__
	Matte();
	__device__
	Matte(Sampler* sampler_ptr, float ka, float kd, float3 color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	void init(Sampler* sampler_ptr, float ka, float kd, float3 color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	virtual float3 shade(HitRec* hr);
	__device__
	virtual ~Matte();
};

#endif
