################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../sources/Utils/HitRec.cu \
../sources/Utils/ViewPlane.cu 

OBJS += \
./sources/Utils/HitRec.o \
./sources/Utils/ViewPlane.o 

CU_DEPS += \
./sources/Utils/HitRec.d \
./sources/Utils/ViewPlane.d 


# Each subdirectory must supply rules for building sources it contributes
sources/Utils/%.o: ../sources/Utils/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-8.0/bin/nvcc -O3 -gencode arch=compute_30,code=sm_30  -odir "sources/Utils" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-8.0/bin/nvcc -O3 --compile --relocatable-device-code=true -gencode arch=compute_30,code=compute_30 -gencode arch=compute_30,code=sm_30  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

