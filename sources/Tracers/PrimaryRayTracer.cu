#include "PrimaryRayTracer.h"
#include "../Utils/World.h"

/* PrimaryRayTracer */
__device__
PrimaryRayTracer::PrimaryRayTracer(World* l_wr) :
	Tracer(l_wr)
{}

__device__
void PrimaryRayTracer::TraceRay(Ray* ray, HitRec* hr) {
	wr->isHitSceneObject(ray, hr);
}
__device__
PrimaryRayTracer::~PrimaryRayTracer() {}
