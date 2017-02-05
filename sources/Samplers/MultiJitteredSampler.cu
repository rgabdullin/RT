#include "MultiJitteredSampler.h"
#include "curand.h"
#include "curand_kernel.h"

/* MultiJitteredSampler */
__device__
void MultiJitteredSampler::shuffle_coordinates(int offset) {
	curandState_t curand_state;
	curand_init(23041996,0,0,&curand_state);

	for (int i = 0; i < num_samples; ++i) {
		int k = curand(&curand_state) % num_samples;
		int j = curand(&curand_state) % num_samples;
		float c;
		c = square_samples[i + offset].x;
		square_samples[i + offset].x = square_samples[k + offset].x;
		square_samples[k + offset].x = c;
		c = square_samples[i + offset].y;
		square_samples[i + offset].y = square_samples[j + offset].y;
		square_samples[j + offset].y = c;
	}
}
__device__
void MultiJitteredSampler::GenerateSamples(int l_num_of_samples, int l_num_of_sets) {
	curandState_t curand_state;
	curand_init(23041996,0,0,&curand_state);

	square_samples = (float2*)malloc(sizeof(float2) * l_num_of_samples * l_num_of_sets);

	int n = sqrt(float(l_num_of_samples));
	num_samples = n*n;
	num_sets = l_num_of_sets;

	for (int i = 0; i < l_num_of_sets; ++i) {
		for (int y = 0; y < n; ++y)
			for (int x = 0; x < n; ++x)
				square_samples[i * num_samples + n * y + x] = make_float2(
					float(x) / n + (float(y) / n + curand_uniform(&curand_state) / n) / n,
					float(y) / n + (float(x) / n + curand_uniform(&curand_state) / n) / n);
		shuffle_coordinates(i * num_samples);
	}
}
__device__
MultiJitteredSampler::~MultiJitteredSampler() {}
