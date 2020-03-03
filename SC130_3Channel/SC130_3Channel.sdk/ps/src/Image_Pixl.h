
extern void Get_ImagePixel(unsigned short *HH,unsigned short *VV,unsigned short *Channl,unsigned short *Ratep);

unsigned int          *Get_ComsRegAddr(unsigned char type);

struct Image_Reg
{
		unsigned int *regP;//
		unsigned int *regImagep;
		unsigned int *regP2;//
		unsigned short HH;
		unsigned short VV;
		unsigned short channel;
		unsigned short Rate_Num;
};
