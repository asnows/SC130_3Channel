/***********************************************
 * 与2个CPU之间的通讯，采用RAM方式

 * 基地址0xffff0000
 * 写入：Xil_Out32
 * 读取 ：Xil_In32
 * 分配表：
 * -----------------图像数据搬运消息区---------------------------begin
 *
 * -----------------------CPU0写入区域-------------------------------Begin
 *  64*4
 *
 *  Vaid   0~3       --> 有效CPU0 写入，4~7 为接收缓冲的地址
 *  D1     4~7       --> 接收缓冲的地址   -->
 *  D2     8~11      --> 接收缓冲的验证   --> D1+D2 =0xFFFFFFFF
 *  USE    12~15     --> 1->数据正在读出，       2->数据已经读出完毕   指定的DDR位置【D1】可以被CPU1放入数据
 *  SNO              --> RGB序号 (SNO2 !=SNO)&&(USE2==2) 开始搬运 搬运完毕SNO=SNO2
 *  -----------------------CPU0写入区域-------------------------------end
 *
 *  -----------------------CPU1写入区域-------------------------------Begin
 *  64*4
 *  Err    0~3       --> 通知CPU0 产生错误，如D1+D2 校验错误
 *  USE2   4~7       --> 1 ->数据正在写入D1,2->数据已经写入完毕 CPU0可以搬运
 *  SNO2             --> RGB序号  累加+1
 *  LEN              --> RGB的长度
 *  VV               --> RGB的线数                   竖
 *  HH               --> RGB的线上像素 数量  横
 *  -----------------------CPU1写入区域-------------------------------End
 * 工作流程：
 * CPU0初始化工作
 *    开辟缓冲：用来存放图片  并把地址放入D1,D2=0xFFFFFFFF-D1 写        Vaid=0x55555555  USE=2
 * CPU1写入工作
 * 	  1、    Vaid=0x55555555    USE!=0      地址有效性检查
 * 	  2   USE2=1 搬运数据
 * 	  3   SNO2++，USE2=2
 * CPU0读取数据工作
 *   1、     USE2=2、SNO2!=SNO Err=0  地址有效性检查
 *   2   USE=1，搬运数据， SNO=SNO2 USE=2
 *   3
 * 地址有效性检查 失败处理
 *      需要重新初始化
 ***********************************************/
//#include "Bsp_TwoCPU.h"
#ifndef BSP_TWOCPU_H_
#define BSP_TWOCPU_H_
#include "Bsp_RGB_Samp.h"
#define MAXLU         1   //定义采样路数
#define MAXDDRNUM     8   //定义DDR存放路数  Bsp_RGB_Samp.h中定义

#define CPU0TXBASE          0xffff0000
#define CPU0CMDADDR         (CPU0TXBASE+0)
#define USESTATS1ADDR 		(CPU0TXBASE+16*4)    //
#define USESTATS2ADDR 		(CPU0TXBASE+16*4*2)
#define USESTATS3ADDR 		(CPU0TXBASE+16*4*3)
#define USESTATS4ADDR       (CPU0TXBASE+16*4*4)

//#define READ_REG_ADDR (CPU0TXBASE+16*4*5)//定义该区间用来表示：上位机需要读取寄存器的值时放置需要读取的寄存器的值,（暂时不需要分配，使用原来分配的放置配置数据的信息区的前2个字节，根据命令通知来）


#define SENSORADDR           (CPU0TXBASE+128*4)
#define SENSORLEN            (64*4)

#define FGPAADDR             (SENSORADDR+SENSORLEN)
#define FGPALEN              (8*32)

#define NETCONTROL           (CPU0TXBASE+0x0ff8)
#define CPU1CMD_NETEN        NETCONTROL
#define CPU0CMD_NETTX        (NETCONTROL+4)

//---------------------------------------CPU1 写区域----------------------Begin
#define CPU1TXBASE      (0xffff1000)
#define D1DDRBASE       (0xffff1000 + 128*4)
#define D2DDRBASE       (0xffff1000 + 128*4*2)
#define D3DDRBASE       (0xffff1000 + 128*4*3)
#define D4DDRBASE       (0xffff1000 + 128*4*4)

#define READ_DATA_ADDR (0xffff1000 + 128*4*5)//定义读取reg数据的存放区域，有必要申请，通过命令通知cpu0

//-----------------------信息区----------------------Begin
#define CPU1CMDADDR 	(CPU1TXBASE+0)
#define	DOBMPMAXADDR    (CPU1TXBASE+4)

#define FSignBASE       (CPU1TXBASE+16*4)
#define SSignBASE       (CPU1TXBASE+16*4*2)
#define TSignBASE       (CPU1TXBASE+16*4*3)
#define LSignBASE       (CPU1TXBASE+16*4*4)

#define RECUSE1ADDR    (FSignBASE+0)
#define BMPMAX1ADDR    (FSignBASE+4)
#define SNO1ADDR       (FSignBASE+8)


#define RECUSE2ADDR    (SSignBASE+0)
#define BMPMAX2ADDR    (SSignBASE+4)
#define SNO2ADDR       (SSignBASE+8)


#define RECUSE3ADDR    (TSignBASE+0)
#define BMPMAX3ADDR    (TSignBASE+4)
#define SNO3ADDR       (TSignBASE+8)


#define RECUSE4ADDR    (LSignBASE+0)
#define BMPMAX4ADDR    (LSignBASE+4)
#define SNO4ADDR       (LSignBASE+8)
//-----------------------信息区----------------------End
#define Doffse         0
#define DCSoffse       4
#define TEMPSoffse     8
#define STATSoffse     12
//  需要通过函数 计算 实际的物理地址

//---------------------------------------CPU1 写区域----------------------End

extern void Bsp_TwoCPU_Init(void);
/*************************************************************************
* 函数：unsigned int Bsp_GetDDRBaseAddr(unsigned char Lu,unsigned char Kuai)
* 获取：每路信息首地址
* 入参：Lu 采样路 1~MAXLU   Kuai:DDR的块号  1~MAXDDRNUM
************************************************************************* */
extern unsigned int Bsp_GetDDRBaseAddr(unsigned char Lu,unsigned char Kuai);

/*************************************************************************
* 函数  void Bsp_GetCPU0TX(void)
* 获取： 读取CPU0 的通讯参数
************************************************************************* */
extern void Bsp_GetCPU0TX(void);

/*************************************************************************
* 函数  unsigned int Bsp_ReadCPU0CMD(void)
* 获取： 读取CPU发布的命令
************************************************************************* */
extern unsigned int Bsp_ReadCPU0CMD(void);
/*************************************************************************
* 函数： unsigned int Bsp_ReadCPU0USESTATS(unsigned char Lu)
* 获取： 读取当前CPU0 正在使用哪块DDR
************************************************************************* */
extern unsigned int Bsp_ReadCPU0USESTATS(unsigned char Lu);
 /*************************************************************************
* 函数  void Bsp_WriteCPU1SNO(unsigned char Lu,unsigned int SNO2)
* 获取：对应路采样的数据 统计
************************************************************************* */
extern void Bsp_WriteCPU1SNO(unsigned char Lu,unsigned int SNO2);
/*************************************************************************
* 函数  void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE)
* 获取：对应路采样的当前采样数据通道号
************************************************************************* */
extern void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE);
/*************************************************************************
* 函数  void Bsp_WriteCPU1RECUSE(unsigned char Lu,unsigned int RECUSE)
* 获取：写入每个通道保存的最大数
************************************************************************* */
extern void Bsp_WriteCPU1BMPMAX(unsigned char Lu,unsigned int BMPMAX);
/*************************************************************************
* 函数：void Bsp_WriteCPU1DOBMPMAX (unsigned int DOBMPMAX )
* 获取：写入数据采样的路数
************************************************************************* */
extern void Bsp_WriteCPU1DOBMPMAX (unsigned int DOBMPMAX );
/*************************************************************************
* 函数：void Bsp_WriteCPU1CPU1CMD (unsigned int CPU1CMD )
* 获取：写入CPU1所执行过的命令
************************************************************************* */
extern void Bsp_WriteCPU1CPU1CMD (unsigned int CPU1CMD );
/*************************************************************************
* 函数：void Bsp_ReadCPU1CPU1CMD (unsigned int CPU1CMD )
* 获取：读取CPU1所执行过的命令
************************************************************************* */
extern unsigned int Bsp_ReadCPU1CPU1CMD (unsigned int CPU1CMD );
/*************************************************************************
* 函数：void Bsp_WriteCPU1LuDDR (unsigned char Lu,unsigned char Kuai,unsigned int addr )
* 功能：写入图片保存的地址
************************************************************************* */
extern void Bsp_WriteCPU1LuDDR (unsigned char Lu,unsigned char Kuai,unsigned int addr );
/*************************************************************************
* 函数：void Bsp_WriteCPU1STATS (unsigned char Lu,unsigned char Kuai,unsigned int stats )
* 功能：写入图片保存的地址状态
*      1->正在写入  2 ->写入完毕
************************************************************************* */
extern void Bsp_WriteCPU1STATS (unsigned char Lu,unsigned char Kuai,unsigned int stats );
/*获取cpu0正在读取的帧号，以便通知pl跳过*/
extern unsigned int get_cpu0_using_frame(void);
#endif
