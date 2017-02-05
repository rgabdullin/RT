################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/GObjects/GObject.cu \
../sources/GObjects/Plane.cu \
../sources/GObjects/Sphere.cu \
../sources/GObjects/Triangle.cu 

OBJS += \
./sources/GObjects/GObject.o \
./sources/GObjects/Plane.o \
./sources/GObjects/Sphere.o \
./sources/GObjects/Triangle.o 

CU_DEPS += \
./sources/GObjects/GObject.d \
./sources/GObjects/Plane.d \
./sources/GObjects/Sphere.d \
./sources/GObjects/Triangle.d 


# Each subdirectory must supply rules for building sources it contributes
sources/GObjects/%.o: ../sources/GObjects/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/GObjects" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


