#include "Tracer.h"

/* Tracer */
__device__
Tracer::Tracer(World* l_wr) :
	wr(l_wr)
{}
__device__
Tracer::~Tracer() {}
