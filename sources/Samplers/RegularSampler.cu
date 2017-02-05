#include "RegularSampler.h"

/* RegularSampler */
__device__
void RegularSampler::GenerateSamples(int l_num_of_samples, int l_num_of_sets) {
	square_samples = (float2*)malloc(sizeof(float2) * l_num_of_samples * l_num_of_sets);
	int n = sqrt(float(l_num_of_samples));
	num_samples = n*n;
	num_sets = l_num_of_sets;
	for (int i = 0; i < l_num_of_sets; ++i)
		for (int y = 0; y < n; ++y)
			for (int x = 0; x < n; ++x)
				square_samples[i * num_samples + n * y + x] = make_float2(float(x) / n + 1.0 / (2 * n), float(y) / n + 1.0 / (2 * n));
}
__device__
RegularSampler::~RegularSampler() {}
