#ifndef __PointLight__
#define __PointLight__

#include "Light.h"

class PointLight : public Light {
	float ls;
	float3 color;
	float3 location;
public:
	__device__
	PointLight(float3 l_location, float l_ls = 1.0f, float3 l_color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	virtual float3 GetDirection(HitRec* hr);
	__device__
	virtual float3 L(HitRec* hr);
	__device__
	virtual ~PointLight();
};

#endif