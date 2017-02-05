#include "PinholeCamera.h"
#include "../Utils/World.h"
#include "../Utils/cuda_math.h"

/* Pinhole Camera */

__device__
PinholeCamera::PinholeCamera(World* l_wr) : Camera(l_wr), dist_to_vp(1.0), zoom(1.0) {}

__device__
void PinholeCamera::init_pinhole(float l_dist_to_vp, float l_zoom) {
	dist_to_vp = l_dist_to_vp;
	zoom = l_zoom;
}

__device__
void PinholeCamera::MakeRay(Ray* ray, int2 pixel, float2 sample) {
	ray->origin = eye;
	float2 pixel_point = make_float2((float(pixel.x) + sample.x) * wr->vp.psize - 0.5 * wr->vp.psize * wr->vp.res.x, (float(pixel.y) + sample.y)* wr->vp.psize - 0.5 * wr->vp.psize * wr->vp.res.y);
	ray->direction = normalize(-dist_to_vp * zoom * w + pixel_point.x * u + pixel_point.y * v);
	ray->image_idx = pixel.x + pixel.y * wr->vp.res.x;
}
__device__
PinholeCamera::~PinholeCamera() {}
