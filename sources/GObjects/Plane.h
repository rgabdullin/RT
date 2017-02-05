#ifndef __Plane__
#define __Plane__

#include "GObject.h"

class Plane : public GObject
{
	float3 point;
	float3 normal;
public:
	__device__
	Plane();
	__device__
	void init(float3 p, float3 n, Material* material_ptr);
	__device__
	virtual bool Intersection(const Ray& ray, HitRec& hr);
	__device__
	virtual ~Plane();
};

#endif
