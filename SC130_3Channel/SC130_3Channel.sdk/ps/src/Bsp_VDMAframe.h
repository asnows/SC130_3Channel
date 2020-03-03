//#include  "Bsp_VDMAframe.h"
#ifndef BSP_VDMAFRAME_H_
#define BSP_VDMAFRAME_H_
/********************************************************************
 * 函数：void Bsp_VDMAframe_init(void)
 * 功能：配置IO引脚
 *********************************************************************/
extern void Bsp_VDMAframe_init(void);
/********************************************************************
 * 函数：unsigned int Bsp_ReadfreamSno(void)
 * 功能：读取当前的正在处理的帧号
 *********************************************************************/
extern unsigned int Bsp_ReadfreamSno(void);
/********************************************************************
 * 函数：void Bsp_SetSkipfreamSno(unsigned char Sno)
 * 功能：设置需要跳过的帧序号
 * 参入：Sno  0 关闭通道过滤  1~8 对应通道过滤
 *********************************************************************/
extern void Bsp_SetSkipfreamSno(unsigned char Sno);
extern void Bsp_FPGAReset_init(void);
extern void Bsp_FPGAReset(void);
unsigned char Bsp_GetGrayCode(unsigned char sno);
#endif
