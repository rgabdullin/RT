################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Lights/AmbientLight.cu \
../sources/Lights/DirectionalLight.cu \
../sources/Lights/Light.cu \
../sources/Lights/PointLight.cu 

OBJS += \
./sources/Lights/AmbientLight.o \
./sources/Lights/DirectionalLight.o \
./sources/Lights/Light.o \
./sources/Lights/PointLight.o 

CU_DEPS += \
./sources/Lights/AmbientLight.d \
./sources/Lights/DirectionalLight.d \
./sources/Lights/Light.d \
./sources/Lights/PointLight.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Lights/%.o: ../sources/Lights/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 -gencode arch=compute_30,code=sm_30  -odir "sources/Lights" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -G -g -O0 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


