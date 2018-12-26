clc
close all
clear all

global enable_acquire program_running

enable_acquire = false;
program_running = true;

%f = figure('Position',[50 100 1200 600]);
f = figure(1);
set(f, 'Position',[150 200 1000 500]);
set(f,'CloseRequestFcn', @closereq);

% [x offset  y offset  x dimension  y dimension]
panel = uipanel('Position',[.001 .001 .1 .2]);
btn_ping = uicontrol(panel,'Style','pushbutton');
btn_ping.String = 'Ping ports';
btn_ping.Callback = @f_control_acquire;
set(btn_ping,'Position',[10 90 100 25])

btn_trim_data = uicontrol(panel,'Style','pushbutton');
btn_trim_data.String = 'Trim Data';
btn_trim_data.Callback = @f_trim_data;
set(btn_trim_data,'Position',[10 60 100 25])

function closereq(~, ~)
    global program_running
    close all
    program_running=false;
end