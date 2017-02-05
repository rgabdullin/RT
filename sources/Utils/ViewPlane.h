#ifndef __ViewPlane__
#define __ViewPlane__

#include <cuda_runtime.h>
#include <vector_types.h>

class ViewPlane {
public:
	float psize;
	int2 res;

	__host__ __device__
	ViewPlane(int2 res = make_int2(1024, 512), float height = 4.0f);
	__host__ __device__
	void init(int2 l_res, float l_height);
};

#endif
