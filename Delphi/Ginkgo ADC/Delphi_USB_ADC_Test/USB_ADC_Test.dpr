program USB_ADC_Test;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ControlADC in 'ControlADC.pas';
var
ret,i:Integer;
write_buffer:Array[0..1024] Of Byte;
read_buffer:Array[0..1024] Of Byte;
adc_datas:Array[0..4095] Of Word;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    //Scan device(must call)
    ret := VAI_ScanDevice(1);
    if ret<=0 then
      Writeln('No device connect!');
    //Open device(must call)
    ret := VAI_OpenDevice(VAI_USBADC,0,0);
    if ret <> ERR_SUCCESS then
      Writeln('Open device error!');
    //��ʼ��ADC��ADC_CH0ͨ��
    ret := VAI_InitADC(VAI_USBADC, 0, VAI_ADC_CH0,0);//���ÿ��ÿ��ͨ��ֻ��һ�����ݣ������ڿ�����Ϊ0
    if ret <> ERR_SUCCESS then
      Writeln('Initialize ADC error!')
    else
      Writeln('Initialize ADC success!');
    //��ȡADC_CH0ͨ���ĵ�ѹֵ
    ret := VAI_ReadDatas(VAI_USBADC, 0, 1, @adc_datas[0]);
    if ret <> ERR_SUCCESS then
      Writeln('Read ADC data error!')
    else
      Writeln(Format('ADC_CH0 = %.3f' ,[(adc_datas[0]*3.3)/4095]));
    //��ʼ��ADC��ADC_CH0,ADC_CH1ͨ��
    ret := VAI_InitADC(VAI_USBADC, 0, VAI_ADC_CH0 or VAI_ADC_CH1,0);//���ÿ��ÿ��ͨ��ֻ��һ�����ݣ������ڿ�����Ϊ0
    if ret <> ERR_SUCCESS then
      Writeln('Initialize ADC error!')
    else
      Writeln('Initialize ADC success!');
    //��ȡADC_CH0,ADC_CH1ͨ���ĵ�ѹֵ��ÿ��ͨ����ȡһ��ֵ��
    ret := VAI_ReadDatas(VAI_USBADC, 0, 1, @adc_datas[0]);
    if ret <> ERR_SUCCESS then
      Writeln('Read ADC data error!')
    else
    begin
      Writeln(Format('ADC_CH0 = %.3f' ,[(adc_datas[0]*3.3)/4095]));
      Writeln(Format('ADC_CH1 = %.3f' ,[(adc_datas[1]*3.3)/4095]));
    end;
    //��ʼ��ADC��ADC_CH0,ADC_CH1ͨ��,ÿ��ͨ������ʱ��������Ϊ1000΢��
    ret := VAI_InitADC(VAI_USBADC, 0, VAI_ADC_CH0 or VAI_ADC_CH1,1000);//���ÿ��ÿ��ͨ��ֻ��һ�����ݣ������ڿ�����Ϊ0
    if ret <> ERR_SUCCESS then
      Writeln('Initialize ADC error!')
    else
      Writeln('Initialize ADC success!');
    //��ȡADC_CH0,ADC_CH1ͨ���ĵ�ѹֵ��ÿ��ͨ����ȡ10��ֵ��
    ret := VAI_ReadDatas(VAI_USBADC, 0, 10, @adc_datas[0]);//ÿ��ͨ����ȡ10��ֵ���ܹ�����20��ֵ����ʱ1000us*10 = 10ms
    if ret <> ERR_SUCCESS then
      Writeln('Read ADC data error!')
    else
    begin
    for i := 0 to 9 do
      Writeln(Format('ADC_CH0[%d] = %.3f' ,[i,(adc_datas[i*2]*3.3)/4095]));
    for i := 0 to 9 do
      Writeln(Format('ADC_CH1[%d] = %.3f' ,[i,(adc_datas[i*2+1]*3.3)/4095]));
    end;
    //Close device
    ret := VAI_CloseDevice(VAI_USBADC, 0);
    if ret <> ERR_SUCCESS then
      Writeln('Close device error!')
    else
      Writeln('Close device success!');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.