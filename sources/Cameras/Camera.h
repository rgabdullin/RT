#ifndef __Camera__
#define __Camera__

#include <cuda_runtime.h>
#include "../Utils/Ray.h"

class World;

class Camera {
public:
	float3 eye, lookat, up;
	float3 u, v, w;
	World* wr;
	__device__
	Camera(World* l_wr);
	__device__
	void init(float3 l_eye, float3 l_lookat, float3 l_up);
	__device__
	virtual void MakeRay(Ray* ray, int2 pixel, float2 sample) = 0;
	__device__
	virtual ~Camera();
};

#endif
