#include "Camera.h"
#include "../Utils/Ray.h"
#include "../Utils/World.h"
#include "../Utils/cuda_math.h"

/* Camera */

__device__
Camera::Camera(World* l_wr) {
	wr = l_wr;
}

__device__
void Camera::init(float3 l_eye, float3 l_lookat, float3 l_up) {
	eye = l_eye;
	lookat = l_lookat;
	up = l_up;
	w = normalize(eye - lookat);
	u = normalize(cross(up, w));
	v = cross(w, u);
}

__device__
Camera::~Camera() {}
