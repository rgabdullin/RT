#ifndef __GObject__
#define __GObject__

#include "../Utils/Ray.h"
#include "../Utils/HitRec.h"
#include "../Materials.h"

#include <cuda.h>

class GObject
{
protected:
	Material* material_ptr;
public:
	__device__
	GObject();
	__device__
	void SetMaterial(Material * l_material_ptr);
	__device__
	virtual bool Intersection(const Ray&, HitRec&) = 0;
	__device__
	virtual ~GObject();
};

#endif
