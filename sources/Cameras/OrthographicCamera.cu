/* Orthographic Camera */
#include "OrthographicCamera.h"
#include "../Utils/World.h"
#include "../Utils/cuda_math.h"

__device__
OrthographicCamera::OrthographicCamera(World* l_wr) : Camera(l_wr) {}

__device__
void OrthographicCamera::MakeRay(Ray* ray, int2 pixel, float2 sample) {
	ray->origin = eye
		+ ((float(pixel.x) + sample.x) * wr->vp.psize - 0.5 * wr->vp.psize * wr->vp.res.x) * u
		+ ((float(pixel.y) + sample.y) * wr->vp.psize - 0.5 * wr->vp.psize * wr->vp.res.y) * v;
	ray->direction = normalize(-w);
	ray->image_idx = pixel.x + pixel.y * wr->vp.res.x;
}
__device__
OrthographicCamera::~OrthographicCamera() {}
