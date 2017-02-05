#include "World.h"

#include <cstdio>
#include "curand.h"
#include "curand_kernel.h"
#include "FreeImagePlus.h"

/* World */
__device__
World::World() :
	image(NULL),
	gpu_buffer(NULL),
	num_rays_per_pixel(1),
	background_color(make_float3(0.0f,0.0f,0.25f)),
	num_of_objects(1),
	scene_objs(NULL),
	num_of_lights(1),
	scene_lights(NULL),
	ambient_ptr(NULL),
	num_of_materials(1),
	scene_materials(NULL),
	camera(NULL),
	ray_tracer(NULL),
	pixel_sampler(NULL)
{
	vp.init(make_int2(1024,512), 4);
}

__device__
bool World::isHitSceneObject(Ray * ray, HitRec * hr) {
	for (int i = 0; i < num_of_objects; ++i)
		scene_objs[i]->Intersection(*ray, *hr);

	return hr->isHit;
}
