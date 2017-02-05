#ifndef __World__
#define __World__

#include <cuda_runtime.h>
#include <string>

#include "ViewPlane.h"
#include "HitRec.h"

#include "../Cameras.h"
#include "../Samplers.h"
#include "../GObjects.h"
#include "../Tracers.h"
#include "../brdfs.h"
#include "../Materials.h"
#include "../Lights.h"


class World {
//FIELDS
public:
	float3 *image;
	float3 *gpu_buffer;

	int num_rays_per_pixel;
	float3 background_color;

	int num_of_objects;
	GObject **scene_objs;

	int num_of_lights;
	Light **scene_lights;
	Light *ambient_ptr;

	int num_of_materials;
	Material **scene_materials;
	
	Camera *camera;
	Tracer *ray_tracer;
	Sampler *pixel_sampler;
	ViewPlane vp;

	__device__ void init_samplers();
	__device__ void init_ray_tracers();

//FUNCTIONS
	__device__ World();
	__device__ bool isHitSceneObject(Ray* ray, HitRec* hr);
};
//FUNCTIONS
void initWorld(World *w, int2 res, float size, int num_rays_per_pixel);
void buildScene(World *w);
void renderScene(World *w, int pixels_in_frame);
void clearScene(World *wr);
void saveSceneToFile(World *w, std::string filename);

#endif
