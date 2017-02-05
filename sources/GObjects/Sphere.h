#ifndef __Sphere__
#define __Sphere__

#include "GObject.h"

class Sphere : public GObject
{
	float3 origin;
	float radius;
public:
	__device__
	Sphere();
	__device__
	void init(float3 origin, float radius, Material* material_ptr);
	__device__
	virtual bool Intersection(const Ray& ray, HitRec& hr);
	__device__
	virtual ~Sphere();
};

#endif
