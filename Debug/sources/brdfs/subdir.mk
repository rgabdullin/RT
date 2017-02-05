################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/brdfs/Lambertian.cu \
../sources/brdfs/brdf.cu 

OBJS += \
./sources/brdfs/Lambertian.o \
./sources/brdfs/brdf.o 

CU_DEPS += \
./sources/brdfs/Lambertian.d \
./sources/brdfs/brdf.d 


# Each subdirectory must supply rules for building sources it contributes
sources/brdfs/%.o: ../sources/brdfs/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30  -odir "sources/brdfs" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


