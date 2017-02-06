#include "Plate.h"
#include "../Utils/cuda_math.h"
#include "../Utils/cuda_double_math.h"
#include "../Materials.h"

/* Plate */

__device__
Plate::Plate() {}

__device__
void Plate::init(float3 p, float3 u, float3 r, float2 l_size, Material* material_ptr) {
	center = p;
	up = normalize(u);
	right = normalize(r);
	size = l_size;
	SetMaterial(material_ptr);
}

__device__
bool Plate::Intersection(const Ray& ray, HitRec& hr) {
	__shared__ double3 p; if (threadIdx.x == 0) p = make_double3(center);
	__shared__ double3 n; if (threadIdx.x == 0) n = make_double3(cross(right, up));
	__syncthreads();
	double3 ro = make_double3(ray.origin);
	double3 dir = make_double3(ray.direction);
	double t = dot(p - ro, n) / dot(dir, n);
	if (t > eps) {
		double3 vec = ro + t * dir - (make_double3(center) - size.y * 0.5 * make_double3(up) - size.x * 0.5 * make_double3(right));
		double pr_up = dot(make_double3(up), vec);
		double pr_right = dot(make_double3(right), vec);
		if(pr_up >= 0.0f && pr_right >= 0.0f && pr_up <= size.y && pr_right <= size.x) {
			if(t < hr.tmin || !hr.isHit) {
				hr.isHit = true;
				hr.tmin = t;

				hr.hit_point = ray.origin + t * ray.direction;
				hr.hit_normal = normalize(cross(right, up));
				hr.ray = ray;
				hr.material_ptr = material_ptr;

				return true;
			}
		}
	}
	return false;
}
__device__
Plate::~Plate() {}
