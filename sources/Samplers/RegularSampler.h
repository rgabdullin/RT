#ifndef __RegularSampler__
#define __RegularSampler__

#include "Sampler.h"

class RegularSampler : public Sampler {
public:
	__device__
	virtual void GenerateSamples(int num_of_samples, int num_of_sets = 1);
	__device__
	virtual ~RegularSampler();
};

#endif
