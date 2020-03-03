/***********************************************************************
 * 文件：Bsp_TwoCPU.C
 * 功能：2个CPU之间的通信代码
 ***********************************************************************/

#include "Bsp_TwoCPU.h"
//#include "Bsp_RGB_Samp.h"
#include "xil_mmu.h"
#include "string.h"
#include "xil_io.h"

 struct CPUTX_{
	 unsigned int CPU0CMD;
	 unsigned int CPU0USESTATS1;
	 unsigned int CPU0USESTATS2;
	 unsigned int CPU0USESTATS3;
	 unsigned int CPU0USESTATS4;
 }CPU0TX;
 struct Image_tj_{    //图片采样 统计结构
	 unsigned int RECUSE;
	 unsigned int BMPMAX;
	 unsigned int SNO;
 };
 struct Image_DDR_{    //图片采样保存位置信息
	 unsigned int DADDR;
	 unsigned int DADDRCS;
	 unsigned int TEMP;
	 unsigned int STATS;
 };
 struct CPU1TX_{
	 unsigned int CPU1CMD;
	 unsigned int DOBMPMAX ;
	 struct Image_tj_  ITJ[MAXLU];//每路的统计信息
	 struct Image_DDR_ IDDR[MAXLU][MAXDDRNUM];//图片采样保存位置信息
 }CPU1TX;

void Bsp_TwoCPU_Init(void)
{
	Xil_SetTlbAttributes(0xffff0000,0x14de2);
}
/*************************************************************************
* 函数：unsigned int Bsp_GetDDRBaseAddr(unsigned char Lu,unsigned char Kuai)
* 获取：每路信息首地址
* 入参：Lu 采样路 1~MAXLU   Kuai:DDR的块号  1~MAXDDRNUM
************************************************************************* */
unsigned int Bsp_GetDDRBaseAddr(unsigned char Lu,unsigned char Kuai)
{
	unsigned int Readdr;
	switch(Lu)
	{
		case 1:Readdr=D1DDRBASE;break;
#if MAXLU > 1
		case 2:Readdr=D2DDRBASE;break;
#endif

#if MAXLU > 2
		case 3:Readdr=D3DDRBASE;break;
#endif

#if MAXLU > 3
		case 4:Readdr=D4DDRBASE;break;
#endif
		default:return 0;
	}
	if(Kuai==0)return 0;
	if(Kuai>MAXDDRNUM)return 0;
	Readdr +=16*(Kuai-1);
	return Readdr;
}

/*************************************************************************
* 函数  void Bsp_GetCPU0TX(void)
* 获取： 读取CPU0 的通讯参数
************************************************************************* */
void Bsp_GetCPU0TX(void)
{
	CPU0TX.CPU0CMD=Xil_In32(CPU0CMDADDR);
	CPU0TX.CPU0USESTATS1=Xil_In32(USESTATS1ADDR);
	CPU0TX.CPU0USESTATS2=Xil_In32(USESTATS2ADDR);
	CPU0TX.CPU0USESTATS3=Xil_In32(USESTATS3ADDR);
	CPU0TX.CPU0USESTATS4=Xil_In32(USESTATS4ADDR);
}

/*************************************************************************
* 函数  unsigned int Bsp_ReadCPU0CMD(void)
* 获取： 读取CPU0发布的命令
************************************************************************* */
unsigned int Bsp_ReadCPU0CMD(void)
{
	CPU0TX.CPU0CMD=Xil_In32(CPU0CMDADDR);//获取CPU0的命令

	if(CPU0TX.CPU0CMD!=CPU1TX.CPU1CMD)//hui
	{
		CPU1TX.CPU1CMD=CPU0TX.CPU0CMD;
		Xil_Out32(CPU1CMDADDR,CPU1TX.CPU1CMD);
		return CPU1TX.CPU1CMD;

	}
	return 0;
}
/*************************************************************************
* 函数： unsigned int Bsp_ReadCPU0USESTATS(unsigned char Lu)
* 获取： 读取当前CPU0 正在使用哪块DDR
************************************************************************* */
unsigned int Bsp_ReadCPU0USESTATS(unsigned char Lu)
{
	 switch(Lu)
	 {
		 case 1:CPU0TX.CPU0USESTATS1=Xil_In32(USESTATS1ADDR);return CPU0TX.CPU0USESTATS1;
		 case 2:CPU0TX.CPU0USESTATS2=Xil_In32(USESTATS2ADDR);return CPU0TX.CPU0USESTATS2;
		 case 3:CPU0TX.CPU0USESTATS3=Xil_In32(USESTATS3ADDR);return CPU0TX.CPU0USESTATS3;
		 case 4:CPU0TX.CPU0USESTATS4=Xil_In32(USESTATS4ADDR);return CPU0TX.CPU0USESTATS4;
	 }
	 return 0;
}
 /*************************************************************************
* 函数  void Bsp_WriteCPU1SNO(unsigned char Lu,unsigned int SNO2)
* 获取：对应路采样的数据 统计
************************************************************************* */
void Bsp_WriteCPU1SNO(unsigned char Lu,unsigned int SNO2)
{
	switch(Lu)
	{
		case 1:CPU1TX.ITJ[0].SNO+=SNO2;Xil_Out32(SNO1ADDR,CPU1TX.ITJ[0].SNO);break;
		case 2:CPU1TX.ITJ[1].SNO+=SNO2;Xil_Out32(SNO2ADDR,CPU1TX.ITJ[1].SNO);break;
		case 3:CPU1TX.ITJ[2].SNO+=SNO2;Xil_Out32(SNO3ADDR,CPU1TX.ITJ[2].SNO);break;
		case 4:CPU1TX.ITJ[3].SNO+=SNO2;Xil_Out32(SNO4ADDR,CPU1TX.ITJ[3].SNO);break;
	}
	//xil_printf("--%d\r\n", CPU1TX.ITJ[0].SNO);
}
/*************************************************************************
* 函数  void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE)
* 获取： 当前采样路 正在使用哪块DDR保存数据
************************************************************************* */
void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE)
{
	switch(Lu)
	{
		case 1:CPU1TX.ITJ[0].RECUSE=RECUSE;Xil_Out32(RECUSE1ADDR,RECUSE);break;
		case 2:CPU1TX.ITJ[1].RECUSE=RECUSE;Xil_Out32(RECUSE2ADDR,RECUSE);break;
		case 3:CPU1TX.ITJ[2].RECUSE=RECUSE;Xil_Out32(RECUSE3ADDR,RECUSE);break;
		case 4:CPU1TX.ITJ[3].RECUSE=RECUSE;Xil_Out32(RECUSE4ADDR,RECUSE);break;
	}
}
/*************************************************************************
* 函数  void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE)
* 获取：写入每个通道保存的最大数 [保存几副图片--循环保存]
************************************************************************* */
void Bsp_WriteCPU1BMPMAX(unsigned char Lu,unsigned int BMPMAX)
{
	switch(Lu)
	{
		case 1:CPU1TX.ITJ[0].BMPMAX=BMPMAX;Xil_Out32(BMPMAX1ADDR,BMPMAX);break;
		case 2:CPU1TX.ITJ[1].BMPMAX=BMPMAX;Xil_Out32(BMPMAX2ADDR,BMPMAX);break;
		case 3:CPU1TX.ITJ[2].BMPMAX=BMPMAX;Xil_Out32(BMPMAX3ADDR,BMPMAX);break;
		case 4:CPU1TX.ITJ[3].BMPMAX=BMPMAX;Xil_Out32(BMPMAX4ADDR,BMPMAX);break;
	}
}
/*************************************************************************
* 函数：void Bsp_WriteCPU1DOBMPMAX (unsigned int DOBMPMAX )
* 获取：写入数据采样的路数
************************************************************************* */
void Bsp_WriteCPU1DOBMPMAX (unsigned int DOBMPMAX )
{
	CPU1TX.DOBMPMAX=DOBMPMAX;
	Xil_Out32(DOBMPMAXADDR,DOBMPMAX);
}
/*************************************************************************
* 函数：void Bsp_WriteCPU1CPU1CMD (unsigned int CPU1CMD )
* 获取：写入CPU1所执行过的命令
************************************************************************* */
void Bsp_WriteCPU1CPU1CMD (unsigned int CPU1CMD )
{
	CPU1TX.CPU1CMD=CPU1CMD;
	Xil_Out32(CPU1CMDADDR,CPU1CMD);
}
/*************************************************************************
* 函数：void Bsp_ReadCPU1CPU1CMD (unsigned int CPU1CMD )
* 获取：读取CPU1所执行过的命令
************************************************************************* */
unsigned int Bsp_ReadCPU1CPU1CMD (unsigned int CPU1CMD )
{
	CPU1TX.CPU1CMD=Xil_In32(CPU1CMDADDR);
	return  CPU1TX.CPU1CMD;
}
/*************************************************************************
* 函数：void Bsp_WriteCPU1LuDDR (unsigned char Lu,unsigned char Kuai,unsigned int addr )
* 功能：写入图片保存的地址
************************************************************************* */
void Bsp_WriteCPU1LuDDR (unsigned char Lu,unsigned char Kuai,unsigned int addr )
{
	unsigned int SaveAddr;
	SaveAddr=Bsp_GetDDRBaseAddr(Lu,Kuai);
	if(SaveAddr>0)
	{
		CPU1TX.IDDR[Lu-1][Kuai-1].DADDR=addr;
		CPU1TX.IDDR[Lu-1][Kuai-1].DADDRCS=0xffffffff-CPU1TX.IDDR[Lu-1][Kuai-1].DADDR;
		CPU1TX.IDDR[Lu-1][Kuai-1].TEMP=0;
		CPU1TX.IDDR[Lu-1][Kuai-1].STATS=0;
		Xil_Out32(SaveAddr+Doffse,    CPU1TX.IDDR[Lu-1][Kuai-1].DADDR);
		Xil_Out32(SaveAddr+DCSoffse,  CPU1TX.IDDR[Lu-1][Kuai-1].DADDRCS);
		Xil_Out32(SaveAddr+TEMPSoffse,CPU1TX.IDDR[Lu-1][Kuai-1].TEMP);
		Xil_Out32(SaveAddr+STATSoffse,CPU1TX.IDDR[Lu-1][Kuai-1].STATS);
	}
}
/*************************************************************************
* 函数：void Bsp_WriteCPU1STATS (unsigned char Lu,unsigned char Kuai,unsigned int stats )
* 功能：写入图片保存的地址状态
*      1->正在写入  2 ->写入完毕
************************************************************************* */
void Bsp_WriteCPU1STATS (unsigned char Lu,unsigned char Kuai,unsigned int stats )
{
	unsigned int SaveAddr;
	SaveAddr=Bsp_GetDDRBaseAddr(Lu,Kuai);
	if(SaveAddr>0)
	{
		CPU1TX.IDDR[Lu-1][Kuai-1].STATS=stats;
		Xil_Out32(SaveAddr+STATSoffse,CPU1TX.IDDR[Lu-1][Kuai-1].STATS);
	}
}


/****************************************************
 * unsigned char CPU0_NETEN(void)
 * CPU0,是否能控制NET DMA
 * 返回1，CPU0 控制 0：CPU1控制
 ****************************************************/
unsigned char CPU0_NETEN(void)
{
	if(0xa5a5!=Xil_In32(CPU1CMD_NETEN))return 1;
	return 0;
}
/****************************************************
 * int CPUO_NETtxCMD(void)
 * CPU0通知CPU1，有数据需要发送

 ****************************************************/
void CPUO_NETtxCMD(void)
{
	Xil_Out32(CPU0CMD_NETTX,Xil_In32(CPU0CMD_NETTX)+1);
}
