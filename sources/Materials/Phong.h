#ifndef __Phong__
#define __Phong__

#include "Material.h"

class Phong : public Material {
	Lambertian * ambient_brdf;
	Lambertian * diffuse_brdf;
	GlossySpecular * specular_brdf;
public:
	__device__
	Phong();
	__device__
	Phong(Sampler* sampler_ptr, float ka, float kd, float ks, float exp = 1.0f, float3 color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	void init(Sampler* sampler_ptr, float ka, float kd, float ks, float exp = 1.0f, float3 color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	virtual float3 shade(HitRec* hr);
	__device__
	virtual ~Phong();
};

#endif
