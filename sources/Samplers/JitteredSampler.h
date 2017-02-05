#ifndef __JitteredSampler__
#define __JitteredSampler__

#include "Sampler.h"

class JitteredSampler : public Sampler {
public:
	__device__
	virtual void GenerateSamples(int num_of_samples, int num_of_sets = 1);
	__device__
	virtual ~JitteredSampler();
};

#endif
