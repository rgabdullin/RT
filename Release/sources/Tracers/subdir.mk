################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Tracers/PrimaryRayTracer.cu \
../sources/Tracers/Tracer.cu 

OBJS += \
./sources/Tracers/PrimaryRayTracer.o \
./sources/Tracers/Tracer.o 

CU_DEPS += \
./sources/Tracers/PrimaryRayTracer.d \
./sources/Tracers/Tracer.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Tracers/%.o: ../sources/Tracers/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/Tracers" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


