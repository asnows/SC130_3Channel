#include "SC030GS.h"
#include "Bsp_TwoCPU.h"
#include "xil_io.h"
#include "Image_Pixl.h"
#include  "SC030GS.h"
void (*GetImage_pixlfuntion)(struct Image_Reg *);

struct Image_Reg IR_Pixel;

/**********************************************************
 *函数：void Image_Information(void)
 ***********************************************************/
 void Image_Information(void)
{
	unsigned int Pixel;
	unsigned short HH;
	unsigned short VV;

	Pixel=Xil_In32(SENSORADDR);//获取像素值
	//Rate =  Pixel>>24;
	HH   = (Pixel>>12)&0xfff;
	VV   = (Pixel)&0xfff;
	HH =640;
	VV =480;//for test
	SC030GS_SetPixle(HH,VV);
    Get_i1280720Reg(&IR_Pixel);
}
/**********************************************************
 *函数：获取CMOS寄存器地址
 ***********************************************************/
//unsigned int *Get_ComsRegAddr(unsigned char type)
//{
//	Image_Information();
//	if(type==0)
//		return IR_Pixel.regP;
//	if(type==1)
//		return IR_Pixel.regImagep;
//	if(type==2)
//		return IR_Pixel.regP2;
//	return 0;
//}
/**********************************************************
 *函数：void Get_ImagePixel(unsigned short *HH,unsigned short *VV,unsigned short *Channl,unsigned short *Ratep)
 *功能：获取图片像素信息和帧数
 ***********************************************************/
void Get_ImagePixel(unsigned short *HH,unsigned short *VV,unsigned short *Channl,unsigned short *Ratep)
{
	Image_Information();
	*HH=IR_Pixel.HH;
	*VV=IR_Pixel.VV;
	if(Channl)
	*Channl=IR_Pixel.channel;
	if(Ratep)
	*Ratep=IR_Pixel.Rate_Num;
}
