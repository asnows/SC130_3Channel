################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/Bsp_RGB_Samp.c \
../src/Bsp_TwoCPU.c \
../src/Bsp_VDMAframe.c \
../src/Image_Pixl.c \
../src/SC030GS.c \
../src/get_image.c \
../src/helloworld.c \
../src/platform.c \
../src/psiic.c \
../src/sc030_fpga.c \
../src/vdma.c \
../src/vdma_my.c 

OBJS += \
./src/Bsp_RGB_Samp.o \
./src/Bsp_TwoCPU.o \
./src/Bsp_VDMAframe.o \
./src/Image_Pixl.o \
./src/SC030GS.o \
./src/get_image.o \
./src/helloworld.o \
./src/platform.o \
./src/psiic.o \
./src/sc030_fpga.o \
./src/vdma.o \
./src/vdma_my.o 

C_DEPS += \
./src/Bsp_RGB_Samp.d \
./src/Bsp_TwoCPU.d \
./src/Bsp_VDMAframe.d \
./src/Image_Pixl.d \
./src/SC030GS.d \
./src/get_image.d \
./src/helloworld.d \
./src/platform.d \
./src/psiic.d \
./src/sc030_fpga.d \
./src/vdma.d \
./src/vdma_my.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../ps_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


