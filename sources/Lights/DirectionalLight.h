#ifndef __DirectLight__
#define __DirectLight__

#include "Light.h"

class DirectionalLight : public Light {
	float ls;
	float3 color;
	float3 direction;
public:
	__device__
	DirectionalLight(float3 l_direction, float l_ls = 1.0f, float3 l_color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	virtual float3 GetDirection(HitRec* hr);
	__device__
	virtual float3 L(HitRec* hr);
	__device__
	virtual ~DirectionalLight();
};

#endif