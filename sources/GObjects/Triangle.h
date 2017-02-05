#ifndef __Triangle__
#define __Triangle__

#include "GObject.h"

class Triangle : public GObject
{
	float3 points[3];
	float3 normal;
	float3 color;
public:
	__device__
	Triangle();
	__device__
	void init(float3 p1, float3 p2, float3 p3, Material* material_ptr);
	__device__
	virtual bool Intersection(const Ray& ray, HitRec& hr);
	__device__
	virtual ~Triangle();
};

#endif
