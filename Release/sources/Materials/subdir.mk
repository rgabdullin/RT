################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Materials/Material.cu \
../sources/Materials/Matte.cu 

OBJS += \
./sources/Materials/Material.o \
./sources/Materials/Matte.o 

CU_DEPS += \
./sources/Materials/Material.d \
./sources/Materials/Matte.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Materials/%.o: ../sources/Materials/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/Materials" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


