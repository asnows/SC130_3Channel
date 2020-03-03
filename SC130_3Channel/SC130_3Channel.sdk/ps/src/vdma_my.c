
#define NOCOS
#ifndef NOCOS
	#include <sys/mman.h>
	#include <hw/inout.h>
#endif
#include <stdint.h>
#include <unistd.h>
#include "xil_types.h"

#define  VDMAS2MMPHYADDR      0x43000000
#define  S2MM_VDMACR          0x30
#define  S2MM_VDMASR          0x34
#define  S2MM_VDMA_IRQ_MASK   0x3c
#define  S2MM_REG_INDEX       0x44
#define  S2MM_VSIZE           0xA0
#define  S2MM_HSIZE           0xA4

#define  S2MM_FRMDLY_STRIDE   0xA8
#define  S2MM_START_ADDRESS1  0xAC
#define  S2MM_START_ADDRESS2 (0xAC+4)
#define  S2MM_START_ADDRESS3 (0xAC+4*2)
#define  S2MM_START_ADDRESS4 (0xAC+4*3)
#define  S2MM_START_ADDRESS5 (0xAC+4*4)
#define  S2MM_START_ADDRESS6 (0xAC+4*5)
#define  S2MM_START_ADDRESS7 (0xAC+4*6)
#define  S2MM_START_ADDRESS8 (0xAC+4*7)
#define  S2MMLEN             (0xAC+4*32)

#ifdef NOCOS
#define  out32  Xil_Out32
#define  in32   Xil_In32
#endif
unsigned int VdmaVirAddr;
unsigned int Vdmavaild;
/**************************************************************
 *函数：void Get_VdmaVirAddr(void)
 *功能：获取VDMA使用的虚拟地址
 **************************************************************/
void Xil_Out32(INTPTR Addr, u32 Value)
{
	u32 *LocalAddr = (u32 *)Addr;
	*LocalAddr = Value;
}

void Get_VdmaVirAddr(void)
{
	if(Vdmavaild!=0x55555555)
	{
#ifndef NOCOS
		VdmaVirAddr=mmap_device_io(S2MMLEN, VDMAS2MMPHYADDR);
#else
		VdmaVirAddr=VDMAS2MMPHYADDR;
#endif
		Vdmavaild =0x55555555;
	}
}
/**************************************************************
 *函数：void Set_VDMARXBuff(unsigned int *RxBuff,unsigned char RxNum)
 *功能：设置结束的数据地址，目前只处理4个或者8个
 **************************************************************/
void Set_VDMARXBuff(unsigned int *RxBuff,unsigned char RxNum)
{
	if((RxNum!=4)&&(RxNum!=8))return ;
	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();
	out32(VdmaVirAddr+S2MM_START_ADDRESS4,RxBuff[3]);
	out32(VdmaVirAddr+S2MM_START_ADDRESS3,RxBuff[2]);
	out32(VdmaVirAddr+S2MM_START_ADDRESS2,RxBuff[1]);
	out32(VdmaVirAddr+S2MM_START_ADDRESS1,RxBuff[0]);
	if(RxNum==8)
	{
			out32(VdmaVirAddr+S2MM_START_ADDRESS8,RxBuff[7]);
			out32(VdmaVirAddr+S2MM_START_ADDRESS7,RxBuff[6]);
			out32(VdmaVirAddr+S2MM_START_ADDRESS6,RxBuff[5]);
			out32(VdmaVirAddr+S2MM_START_ADDRESS5,RxBuff[4]);
	}
}
/**************************************************************
 *函数：void Set_Vdma_Image(unsigned int H,unsigned int V,unsigned int STRIDE)
 *功能：设置结束的数据地址，目前只处理4个或者8个
 **************************************************************/
void Set_Vdma_Image(unsigned int H,unsigned int STRIDE)
{

	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();

	out32(VdmaVirAddr+S2MM_HSIZE,H);
	out32(VdmaVirAddr+S2MM_FRMDLY_STRIDE,STRIDE);
}
/**************************************************************
 *函数：void Set_Vdma_Image(unsigned int H,unsigned int V,unsigned int STRIDE)
 *功能：设置结束的数据地址，目前只处理4个或者8个
 **************************************************************/
void Set_Vdma_Image_V(unsigned int V)
{

	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();

	out32(VdmaVirAddr+S2MM_VSIZE,V);
}
/**************************************************************
 *函数：void  Vdma_start(void)
 *功能：启动vdma
 **************************************************************/
void  Vdma_start(void)
{
	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();
	out32(VdmaVirAddr+S2MM_VDMACR,0x1010A);
}
/**************************************************************
 *函数：void  Vdma_start(void)
 *功能：启动vdma
 **************************************************************/
void  Vdma_Begin(void)
{
	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();
	out32(VdmaVirAddr+S2MM_VDMACR,0x1010B);
}
/**************************************************************
 *函数：void  Vdma_start(void)
 *功能：启动vdma
 **************************************************************/
void  Vdma_stop(void)
{
	if(Vdmavaild!=0x55555555)Get_VdmaVirAddr();
	out32(VdmaVirAddr+S2MM_VDMACR,0x00);
}

/**************************************************************
 *函数：void vdma_write_init(unsigned int H,unsigned int V,unsigned int channle,unsigned int *Rx,unsigned char Rxnum)
 *功能：配置VMDA数据
 *     H V channel 像素：1280 960 3
 *     RX  数据存放缓冲
 *     Rxnum 缓冲个数
 **************************************************************/

void My_vdma_write_init(unsigned int H,unsigned int V,unsigned int channle,unsigned int *Rx,unsigned char Rxnum)
{
	unsigned int STRIDE;
 #ifndef NOCOS
	STRIDE =H *channle;
	//STRIDE +=16;
	//STRIDE &=0xfff0;
	STRIDE +=128;//   存放长度必须安好每行 取16字节对齐 之后，再空余128字节用于以太网协议存放
	Get_VdmaVirAddr();
	Vdma_start();
	printf("HH:%x--ST:%x",H*channle,STRIDE);

	Set_VDMARXBuff(Rx,Rxnum);
	Set_Vdma_Image(H*channle,V,STRIDE);
#else
	Vdma_start();
	Set_Vdma_Image(H*channle+52,H*channle+52);
	Set_VDMARXBuff(Rx,Rxnum);
	Vdma_Begin();
	Set_Vdma_Image_V(V);


#endif
	//Vdma_start();
}
