/**************************************************************************************************
 * 文件：Bsp_RGB_Samp.c
 * 功能：对RGB数据进行采样，并与CPU1进行数据交换
 * 	   1、开辟32帧存放RGB数据的空间
 *************************************************************************************************/
#include "Bsp_RGB_Samp.h"
#include "xil_mmu.h"
#include "string.h"
typedef struct RGBSamp_
{
	unsigned int *Framesp[MAXDDRNUM];
	unsigned char FrmaeNum;
}RGBSampstr;

#define RGBBuff  (0x1EE00000-8*0x1000000)

//unsigned char RGBBuff[RGBBUFFLEN] __attribute__ ((aligned (0x100000)));
RGBSampstr RGBSamp;
/************************************************************************************************
 * 函数，void Bsp_RGBBuff_Init()
 * 功能：初始化Buff,修改属性 这样PL和2个CPU都可以读取
 ************************************************************************************************/
void Bsp_RGBBuff_Init(void)
{
	unsigned int i;
	signed int addr;
	addr = (signed int)RGBBuff;
	//i=RGBBUFFLEN;
	//i&=0xfff00000;  //确保i是0x10000的倍数
	//if (i==0)return ;
	i=128;
	while(i--)
	{
		Xil_SetTlbAttributes((signed int)addr, 0xc02); // addr, attr
		addr = addr + 0x100000;
		//i = i-0x100000;
	}
	for (i=0;i<MAXDDRNUM ;i++)
	{
		RGBSamp.Framesp[i]=0;
	}
}
/************************************************************************************************
 * 函数，void Bsp_GetpFrames(unsigned char **OutP,unsigned char Num)
 * 功能： 为每帧RGB图片申请对应的缓冲指针
 * 入参：**OutP 输入保存指针的指针 H: 横像素，V 竖 线数  Num 帧个数
 * 注意    H<=MAXRGBHORISIZE    否则错误1
 *     V<=MAXRGBVERTSIZE    否则错误2
 *     Num 取值 1-32          否则错误3
 ************************************************************************************************/
unsigned char Bsp_RGB_GetpFrames(unsigned int **OutP,unsigned int H,unsigned int V,unsigned char Num)
{
		unsigned int L;
		unsigned int addr;
		unsigned int fristaddr;
		unsigned char i;

		if (H>MAXRGBHORISIZE)return  1;
		if (V>MAXRGBVERTSIZE)return  2;
		if((Num>MAXDDRNUM)||(Num==0))return  3;

		L= H *V *1;//一帧RGB占用的Buff 数
		L =L & 0xFFFFFFF0;//16字对齐
		L= L + 0x800;//每张图片增加2K的空间，用于保存其他信息
		//L = L+0x100000;//1M
		//L = L&0xfffE0000;//1M对其
		fristaddr = (unsigned int)RGBBuff +0x800;//偏移2K
		for(i=0;i<Num;i++)
		{
			addr =fristaddr+i*L;

			*OutP=addr;
			RGBSamp.Framesp[i]=(unsigned char*) addr;
			OutP +=1;
		}
		RGBSamp.FrmaeNum=Num;
		return 0;
}

