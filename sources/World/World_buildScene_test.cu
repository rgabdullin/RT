#include "World.h"
#include <cstdio>

__global__
void buildScene_gpu(World * w) {
	PinholeCamera *c = new PinholeCamera(w);
	c->init(make_float3(0, 0, 25), make_float3(0, 0, 0), make_float3(0, 1, 0));
	c->init_pinhole(4,1);
	w->camera = c;

	w->ambient_ptr = new AmbientLight(0.3f);

	PointLight* lt1 = new PointLight(3.0f * make_float3(-5.0f, 12.0f, 4.0f), 1.5f);
	w->scene_lights[0] = lt1;

	PointLight* lt2 = new PointLight(make_float3(4.0f, 10.0f, -1.5f), 1.3f);
	w->scene_lights[1] = lt2;

	DirectionalLight* lt3 = new DirectionalLight(make_float3(-1.0f, -1.0f, -2.0f), 1.0f);
	w->scene_lights[2] = lt3;

	Matte* mt1 = new Matte(w->pixel_sampler, 0.3f, 0.7f, make_float3(0.6f, 0.6f, 0.6f));
	w->scene_materials[0] = mt1;
	Plane * ptr1 = new Plane();
	ptr1->init(make_float3(0, -8.0f, 0), make_float3(0, 1, 0), mt1);
	w->scene_objs[0] = ptr1;

	Phong* mt2 = new Phong(w->pixel_sampler, 0.3f, 0.8f, 0.1f, 15.0f, make_float3(0.9f, 0.001f, 0.001f));
	w->scene_materials[1] = mt2;
	Sphere * ptr2 = new Sphere();
	ptr2->init(make_float3(0, 0, 0), 4, mt2);
	w->scene_objs[1] = ptr2;
}

void buildScene(World *w) {
	printf("Building scene\n"); fflush(stdout);

	w->num_of_objects = 2;
	w->num_of_lights = 3;
	w->num_of_materials = w->num_of_objects;

	cudaMalloc(&w->scene_objs, sizeof(GObject*) * w->num_of_objects);
	cudaMalloc(&w->scene_lights, sizeof(Light*) * w->num_of_lights);
	cudaMalloc(&w->scene_materials, sizeof(Material*) * w->num_of_materials);

	buildScene_gpu <<< 1, 1 >>> (w);
	SYNC_AND_CHECK_CUDA_ERRORS;

	printf("\tOK\n"); fflush(stdout);
}
