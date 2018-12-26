%see connected devices
devices = daq.getDevices

%display info about daq in position num_daq
devices(num_daq)

%add daq to system
s = daq.createSession('ni');    

%add channel for colleciton
addAnalogInputChannel(s,'cDAQ1Mod4', 0, 'Voltage');
addAnalogInputChannel(s,'cDAQ1Mod4', 1, 'Voltage');    

%samples collected/sec
s.Rate = 8000         

%%

s = daq.createSession('ni');
addAnalogInputChannel(s,'cDAQ1Mod1', 0, 'Voltage');
s.Rate = 2000;
s.DurationInSeconds = 5;
s