/*
 * cuda_const.h
 *
 *  Created on: 03 февр. 2017 г.
 *      Author: ruslixag
 */

#ifndef __CUDA_CONST_H__
#define __CUDA_CONST_H__

#ifndef SYNC_AND_CHECK_CUDA_ERRORS
#define SYNC_AND_CHECK_CUDA_ERRORS {cudaStreamSynchronize(0); cudaError_t x = cudaGetLastError(); if ((x) != cudaSuccess) { printf("Error: %s\n", cudaGetErrorString(x)); fclose(stdout); exit(1); }}
#endif

#ifndef BLOCKSIZE
#define BLOCKSIZE 128
#endif

#endif /* CUDA_CONST_H_ */
