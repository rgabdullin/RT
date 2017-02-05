#include "Sampler.h"

/* Sampler */
__device__
void Sampler::init(int num_of_samples, int num_of_sets, float e) {
	GenerateSamples(num_of_samples, num_of_sets);

	MapSamplesToHemisphere(e);
}

__device__
void Sampler::MapSamplesToHemisphere(float e) {
	hemisphere_samples = (float3*)malloc(sizeof(float3) * num_samples * num_sets);

	for (int i = 0; i < num_samples * num_sets; ++i) {
		float3 tmp;
		float sin_phi = sin(2.0f * acos(-1.0f) * square_samples[i].x);
		float cos_phi = cos(2.0f * acos(-1.0f) * square_samples[i].x);
		float cos_theta = pow((1.0f - square_samples[i].y), 1.0f / (e + 1.0f));
		float sin_theta = sqrt(1.0f - cos_theta * cos_theta);
		tmp = make_float3(sin_theta * cos_phi, sin_theta * sin_phi, cos_theta);
		hemisphere_samples[i] = tmp;
	}
}

__device__
float2 Sampler::SampleUnitSquare(int l_num_of_sample, int l_num_of_set) {
	return square_samples[num_samples * (l_num_of_set % num_sets) + (l_num_of_sample % num_samples)];
}

__device__
float3 Sampler::SampleHemisphere(int l_num_of_sample, int l_num_of_set) {
	return hemisphere_samples[num_samples * (l_num_of_set % num_sets) + (l_num_of_sample % num_samples)];
}

__device__
Sampler::~Sampler(void) {
	free(square_samples);
	free(hemisphere_samples);
}
