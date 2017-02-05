#ifndef __Light__
#define __Light__

#include "../Utils/HitRec.h"

class Light {
protected:
	bool shadows;
public:
	__device__
	virtual float3 GetDirection(HitRec* hr) = 0;
	__device__
	virtual float3 L(HitRec* hr) = 0;
	__device__
	virtual ~Light();
};

#endif
