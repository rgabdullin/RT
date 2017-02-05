#include "GObject.h"

/* GObject */
__device__
GObject::GObject() : material_ptr(NULL) {}

__device__
void GObject::SetMaterial(Material * l_material_ptr) {
	material_ptr = l_material_ptr;
}

__device__
GObject::~GObject() {}
