#include "World.h"
#include <cstdio>

__global__
void initWorld_gpu(World * w) {
	w->pixel_sampler = new MultiJitteredSampler();
	w->pixel_sampler->init(w->num_rays_per_pixel, 67);

	w->ray_tracer = new PrimaryRayTracer(w);
}

void initWorld(World *w, int2 res, float size, int num_rays_per_pixel) {
	w->vp.init(res, size);

	w->num_rays_per_pixel = num_rays_per_pixel;

	w->background_color = make_float3(0, 0, 0.25);

	w->image = (float3*)malloc(sizeof(float3) * res.x * res.y);
	printf("Allocated memory to image: %.2fKBs\n", float(sizeof(float3) * res.x * res.y) / 1024); fflush(stdout);
	SYNC_AND_CHECK_CUDA_ERRORS;

	initWorld_gpu <<< 1, 1 >>>(w);
	SYNC_AND_CHECK_CUDA_ERRORS;
}
