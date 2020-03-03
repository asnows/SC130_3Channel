/*
 * get_image.h
 *
 *  Created on: 2018Äê1ÔÂ5ÈÕ
 *      Author: q
 */

#ifndef GET_IMAGE_H_
#define GET_IMAGE_H_

#include <stdio.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"


#include <stdlib.h>
#include <ctype.h>

#include "Bsp_TwoCPU.h"

#include "Bsp_RGB_Samp.h"

#define DEMO_MAX_FRAME (1280*720*3)
#define DEMO_STRIDE (1280*3)
#define DISPLAY_NUM_FRAMES 3

#define WIDTH 1280*3
#define VERTICAL 720
#define STRIDE 1280*3
#define MAX_FRAME   4
#define BMP_HEAD_LEN 54
#define USE_PATH 1
#endif /* GET_IMAGE_H_ */
