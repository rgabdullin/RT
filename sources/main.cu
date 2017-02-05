#ifndef SYNC_AND_CHECK_CUDA_ERRORS
#define SYNC_AND_CHECK_CUDA_ERRORS {cudaStreamSynchronize(0); cudaError_t x = cudaGetLastError(); if ((x) != cudaSuccess) { printf("Error: %s\n", cudaGetErrorString(x)); fclose(stdout); exit(1); }}
#endif

#include <cstdio>
#include <cstdlib>
#include <sstream>
#include <ctime>
#include <string>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include "curand.h"
#include "curand_kernel.h"

#include "./Utils/World.h"


void printInfo(void) {
	time_t start_time; time(&start_time);
	struct tm* s_time = localtime(&start_time);
	printf("Runnning. time = %04d/%02d/%02d %02d:%02d:%02d\n",
			s_time->tm_year + 1900,
			s_time->tm_mon + 1,
			s_time->tm_mday,
			s_time->tm_hour,
			s_time->tm_min,
			s_time->tm_sec);

	cudaDeviceProp props;
	int dev_count;

	cudaGetDeviceCount(&dev_count);

	printf("Detected %d devices:\n", dev_count);
	for (int i = 0; i < dev_count; ++i) {
		cudaGetDeviceProperties(&props, i);
		printf("\t[ %d ] %s, %.1f GBs memory, CUDA %d.%d Compute Capability\n", i, props.name, float(props.totalGlobalMem) / (1024 * 1024 * 1024), props.major, props.minor);
	}
	printf("\n");
	SYNC_AND_CHECK_CUDA_ERRORS;
}

int main(int argc, char** argv) {
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	clock_t start_clock, end_clock;

	printInfo();

	int framesize = 256 * 256;
	if (argc > 1)
		sscanf(argv[1], "%d", &framesize);
	start_clock = clock();

	World* w;
	cudaMallocManaged(&w, sizeof(World));

	initWorld(w, 4 * make_int2(512, 256), 4, 16);
	buildScene(w);

	//Tracing
	cudaEventRecord(start, 0);

	renderScene(w, framesize);

	cudaEventRecord(stop, 0);
	cudaStreamSynchronize(0);

	float _time;
	cudaEventElapsedTime(&_time, start, stop);
	printf("Tracing time: %.2f ms\n\n", _time);

	//Saving image
	std::stringstream st;
	time_t now_oclock; time(&now_oclock);
	clock_t now_clock = clock();
	st << "./pics/pic" << now_oclock << "_" << now_clock % 1000 << ".bmp";
	char filename[255];
	st.getline(filename, 255);
	//saveSceneToFile(w, filename);
	saveSceneToFile(w, "./pics/test.bmp");
	clearScene(w);

	end_clock = clock();
	printf("TIME ELAPSED: %lf\n", (end_clock - start_clock) / 1000.0);

	fclose(stdout);

	return 0;
}
