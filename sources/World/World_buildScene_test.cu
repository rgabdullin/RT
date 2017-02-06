#include "World.h"
#include <cstdio>

__global__
void buildScene1_gpu(World * w) {
	w->num_of_objects = 2;
	w->num_of_lights = 3;
	w->num_of_materials = w->num_of_objects;

	w->scene_objs = (GObject**)malloc(sizeof(GObject*) * w->num_of_objects);
	w->scene_lights = (Light**)malloc(sizeof(Light*) * w->num_of_lights);
	w->scene_materials = (Material**)malloc(sizeof(Material*) * w->num_of_materials);

	PinholeCamera *c = new PinholeCamera(w);
	c->init(make_float3(0, 0, 25), make_float3(0, 0, 0), make_float3(0, 1, 0));
	c->init_pinhole(4,1);
	w->camera = c;

	w->ambient_ptr = new AmbientLight(0.3f);

	PointLight* lt1 = new PointLight(3.0f * make_float3(-5.0f, 12.0f, 4.0f), 0.8f);
	w->scene_lights[0] = lt1;

	PointLight* lt2 = new PointLight(2.0f * make_float3(4.0f, 10.0f, -1.5f), 1.0f);
	w->scene_lights[1] = lt2;

	DirectionalLight* lt3 = new DirectionalLight(make_float3(-1.0f, -1.0f, -2.0f), 0.7f);
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

__global__
void buildScene2_gpu(World * w) {
	w->num_of_objects = 3;
	w->num_of_lights = 3;
	w->num_of_materials = w->num_of_objects;

	w->scene_objs = (GObject**)malloc(sizeof(GObject*) * w->num_of_objects);
	w->scene_lights = (Light**)malloc(sizeof(Light*) * w->num_of_lights);
	w->scene_materials = (Material**)malloc(sizeof(Material*) * w->num_of_materials);

	PinholeCamera *c = new PinholeCamera(w);
	c->init(make_float3(-16, 0, 25), make_float3(0, 0, 0), make_float3(0, 1, 0));
	c->init_pinhole(4,1);
	w->camera = c;

	w->ambient_ptr = new AmbientLight(0.3f);

	PointLight* lt1 = new PointLight(make_float3(-0.5,0,25), 0.4f);
	w->scene_lights[0] = lt1;

	PointLight* lt2 = new PointLight(make_float3( 0.7,0,25), 0.4f);
	w->scene_lights[1] = lt2;

	DirectionalLight* lt3 = new DirectionalLight(make_float3(-8, 0, -25), 1.0f);
	w->scene_lights[2] = lt3;

	Matte* mt1 = new Matte(w->pixel_sampler, 0.3f, 0.7f, make_float3(1.0f, 1.0f, 1.0f));
	w->scene_materials[0] = mt1;
	Plate * ptr1 = new Plate();
	ptr1->init(make_float3(0, 0, 0), make_float3(0, 1, 0), make_float3(1, 0, 0), make_float2(33,25), mt1);
	w->scene_objs[0] = ptr1;

	Matte* mt2 = new Matte(w->pixel_sampler, 0.3f, 0.8f, make_float3(0.01f, 1.0f, 0.01f));
	w->scene_materials[1] = mt2;
	Chessplate * ptr2 = new Chessplate();
	ptr2->init(make_float3(0, 0, 19.9), make_float3(0, 1, 0), make_float3(1, 0, 0.0), make_float2(12.5,8.5), 0.1f, mt2);
	w->scene_objs[1] = ptr2;

	Matte* mt3 = new Matte(w->pixel_sampler, 0.3f, 0.8f, make_float3(1.0f, 0.01f, 0.01f));
	w->scene_materials[2] = mt3;
	Chessplate* ptr3 = new Chessplate();
	ptr3->init(make_float3(0, 0, 20.0), make_float3(0, 1, 0), make_float3(1, 0, 0.0), make_float2(12.5,8.5), 0.5f / 7, mt3);
	w->scene_objs[2] = ptr3;
}

void buildScene(World *w) {
	printf("Building scene\n"); fflush(stdout);

	buildScene2_gpu <<< 1, 1 >>> (w);
	SYNC_AND_CHECK_CUDA_ERRORS;

	printf("\tOK\n"); fflush(stdout);
}
