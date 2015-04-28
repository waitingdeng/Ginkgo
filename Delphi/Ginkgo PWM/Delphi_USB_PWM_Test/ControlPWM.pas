unit ControlPWM;

interface
const
//Device type definition
VAI_USBADC	=	1;
VCI_USBCAN1	=	3;
VCI_USBCAN2	=	4;
VGI_USBGPIO	=	1;
VII_USBI2C	=	1;
VSI_USBSPI	=	2;
VPI_USBPWM  = 2;
//�����붨��
ERR_SUCCESS					      =	(0);		// û�д���
ERR_PARAMETER_NULL			  =	(-1);	  // �����ָ��Ϊ��ָ��
ERR_INPUT_DATA_TOO_MUCH		=	(-2);	  // ���������������涨����
ERR_INPUT_DATA_TOO_LESS		=	(-3);	  // ���������������涨����
ERR_INPUT_DATA_ILLEGALITY	=	(-4);	  // ���������ʽ�͹涨�Ĳ�����
ERR_USB_WRITE_DATA			  =	(-5);	  // USBд���ݴ���
ERR_USB_READ_DATA			    =	(-6);	  // USB�����ݴ���
ERR_READ_NO_DATA			    =	(-7);	  // ���������ʱ����û������
ERR_OPEN_DEVICE				    =	(-8);	  // ���豸ʧ��
ERR_CLOSE_DEVICE			    =	(-9);	  // �ر��豸ʧ��
ERR_EXECUTE_CMD				    =	(-10);	// �豸ִ������ʧ��
ERR_SELECT_DEVICE			    =	(-11);	// ѡ���豸ʧ��
ERR_DEVICE_OPENED			    =	(-12);	// �豸�Ѿ���
ERR_DEVICE_NOTOPEN			  =	(-13);	// �豸û�д�
ERR_BUFFER_OVERFLOW			  =	(-14);	// ���������
ERR_DEVICE_NOTEXIST			  =	(-15);	// ���豸������
ERR_LOAD_KERNELDLL			  =	(-16);	// װ�ض�̬��ʧ��
ERR_CMD_FAILED				    =	(-17);	// ִ������ʧ�ܴ�����
ERR_BUFFER_CREATE			    =	(-18);	// �ڴ治��
//����GPIO���ź�
VPI_PWM_CH0		= (1 shl 0);	//PWM_CH0
VPI_PWM_CH1		= (1 shl 1);	//PWM_CH1
VPI_PWM_CH2		= (1 shl 2);	//PWM_CH2
VPI_PWM_CH3		= (1 shl 3);	//PWM_CH3
VPI_PWM_CH4		= (1 shl 4);	//PWM_CH4
VPI_PWM_CH5		= (1 shl 5);	//PWM_CH5
VPI_PWM_CH6		= (1 shl 6);	//PWM_CH6
VPI_PWM_CH7		= (1 shl 7);	//PWM_CH7
VPI_PWM_ALL   = ($FF);      //PWM_ALL

//USB-PWM��ʼ���ṹ��
type
PVPI_INIT_CONFIG = ^VPI_INIT_CONFIG;
VPI_INIT_CONFIG = record
  PWM_ChannelMask:Byte; //PWM�����ţ�ÿ��bit��Ӧһ��ͨ��
  PWM_Mode:Byte;        //PWMģʽ��ȡֵ0����1
  PWM_Pulse:Byte;       //PWMռ�ձ�,0��100֮��ȡֵ
  PWM_Polarity:Byte;    //PWM������ԣ�ȡֵ0����1
  PWM_Frequency:Integer;//PWMƵ��,1��1000000֮��ȡֵ
end;

//��������
function VPI_ScanDevice(NeedInit:Byte):Integer; stdcall;
function VPI_OpenDevice(DevType,DevIndex,Reserved:Integer):Integer; stdcall;
function VPI_CloseDevice(DevType,DevIndex:Integer):Integer; stdcall;
function VPI_InitPWM(DevType,DevIndex:Integer;pInitConfig:PVPI_INIT_CONFIG):Integer; stdcall;
function VPI_StartPWM(DevType,DevIndex:Integer; ChannelMask:Byte):Integer; stdcall;
function VPI_StopPWM(DevType,DevIndex:Integer; ChannelMask:Byte):Integer; stdcall;
function VPI_SetPWMPulse(DevType,DevIndex:Integer; ChannelMask:Byte; pPulse:PByte):Integer; stdcall;
function VPI_SetPWMPeriod(DevType,DevIndex:Integer; ChannelMask:Byte;pFrequency:PInteger):Integer; stdcall;
implementation
function VPI_ScanDevice;external 'Ginkgo_Driver.dll' name 'VPI_ScanDevice';
function VPI_OpenDevice;external 'Ginkgo_Driver.dll' name 'VPI_OpenDevice';
function VPI_CloseDevice;external 'Ginkgo_Driver.dll' name 'VPI_CloseDevice';
function VPI_InitPWM;external 'Ginkgo_Driver.dll' name 'VPI_InitPWM';
function VPI_StartPWM;external 'Ginkgo_Driver.dll' name 'VPI_StartPWM';
function VPI_StopPWM;external 'Ginkgo_Driver.dll' name 'VPI_StopPWM';
function VPI_SetPWMPulse;external 'Ginkgo_Driver.dll' name 'VPI_SetPWMPulse';
function VPI_SetPWMPeriod;external 'Ginkgo_Driver.dll' name 'VPI_SetPWMPeriod';
end.