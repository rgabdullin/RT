#include "World.h"
#include <cstdio>
#include "curand.h"
#include "curand_kernel.h"

__global__ void Render_Frame(World * w, int offset) {
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	int b_idx = threadIdx.x;
	curandState_t state;
	curand_init(23041996 * idx, 0, 0, &state);

	__shared__ int width; if (b_idx == 0) width = w->vp.res.x;
	__shared__ int height; if (b_idx == 0) height = w->vp.res.y;
	__shared__ float inv_sampler_points_num; if (b_idx == 0) inv_sampler_points_num = 1.0f / w->num_rays_per_pixel;
	__syncthreads();
	if (idx + offset < width * height) {
		int x = (idx + offset) % width;
		int y = (idx + offset) / width;

		Ray ray;
		HitRec hr;
		float2 pt;
		float3 color;

		int sampler_set_idx = curand(&state) % w->pixel_sampler->num_sets;

		w->gpu_buffer[idx] = make_float3(0, 0, 0);

		for (int i = 0; i < w->num_rays_per_pixel; ++i){
			ray.sampler_point_number = i;
			ray.sampler_set_number = sampler_set_idx;

			pt = w->pixel_sampler->SampleUnitSquare(ray.sampler_point_number, ray.sampler_set_number);

			w->camera->MakeRay(&ray, make_int2(x, y), pt);

			make_HitRec(&hr, w, &ray);

			w->ray_tracer->TraceRay(&ray, &hr);

			color = w->background_color;

			if (hr.isHit)
				color = hr.material_ptr->shade(&hr);

			w->gpu_buffer[idx] += color * inv_sampler_points_num;
			__syncthreads();
		}
	}
}

void renderScene(World *w, int pixels_in_frame) {
	printf("Rendering scene:\n\t");
	printf("Resolution: %d x %d\n\t", w->vp.res.x, w->vp.res.y);
	printf("Sampling: %d\n\t", w->num_rays_per_pixel);
	printf("Number of objects: %d\n\t", w->num_of_objects);
	printf("Number of lights: %d\n\t", w->num_of_lights);
	printf("Frame size: %d\n\t", pixels_in_frame);
	fflush(stdout);

	cudaMalloc(&w->gpu_buffer, sizeof(float3) * pixels_in_frame);

	int block_size = BLOCKSIZE;
	int num_pixels = w->vp.res.x * w->vp.res.y;
	int num_frames = num_pixels / pixels_in_frame + (num_pixels % pixels_in_frame ? 1 : 0);

	printf("Frame number: %d\n", num_frames); fflush(stdout);

	int pixels_rendered = 0;
	for (int frame_idx = 0; frame_idx < num_frames; ++frame_idx) {
		printf("\r\tTotal: %.2f %%", (float)(pixels_rendered) / num_pixels * 100.0f);fflush(stdout);
		int pixels_to_render = (pixels_in_frame < num_pixels - pixels_rendered ? pixels_in_frame : num_pixels - pixels_rendered);
		int num_blocks = pixels_to_render / block_size + (pixels_to_render % block_size ? 1 : 0);

		Render_Frame <<< num_blocks, block_size >>> (w, pixels_rendered);
		SYNC_AND_CHECK_CUDA_ERRORS;

		cudaMemcpy(w->image + pixels_rendered, w->gpu_buffer, sizeof(float3) * pixels_to_render, cudaMemcpyDeviceToHost);
		SYNC_AND_CHECK_CUDA_ERRORS;

		pixels_rendered += pixels_to_render;
	}
	printf("\r");fflush(stdout);

	cudaFree(w->gpu_buffer);
}
