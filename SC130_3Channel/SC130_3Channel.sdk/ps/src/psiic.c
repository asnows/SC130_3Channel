#include "xiicps.h"
#include "xparameters.h"
#define IIC_DEVICE_ID  XPAR_XIICPS_0_DEVICE_ID
XIicPs IicInstance;
unsigned char IIC_valid;
int i2c_init(XIicPs *IicInstance, u16 DeviceId, u32 FsclHz)
{
	int Status;
	XIicPs_Config *ConfigPtr;	/* Pointer to configuration data */

	/*
	 * Initialize the IIC driver so that it is ready to use.
	 */
	ConfigPtr = XIicPs_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		return XST_FAILURE;
	}

	Status = XIicPs_CfgInitialize(IicInstance, ConfigPtr,
					ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Set the IIC serial clock rate.
	 */
	XIicPs_SetSClk(IicInstance, FsclHz);
	IIC_valid=0x55;
	return XST_SUCCESS;
}

int i2c_wrtie_bytes(u8 i2c_slave_addr,void *buf,int byte_num)
{
	    int Status;
        int Delay;
		/*
		 * Send the Data.
		 */
        if(IIC_valid!=0x55)
        {
        	i2c_init(&IicInstance, IIC_DEVICE_ID,100000);
        }
        Delay=100000;
		Status = XIicPs_MasterSendPolled(&IicInstance, buf,byte_num, i2c_slave_addr>>1 );  //i2c_slave_addr >> 1 ???
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

		/*
		 * Wait until bus is idle to start another transfer.
		 */
		while (XIicPs_BusIsBusy(&IicInstance))
		{
			Delay--;
			usleep(1);
			if(Delay==0)return XST_FAILURE;//
		}


		/*
		 * Wait for a bit of time to allow the programming to complete
		 */
		usleep(2500);


		return XST_SUCCESS;
}

int i2c_read_bytes(u8 i2c_slave_addr,void *buf,int byte_num)
{
	int Status;
	int Delay;
	 Delay=100000;
	if(IIC_valid!=0x55)i2c_init(&IicInstance, IIC_DEVICE_ID,100000);
	Status = XIicPs_MasterRecvPolled(&IicInstance, buf,byte_num, i2c_slave_addr>>1);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	while (XIicPs_BusIsBusy(&IicInstance))
	{
		Delay--;
		usleep(1);
		if(Delay==0)return XST_FAILURE;//
	}
	return XST_SUCCESS;
}
