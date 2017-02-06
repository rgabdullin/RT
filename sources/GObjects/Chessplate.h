#ifndef __Chessplate__
#define __Chessplate__

#include "GObject.h"

class Chessplate : public GObject
{
	float3 center;
	float3 up;
	float3 right;
	float2 size;
	float cell_size;
public:
	__device__
	Chessplate();
	__device__
	void init(float3 center, float3 up, float3 right , float2 size, float cell_size, Material* material_ptr);
	__device__
	virtual bool Intersection(const Ray& ray, HitRec& hr);
	__device__
	virtual ~Chessplate();
};

#endif
