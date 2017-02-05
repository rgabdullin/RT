#ifndef __HitRec__
#define __HitRec__

#include <cuda_runtime.h>

#include "Ray.h"

class Material;
class World;

struct HitRec {
public:
	float3 hit_point;
	float3 hit_normal;
	Material* material_ptr;

	Ray ray;
	World* wr;

	float tmin;

	bool isHit;
};

__host__ __device__
void make_HitRec(HitRec* hr, World* wr, Ray* ray);
#endif
