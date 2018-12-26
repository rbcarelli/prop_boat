function f_configure_daq

    global packet_size daq sample_rate

    % prompt = {'Input data rate'};
    % title = 'Serial Port';
    % dims = [1 30];
    % definput = {'COM'};
    % serial_port = string(inputdlg(prompt,title,dims,definput))

    daq = daq.createSession('ni');
    addAnalogInputChannel(daq,'cDAQ1Mod1', 0, 'Voltage');
    sample_rate = 2000
    daq.Rate = sample_rate;

    packet_size = 5000;         %set this with a prompt
    daq.NotifyWhenDataAvailableExceeds = packet_size;

end