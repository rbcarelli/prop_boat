function f_configure_daq(~,~)

    global packet_size mydaq sample_rate

    prompt1 = {'Device Name','Input baudrate','Input Sample Rate'};
    title = 'DAQ Configuration';
    dims = [1 50];
    definput = {'DEV1','9600','500'};
    input = string(inputdlg(prompt1,title,dims,definput));
    
    fprintf('Configuring DAQ\r')
      
    f = waitbar(0,'Configuring DAQ');
    
    mydaq = daq.createSession('ni');
    addAnalogInputChannel(mydaq,input(1), [1 2 3], 'Voltage');
    addAnalogOutputChannel(mydaq,input(1),0,'Voltage');
    sample_rate = str2num(input(3));
    mydaq.Rate = sample_rate;
    mydaq.IsContinuous = true;

    packet_size = sample_rate;         %set this with a prompt
    mydaq.NotifyWhenDataAvailableExceeds = packet_size;
 
    close(f)
    
    fprintf('DAQ configured\r')
    
end