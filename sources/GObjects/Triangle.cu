#include "Triangle.h"
#include "../Utils/cuda_math.h"
#include "../Utils/cuda_double_math.h"
#include "../Materials.h"

/* Triangle */

__device__
Triangle::Triangle() {}

__device__
void Triangle::init(float3 p1, float3 p2, float3 p3, Material* material_ptr) {
	points[0] = p1;
	points[1] = p2;
	points[2] = p3;
	normal = normalize(cross(p1 - p2, p3 - p2));
	SetMaterial(material_ptr);
}

__device__
bool Triangle::Intersection(const Ray& ray, HitRec& hr) {
	__shared__ double3 p0; if (threadIdx.x == 0) p0 = make_double3(points[0]);
	__shared__ double3 p1; if (threadIdx.x == 0) p1 = make_double3(points[1]);
	__shared__ double3 p2; if (threadIdx.x == 0) p2 = make_double3(points[2]);
	__shared__ double3 n; if (threadIdx.x == 0)  n = make_double3(normal);
	__syncthreads();
	double3 ro = make_double3(ray.origin);
	double3 dir = make_double3(ray.direction);
	double t = dot(p1 - ro, n) / dot(dir, n);
	double3 hp = ro + t * dir;

	if (t > eps && (dot(cross(p1 - p0, hp - p0), cross(p2 - p1, hp - p1)) >= 0
		&& dot(cross(p2 - p1, hp - p1), cross(p0 - p2, hp - p2)) >= 0)
		&& (t < hr.tmin || !hr.isHit)) {
		hr.isHit = true;
		hr.tmin = t;

		hr.hit_point = make_float3(hp);
		hr.hit_normal = normalize(normal);
		hr.ray = ray;
		hr.material_ptr = material_ptr;

		return true;
	}
	return false;
}

__device__
Triangle::~Triangle() {}
