#include "JitteredSampler.h"
#include "curand.h"
#include "curand_kernel.h"

/* JitteredSampler */
__device__
void JitteredSampler::GenerateSamples(int l_num_of_samples, int l_num_of_sets) {
	curandState_t curand_state;
	curand_init(23041996,0,0,&curand_state);

	square_samples = (float2*)malloc(sizeof(float2) * l_num_of_samples * l_num_of_sets);

	int n = sqrt(float(l_num_of_samples));
	num_samples = n*n;
	num_sets = l_num_of_sets;

	for (int i = 0; i < l_num_of_sets; ++i)
		for (int y = 0; y < n; ++y)
			for (int x = 0; x < n; ++x)
				square_samples[i * num_samples + n * y + x] = make_float2(float(x) / n + curand_uniform(&curand_state) / n, float(y) / n + curand_uniform(&curand_state) / n);
}
__device__
JitteredSampler::~JitteredSampler() {}
