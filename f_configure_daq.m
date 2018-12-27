function f_configure_daq(~,~)

    global packet_size mydaq sample_rate

    % prompt = {'Input data rate'};
    % title = 'Serial Port';
    % dims = [1 30];
    % definput = {'COM'};
    % serial_port = string(inputdlg(prompt,title,dims,definput))

    fprintf('Configuring DAQ\r')
    
    mydaq = daq.createSession('ni');
    addAnalogInputChannel(mydaq,'Dev1', 0, 'Voltage');
    addAnalogInputChannel(mydaq,'Dev1', 1, 'Voltage');
    addAnalogInputChannel(mydaq,'Dev1', 2, 'Voltage');
    sample_rate = 2000;
    mydaq.Rate = sample_rate;
    mydaq.IsContinuous = true;

    packet_size = 2000;         %set this with a prompt
    mydaq.NotifyWhenDataAvailableExceeds = packet_size;
    
    fprintf('DAQ configured\r')

end