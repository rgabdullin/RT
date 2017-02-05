#ifndef __Material__
#define __Material__

#include "../brdfs.h"

class Material {
public:
	__device__
	virtual float3 shade(HitRec* hr) = 0;
	__device__
	virtual ~Material();
};

#endif
