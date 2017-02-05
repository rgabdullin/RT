#include "Sphere.h"
#include "../Utils/cuda_math.h"
#include "../Utils/cuda_double_math.h"
#include "../Materials.h"

/* Sphere */
__device__
Sphere::Sphere() :
	origin(make_float3(0, 0, 0)),
	radius(1)
{}

__device__
void Sphere::init(float3 l_origin, float l_radius, Material* material_ptr) {
	origin = l_origin;
	radius = l_radius;
	SetMaterial(material_ptr);
}

__device__
bool Sphere::Intersection(const Ray& ray, HitRec& hr) {
	double3 dir = make_double3(ray.direction);
	double3 ro = make_double3(ray.origin);
	double3 o = make_double3(origin);
	double r = radius;
	double A = dot(dir, dir);
	double B = 2.0f * dot(ro - o, dir);
	double C = dot(ro - o, ro - o) - r * r;

	double D = B * B - 4 * A * C;
	if (D >= 0) {
		double t1 = (-B - sqrt(D)) / A * 0.5;
		double t2 = (-B + sqrt(D)) / A * 0.5;
		double t = -1;
		if (t1 > eps)
			t = t1;
		else
			if (t2 > eps)
				t = t2;
		if (t > eps && (!hr.isHit || t < hr.tmin)) {
			hr.isHit = true;
			hr.tmin = t;

			hr.hit_point = ray.origin + ray.direction * t;
			hr.hit_normal = normalize(hr.hit_point - origin);
			hr.ray = ray;
			hr.material_ptr = material_ptr;

			return true;
		}
	}
	return false;
}

__device__
Sphere::~Sphere() {}
