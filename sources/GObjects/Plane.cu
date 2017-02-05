#include "Plane.h"
#include "../Utils/cuda_math.h"
#include "../Utils/cuda_double_math.h"
#include "../Materials.h"

/* Plane */

__device__
Plane::Plane() {}

__device__
void Plane::init(float3 p, float3 n, Material* material_ptr) {
	point = p;
	normal = normalize(n);
	SetMaterial(material_ptr);
}

__device__
bool Plane::Intersection(const Ray& ray, HitRec& hr) {
	__shared__ double3 p; if (threadIdx.x == 0) p = make_double3(point);
	__shared__ double3 n; if (threadIdx.x == 0) n = make_double3(normal);
	__syncthreads();
	double3 ro = make_double3(ray.origin);
	double3 dir = make_double3(ray.direction);
	double t = dot(p - ro, n) / dot(dir, n);
	if (t > eps && (t < hr.tmin || !hr.isHit)) {
		hr.isHit = true;
		hr.tmin = t;

		hr.hit_point = ray.origin + t * ray.direction;
		hr.hit_normal = normal;
		hr.ray = ray;
		hr.material_ptr = material_ptr;

		return true;
	}
	return false;
}
__device__
Plane::~Plane() {}
