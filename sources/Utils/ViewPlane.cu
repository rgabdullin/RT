#include "ViewPlane.h"

/* ViewPlane */
__host__ __device__
ViewPlane::ViewPlane(int2 res, float height){
	init(res, height);
}
__host__ __device__
void ViewPlane::init(int2 l_res, float l_height) {
	res = l_res;
	psize = l_height / (res.y + 1);
}
