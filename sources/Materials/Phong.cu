#include "../Utils/HitRec.h"
#include "../Utils/World.h"
#include "Phong.h"
#include "Material.h"

/* Phong */
__device__
Phong::Phong():
	ambient_brdf(new Lambertian()),
	diffuse_brdf(new Lambertian()),
	specular_brdf(new GlossySpecular())
{}
__device__
Phong::Phong(Sampler* sampler_ptr, float ka, float kd, float ks, float exp, float3 color) :
	ambient_brdf(new Lambertian()),
	diffuse_brdf(new Lambertian()),
	specular_brdf(new GlossySpecular())
{
	init(sampler_ptr, ka, kd, ks, exp, color);
}
__device__
void Phong::init(Sampler* sampler_ptr, float ka, float kd, float ks, float exp, float3 color){
	ambient_brdf->SetSampler(sampler_ptr);
	ambient_brdf->Set_kd(ka);
	ambient_brdf->Set_color(color);

	diffuse_brdf->SetSampler(sampler_ptr);
	diffuse_brdf->Set_kd(kd);
	diffuse_brdf->Set_color(color);

	specular_brdf->SetSampler(sampler_ptr);
	specular_brdf->Set_ks(ks);
	specular_brdf->Set_exp(exp);
	specular_brdf->Set_color(color);
}
__device__
float3 Phong::shade(HitRec* hr) {
	float3 wo = -1.0f * hr->ray.direction;
	float3 L = ambient_brdf->rho(hr, wo) * hr->wr->ambient_ptr->L(hr);

	int num_of_lights = hr->wr->num_of_lights;

	Ray ray = hr->ray;
	HitRec sr;
	for (int i = 0; i < num_of_lights; ++i) {
		make_HitRec(&sr, hr->wr, &ray);
		sr.ray.direction = normalize(hr->wr->scene_lights[i]->GetDirection(hr));
		sr.ray.origin = hr->hit_point;
		hr->wr->isHitSceneObject(&sr.ray, &sr);
		if (sr.isHit == false) {
			float3 wi = sr.ray.direction;
			float ndotwi = dot(hr->hit_normal, wi);
			if (ndotwi < 0)
				ndotwi = dot(-hr->hit_normal, wi);
			L += (diffuse_brdf->f(hr, wo, wi) + specular_brdf->f(hr, wo, wi)) * hr->wr->scene_lights[i]->L(hr) * ndotwi;
		}
	}
	return L;
}

__device__
Phong::~Phong() {
	if (ambient_brdf != NULL)
		delete ambient_brdf;
	if (diffuse_brdf != NULL)
		delete diffuse_brdf;
	if (specular_brdf != NULL)
		delete specular_brdf;
}
