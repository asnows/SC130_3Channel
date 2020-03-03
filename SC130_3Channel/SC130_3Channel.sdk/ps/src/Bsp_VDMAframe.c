#include "xparameters.h"
#include "xil_io.h"
#include  "Bsp_VDMAframe.h"

#define    VDMACONTROLIOADDR     XPAR_AXI_GPIO_0_BASEADDR   //vdma buffer IO
#define    GPIO2_DATA_ADDR       (VDMACONTROLIOADDR+0)
#define    GPIO2_TRI_ADDR        (VDMACONTROLIOADDR+4)

#define    GPIO1_DATA_ADDR       (VDMACONTROLIOADDR+8)
#define    GPIO1_TRI_ADDR        (VDMACONTROLIOADDR+12)

const unsigned char GrayCode[16]=
{
		0,1,3,2,7,6,4,5,
		7,6,4,5,0,1,3,2
};
const unsigned char FANGrayCode[8]=
{
		0,1,3,2,6,7,5,4,
};
/********************************************************************
 * 函数：void Bsp_VDMAframe_init(void)
 * 功能：配置IO引脚
 *********************************************************************/
void Bsp_VDMAframe_init(void)
{
	Xil_Out32(GPIO1_TRI_ADDR,0x3f);       // 1配置为输入
	//Xil_Out32(GPIO1_DATA_ADDR,0x8);    //
	Xil_Out32(GPIO2_TRI_ADDR,0);    // 2 配置为输入
}
/********************************************************************
 * 函数：unsigned char Bsp_GetGrayCode(unsigned char sno)
 * 功能：解读帧号
 *********************************************************************/
unsigned char Bsp_GetGrayCode(unsigned char sno)
{
	return GrayCode[sno];
}
/********************************************************************
 * 函数：unsigned int Bsp_ReadfreamSno(void)
 * 功能：读取当前的正在处理的帧号
 *********************************************************************/
unsigned int Bsp_ReadfreamSno(void)
{
	unsigned int re;
	re=Xil_In32(GPIO1_DATA_ADDR);
	re = re&0x0f;
	//return GrayCode[re];
	return re;
}


/********************************************************************
 * 函数：void Bsp_SetSkipfreamSno(unsigned char Sno)
 * 功能：设置需要跳过的帧序号
 * 参入：Sno  0 关闭通道过滤  1~8 对应通道过滤
 *********************************************************************/
void Bsp_SetSkipfreamSno(unsigned char Sno )
{
	//Sno--;
	Sno &=0xf;
	Xil_Out32(GPIO2_DATA_ADDR, Sno);   //
	//Xil_Out32(GPIO1_DATA_ADDR,FANGrayCode[Sno&7]);   //
}
/*该函数读取cpu0正在读取的帧，然后将该帧号通知pl，跳过该帧
 *
 * */
unsigned int get_cpu0_using_frame(void)
{

	unsigned int frame_no;
	frame_no = Bsp_ReadfreamSno();
	Bsp_SetSkipfreamSno(frame_no);
	return frame_no;
}
