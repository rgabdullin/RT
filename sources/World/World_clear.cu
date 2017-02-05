#include "World.h"
#include <cstdio>

__global__
void ClearMaterials(Material **ptr) {
	int idx = threadIdx.x;

	delete ptr[idx];
}
__global__
void ClearObjects(GObject **ptr) {
	int idx = threadIdx.x;

	delete ptr[idx];
}
__global__
void ClearLights(Light **ptr) {
	int idx = threadIdx.x;

	delete ptr[idx];
}
__global__
void ClearGPU(World *ptr) {
	delete ptr->camera;
	delete ptr->ray_tracer;
	delete ptr->pixel_sampler;
	delete ptr->ambient_ptr;
}

void clearScene(World *wr) {
	printf("Destroying scene\n"); fflush(stdout);
	free(wr->image);

	if(wr->num_of_objects > 0) {
		printf("\t-Objects\n"); fflush(stdout);
		ClearObjects <<< 1, wr->num_of_objects >>> (wr->scene_objs);
	}
	SYNC_AND_CHECK_CUDA_ERRORS;

	if (wr->num_of_materials > 0) {
		printf("\t-Materials\n"); fflush(stdout);
		ClearMaterials <<< 1, wr->num_of_materials >>> (wr->scene_materials);
	}
	SYNC_AND_CHECK_CUDA_ERRORS;

	if (wr->num_of_lights > 0) {
		printf("\t-Lights\n"); fflush(stdout);
		ClearLights <<< 1, wr->num_of_lights >>> (wr->scene_lights);
	}
	SYNC_AND_CHECK_CUDA_ERRORS;

	ClearGPU <<< 1, 1 >>> (wr);
	SYNC_AND_CHECK_CUDA_ERRORS;

	cudaFree(wr->scene_materials);
	cudaFree(wr->scene_lights);
	cudaFree(wr->scene_objs);

	SYNC_AND_CHECK_CUDA_ERRORS;

	cudaFree(wr);

	SYNC_AND_CHECK_CUDA_ERRORS;
	printf("\tOK\n"); fflush(stdout);
}
