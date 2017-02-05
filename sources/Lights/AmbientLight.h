#ifndef __AmbientLight__
#define __AmbientLight__

#include "Light.h"

class AmbientLight : public Light {
	float ls;
	float3 color;
public:
	__device__
	AmbientLight(float l_ls = 1.0f, float3 l_color = make_float3(1.0f, 1.0f, 1.0f));
	__device__
	virtual float3 GetDirection(HitRec* hr);
	__device__
	virtual float3 L(HitRec* hr);
	__device__
	virtual ~AmbientLight();
};

#endif