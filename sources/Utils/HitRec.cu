#include "HitRec.h"
#include "World.h"
#include "../Materials.h"
#include "Ray.h"

/* HitRec */
__host__ __device__
void make_HitRec(HitRec* hr, World* wr, Ray* ray) {
	hr->isHit = false;

	hr->hit_point = make_float3(0.0f, 0.0f, 0.0f);
	hr->hit_normal = make_float3(0.0f, 0.0f, 0.0f);
	hr->ray = *ray;
	hr->wr = wr;
	hr->material_ptr = NULL;

	hr->tmin = 1e8f;
}
