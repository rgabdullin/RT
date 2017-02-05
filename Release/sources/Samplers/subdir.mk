################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Samplers/JitteredSampler.cu \
../sources/Samplers/MultiJitteredSampler.cu \
../sources/Samplers/RegularSampler.cu \
../sources/Samplers/Sampler.cu 

OBJS += \
./sources/Samplers/JitteredSampler.o \
./sources/Samplers/MultiJitteredSampler.o \
./sources/Samplers/RegularSampler.o \
./sources/Samplers/Sampler.o 

CU_DEPS += \
./sources/Samplers/JitteredSampler.d \
./sources/Samplers/MultiJitteredSampler.d \
./sources/Samplers/RegularSampler.d \
./sources/Samplers/Sampler.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Samplers/%.o: ../sources/Samplers/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/Samplers" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


