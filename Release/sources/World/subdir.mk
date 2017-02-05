################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/World/World.cu \
../sources/World/World_buildScene_test.cu \
../sources/World/World_clear.cu \
../sources/World/World_init.cu \
../sources/World/World_render.cu \
../sources/World/World_utils.cu 

OBJS += \
./sources/World/World.o \
./sources/World/World_buildScene_test.o \
./sources/World/World_clear.o \
./sources/World/World_init.o \
./sources/World/World_render.o \
./sources/World/World_utils.o 

CU_DEPS += \
./sources/World/World.d \
./sources/World/World_buildScene_test.d \
./sources/World/World_clear.d \
./sources/World/World_init.d \
./sources/World/World_render.d \
./sources/World/World_utils.d 


# Each subdirectory must supply rules for building sources it contributes
sources/World/%.o: ../sources/World/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/World" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


