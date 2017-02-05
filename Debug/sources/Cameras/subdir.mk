################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Cameras/Camera.cu \
../sources/Cameras/OrthographicCamera.cu \
../sources/Cameras/PinholeCamera.cu 

OBJS += \
./sources/Cameras/Camera.o \
./sources/Cameras/OrthographicCamera.o \
./sources/Cameras/PinholeCamera.o 

CU_DEPS += \
./sources/Cameras/Camera.d \
./sources/Cameras/OrthographicCamera.d \
./sources/Cameras/PinholeCamera.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Cameras/%.o: ../sources/Cameras/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30  -odir "sources/Cameras" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


