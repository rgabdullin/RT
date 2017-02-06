#ifndef __Plate__
#define __Plate__

#include "GObject.h"

class Plate : public GObject
{
	float3 center;
	float3 up;
	float3 right;
	float2 size;
public:
	__device__
	Plate();
	__device__
	void init(float3 center, float3 up, float3 right , float2 size, Material* material_ptr);
	__device__
	virtual bool Intersection(const Ray& ray, HitRec& hr);
	__device__
	virtual ~Plate();
};

#endif
