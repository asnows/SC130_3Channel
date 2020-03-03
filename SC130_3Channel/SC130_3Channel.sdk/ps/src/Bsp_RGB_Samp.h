// #include "Bsp_RGB_Samp.h"
#ifndef BSP_RGB_SAMP_H_
#define BSP_RGB_SAMP_H_

#define MAXLU           1   //定义采样路数
#define MAXDDRNUM       4
#define MAXRGBHORISIZE  1920    //支持的最大 横点数
#define MAXRGBVERTSIZE  1280     //支持的最大 竖线数
#define ONERGBBUUFLEN   (MAXRGBHORISIZE * MAXRGBVERTSIZE * 4 + 0x800)  //1个图片的RGB需要的缓冲 每张图片多2K
#define RGBBUFFLEN      ((ONERGBBUUFLEN *MAXDDRNUM+0x100000) & 0xFFF00000)//RGB需要存放需要的缓冲大小 最小单位1M 8幅+1M大小

/************************************************************************************************
 * 函数，void Bsp_RGBBuff_Init()
 * 功能：初始化Buff,修改属性 这样PL和2个CPU都可以读取
 ************************************************************************************************/
extern void Bsp_RGBBuff_Init(void);
/************************************************************************************************
 * 函数，void Bsp_GetpFrames(unsigned char **OutP,unsigned char Num)
 * 功能： 为每帧RGB图片申请对应的缓冲指针
 * 入参：**OutP 输入保存指针的指针 H: 横像素，V 竖 线数  Num 帧个数
 * 注意    H<=MAXRGBHORISIZE    否则错误1
 *     V<=MAXRGBVERTSIZE    否则错误2
 *     Num 取值 1-32          否则错误3
 ************************************************************************************************/
extern unsigned char Bsp_RGB_GetpFrames(unsigned int **OutP,unsigned int H,unsigned int V,unsigned char Num);
/************************************************************************************************
 * 函数，unsigned char * Bsp_ScanvaildFrame(void)
 * 功能：  搜索有效的帧  1ms 之内调用一次
 * 返回值：返回有效的数据帧存放
 ************************************************************************************************/
extern unsigned char * Bsp_RGB_ScanvaildFrame(void);
extern unsigned char Bsp_RGB_ScanvaildFrameIndex(void);
/************************************************************************************************
 * 函数，void Bsp_RGB_FrameToCPU0(unsigned char *InBuff)
 * 功能：  将接收到数据搬运到CPU0指定的DDR中
 * 返回值：
 ************************************************************************************************/
extern void Bsp_RGB_FrameToCPU0(unsigned char InDex);
extern unsigned char *Bsp_RGB_GetFrameP(unsigned char index);
extern unsigned int Bsp_RGB_GetFrameAddr(unsigned char index);
#endif
