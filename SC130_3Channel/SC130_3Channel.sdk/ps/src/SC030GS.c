#include "psiic.h"
#include "xstatus.h"
#include "xpseudo_asm_gcc.h"
#include "Image_Pixl.h"
#define MAX_WIDTH  640
#define MAX_HEIGHT 480
#define MID_WIDTH  (MAX_WIDTH/2+4)    //像素中心点的位置
#define MID_HEIGHT (MAX_HEIGHT/2+4)  //像素中心点的位置
#define SC130GS
//#define SC030GS

static unsigned short SC030GC_HH;
static unsigned short SC030GC_VV;
static unsigned short SC030GC_channel;
static unsigned int SC030GC[]=
{
#ifdef SC030GS
	0x01000000,
	0x3018001f,
	0x301900ff,
	0x301c00b4,
	0x30220010,
	0x302b0080,
	0x30300004,
	0x3031000a,
	0x30340029,
	0x3035002a,
	0x30380044,
	0x30390033,
	0x303a0077,
	0x303b0005,
	0x303c0004,
	0x303f0091,
	0x32000001,
	0x320100b8,
	0x32020000,
	0x32030088,
	0x32040004,
	0x32050047,
	0x32060001,
	0x3207007b,
	0x32080002,//
	0x32090080,//
	0x320a0001,//
	0x320b00e0,//
	0x320c0002,
	0x320d00ee,
	0x320e0001,
	0x320f000e,
	0x32110004,//
	0x32130004,//
	0x322f009f,
	0x33000020,
	0x3302000c,
	0x33060048,
	0x33080050,
	0x330a0000,
	0x330b008c,
	0x330e001a,
	0x331000f0,
	0x33110010,
	0x331900e8,
	0x33330090,
	0x33340030,
	0x33480002,
	0x334900ee,
	0x334a0002,
	0x334b00e8,
	0x335d0000,
	0x338000ff,
	0x338200e0,
	0x3383000a,
	0x338400e4,
	0x34000053,
	0x34160031,
	0x35180007,
	0x351900c8,
	0x36200023,
	0x3621000a,
	0x36220006,
	0x36230014,
	0x36240040,
	0x36250000,
	0x36260000,
	0x36270001,
	0x36300063,
	0x36320074,
	0x36330063,
	0x363400ff,
	0x36350044,
	0x36380082,
	0x36390074,
	0x363a0024,
	0x363b0000,
	0x36400002,
	0x3658009a,
	0x36630088,
	0x36640007,
	0x3c000045,
	0x3d080000,
	0x3e01001a,
	0x3e020000,
	0x3e03000b,
	0x3e080003,
	0x3e090020,
	0x3e0e0000,
	0x3e0f0014,
	0x3e1400b0,
	0x3f080004,
	//0x450100c0,
	0x450100c8,//incremental pattern
	0x45020016,
	0x50000001,
	0x50400080,//color bar enable
	0x5b000002,
	0x5b010003,
	0x5b020001,
	0x5b030001,


//	/*****************/

	0x320c0002,  //1514x1070
	0x320d00f4,
	0x320e0002,
	0x320f0017,

	0x3205008b, //xaddr end
	0x32020000, //yaddr strat 0
	0x32030000,
	0x32060002, //yaddr end  1032  1034 rows selected
	0x32070004,

	0x32080005,//
	0x32090000,//
	0x320a0004, //1024 rows output
	0x320b0000,
//
//	0x30340001,
//	0x303500d2,
//	0x303a0010,
//
//
//	0x3e010021,
//	0x3e020050,
//	/*********************/

	0x01000001,
	0xffff0000
#endif

#ifdef SC130GS


		//0x01030001,
		0x01000000,
		0x3018001f,
		0x301900ff,
		0x301c00b4,
		0x30220010,
		0x302b0080,
		0x30300004,
		0x3031000a,
		0x30340029,
		0x3035002a,
		0x30380044,
		0x30390033,
		0x303a0077,
		0x303b0005,
		0x303c0004,
		0x303f0091,
		0x32020000,
		0x32030000,
		0x3205008b,
		0x32060002,
		0x32070004,
		0x320a0004,
		0x320b0000,
		0x320c0002,
		0x320d00ee,
		0x320e0002,
		0x320f001c,
		0x3211000c,
		0x32130004,
		0x33000020,
		0x3302000c,
		0x33060048,
		0x33080050,
		0x330a0000,
		0x330b008c,
		0x330e001a,
		0x331000f0,
		0x33110010,
		0x331900e8,
		0x33330090,
		0x33340030,
		0x33480002,
		0x334900ee,
		0x334a0002,
		0x334b00e8,
		0x335d0000,
		0x338000ff,
		0x338200e0,
		0x3383000a,
		0x338400e4,
		0x34000053,
		0x34160031,
		0x35180007,
		0x351900c8,
		0x36200023,
		0x3621000a,
		0x36220006,
		0x36230014,
		0x36240040,
		0x36250000,
		0x36260000,
		0x36270001,
		0x36300063,
		0x36320074,
		0x36330063,
		0x363400ff,
		0x36350044,
		0x36380082,
		0x36390074,
		0x363a0024,
		0x363b0000,
		0x36400002,
		0x3658009a,
		0x36630088,
		0x36640007,
		0x3c000045,
		0x3d080000,
		0x3e01001a,
		0x3e020000,
		0x3e03000b,
		0x3e080003,
		0x3e090020,
		0x3e0e0000,
		0x3e0f0014,
		0x3e1400b0,
		0x3f080004,
		0x450100c0,
		0x45020016,
		0x50000001,
		0x5b000002,
		0x5b010003,
		0x5b020001,
		0x5b030001,
		0x01000001,
//		[gain<4]
//		0x363a0024,
//		0x36300063,
//		[gain>=4]
//		0x363a0064,
//		0x36300073,

		0xffff0000





#endif




};








/*************************************************************
 * 默认配置：1280*720*30
 ****************************************************************/
static unsigned int SC030GC_iRate[11]=
{
		0x01000000,
		0x32120000,
		0x32130004,
		0x32100000,
		0x32110004,
//640*480
//		0x32080002,
//		0x32090080,
//		0x320a0001,
//		0x320b00e0,
//		0x01000001,
//		0xFFFF0000


//1280*1024
		0x32080005,
		0x32090000,
		0x320a0004,
		0x320b0000,
		0x01000001,
		0xFFFF0000



};

/*************************************************************************************
 *函数：unsigned int *SC030GS_SetPixle(unsigned short HH,unsigned short VV)
 *功能：设置像素值 以最大的窗体为中心设定像素
 *计算：设置像素框体，涉及到8个寄存器组
                            高8位    低8位
              行起始：0x3212,0x3213
              列起始：0x3210,0x3211
              宽度：   0x3208,0x3209
              高度：   0x320a,0x320b
        HH 必须4字节对齐
 *************************************************************************************/
unsigned int *SC030GS_SetPixle(unsigned short HH,unsigned short VV)
{


		unsigned short sop;
		if(HH<240)HH=MAX_WIDTH;
		if(HH>MAX_WIDTH)HH=MAX_WIDTH;
		if(VV<240)VV=MAX_HEIGHT;
		if(VV>MAX_HEIGHT)VV=MAX_HEIGHT;
		HH &=0xfffc;//必须4字节对其
		SC030GC_HH=HH;
		SC030GC_VV=VV;
		SC030GC_channel=1;


		HH>>=1;
		VV>>=1;
		sop=MID_WIDTH-HH;//行起始点
		SC030GC_iRate[1]=((sop>>8)|(0x3212<<16));//行 起始点 高8位
		SC030GC_iRate[2]=((sop&0xff)|(0x3213<<16));//行 起始点 低八位
		sop=MID_HEIGHT-VV;//列起始点
		SC030GC_iRate[3]=((sop>>8)|(0x3210<<16));//列 起始点 高8位
		SC030GC_iRate[4]=((sop&0xff)|(0x3211<<16));//列 起始点 低八位

		sop=SC030GC_HH;//窗口的宽度
		SC030GC_iRate[5]=((sop>>8)|(0x3208<<16));  //窗口的宽度 高8位
        SC030GC_iRate[6]=((sop&0xff)|(0x3209<<16));//窗口的宽度 低八位

        sop=SC030GC_VV;//窗口的高度
    	SC030GC_iRate[7]=((sop>>8)|(0x320a<<16));  //窗口的宽度 高8位
        SC030GC_iRate[8]=((sop&0xff)|(0x320b<<16));//窗口的宽度 低八位

		return 0;
}
/*************************************************************************************
 *函数：unsigned int *SC030GS_CreateWindows(unsigned short H_start,unsigned short W_start, unsigned short H_Len,unsigned short W_Len)
 *功能：创建输出窗体
 *计算：
              行起始：0x3212,0x3213
              列起始：0x3210,0x3211
              宽度：   0x3208,0x3209
              高度：   0x320a,0x320b
        HH 必须4字节对齐
        H_start:行起始位置， 必须>=4 且4的倍数
        W_start 列起始位置， 必须>=4
        H_Len ：行        4的倍数、
        W_Len： 列
 *************************************************************************************/
unsigned int *SC030GS_CreateWindows(unsigned short H_start,unsigned short W_start, unsigned short HH,unsigned short VV)
{

		unsigned short sop;
		if(HH<240)HH=MAX_WIDTH;
		if(HH>MAX_WIDTH)HH=MAX_WIDTH;
		if(VV<240)VV=MAX_HEIGHT;
		if(VV>MAX_HEIGHT)VV=MAX_HEIGHT;
		H_start &=0xfffc;
		if(H_start<4)H_start=4;

		HH &=0xfffc;//必须4字节对其
		SC030GC_HH=HH;
		SC030GC_VV=VV;
		SC030GC_channel=1;
		sop=MID_WIDTH-HH;//行起始点
		SC030GC_iRate[1]=((H_start>>8)|(0x3212<<16));//行 起始点 高8位
		SC030GC_iRate[2]=((H_start&0xff)|(0x3213<<16));//行 起始点 低八位
		sop=MID_HEIGHT-VV;//列起始点
		SC030GC_iRate[3]=((W_start>>8)|(0x3210<<16));//列 起始点 高8位
		SC030GC_iRate[4]=((W_start&0xff)|(0x3211<<16));//列 起始点 低八位

		sop=HH;//窗口的宽度
		SC030GC_iRate[5]=((sop>>8)|(0x3208<<16));  //窗口的宽度 高8位
        SC030GC_iRate[6]=((sop&0xff)|(0x3209<<16));//窗口的宽度 低八位

        sop=VV;//窗口的高度
    	SC030GC_iRate[7]=((sop>>8)|(0x320a<<16));  //窗口的宽度 高8位
        SC030GC_iRate[8]=((sop&0xff)|(0x320b<<16));//窗口的宽度 低八位
        return 0;

}
/*************************************************************************************
 *函数：int SC030GS_Read(u16 addr,u8 *read_buf)
 *功能：读取SC030GS寄存器数据
 *入参：addr     SC030GS寄存器的地址
 *      read_buf 读取数据对应存放，一个寄存器对应1个字节的数据
 *返回值：XST_SUCCESS 成功
 *************************************************************************************/
static int SC030GS_Read(u16 addr,u8 *read_buf)
{
	u8 buf[2];
	buf[0] = (addr >> 8);
	buf[1] = addr;
	if(i2c_wrtie_bytes(0x60,buf,2) != XST_SUCCESS)//0x60
		return XST_FAILURE;
	if(i2c_read_bytes(0x61,read_buf,1) != XST_SUCCESS)//
			return XST_FAILURE;
	return XST_SUCCESS;
}
/*************************************************************************************
 *函数：int SC030GS_Write(u16 addr,u8 data)
 *功能：写SC030GS寄存器数据
 *入参：addr     SC030GS寄存器的地址
 *      data     要写入的值
 *返回值：XST_SUCCESS 成功
 *************************************************************************************/
static int SC030GS_Write( u16 Regaddr,u8 data)
{
	u8  buf[4];

	buf[0] = Regaddr >> 8;
	buf[1] = Regaddr & 0xFF;
	buf[2] = data;
	if(i2c_wrtie_bytes(0x60,buf,3) != XST_SUCCESS)
		return XST_FAILURE;
	return XST_SUCCESS;
}
/*************************************************************************************
 *函数：unsigned char SetSCReg(unsigned int V)
 *功能：写SC030GS寄存器数据，
 *入参：V 高16位 为寄存器的地址
 *        低8位  为寄存器的值
 *      当寄存器地址=FFFF时，认为一组数据写入完毕了
 *返回值：XST_SUCCESS 成功
 *************************************************************************************/
static unsigned char SetSCReg(unsigned int V)
{
		unsigned short reg;
		unsigned char data;
		reg= (unsigned short)((V >>16)&0xffff);
		data= (unsigned short)((V )&0xff);
		if(reg==0xffff)return 0xff;//设置完成
		if(reg==0x0000)return 1;//没有参数
		if(XST_SUCCESS!=SC030GS_Write(reg, data))
		{
			return 2;//
		}
		return 0;
}


int SC030GS_init(void)
{
	unsigned int *MorenRegAddr;
	unsigned short i;
	unsigned int org;
	unsigned char status;
	unsigned int lev;
    unsigned char value;

	lev = mfcpsr();
	mtcpsr(lev | 0x000000C0);
	//---------------------------------
	SC030GS_Read(0x302b,&value);
	xil_printf("value = %x \r\n",value);
	//---------------------------------

	SC030GS_Write(0x302b, 0x80);
	SC030GS_Read(0x302b,&value);
	if(value!=0x80)while(1);
	//i2c_init(&IicInstance, 0,100000);
#if 1
	i=0;
	while(1)//配置参数1
	{
		if(SetSCReg(SC030GC[i++]))
			break;

	}
	/*
	i=0;
	while(1)//配置参数2
	{
		if(SetSCReg(SC030GC_iRate[i++]))
			break;

	}*/
#endif
	 mtcpsr(lev);

	return 0;
}

void Get_i1280720Reg(struct Image_Reg *IRP)
{
	IRP->regP=SC030GC;
	IRP->regImagep=SC030GC_iRate;
	IRP->regP2=0;
	IRP->HH=SC030GC_HH;
	IRP->VV=SC030GC_VV;
	IRP->channel=SC030GC_channel;

}

