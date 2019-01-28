clc
close all
clear all

global enable_acquire program_running daq_status 

enable_acquire = false;
program_running = true;
    
%f = figure('Position',[50 100 1200 600]);
f = figure(1);
set(f, 'Position',[50 100 1400 650]);
set(f,'CloseRequestFcn', @closereq);

% [x offset  y offset  x dimension  y dimension]
setup_panel = uipanel('Position',[.001 .261 .1 .13]);
operate_panel = uipanel('Position',[.001 .001 .1 .26]);

btn_configure_daq = uicontrol(setup_panel,'Style','togglebutton');
btn_configure_daq.String = 'Configure DAQ';
btn_configure_daq.Callback = @f_configure_daq;
set(btn_configure_daq,'Position',[10 45 100 25])

btn_config_serial = uicontrol(setup_panel,'Style','togglebutton');
btn_config_serial.String = 'Open Port';
btn_config_serial.Callback = @f_serial_port_open;
set(btn_config_serial,'Position',[10 15 100 25])

btn_acquire_enable = uicontrol(operate_panel,'Style','togglebutton');
btn_acquire_enable.String = 'Start/Stop reading';
btn_acquire_enable.Callback = @f_control_acquire;
set(btn_acquire_enable,'Position',[10 135 100 25])

btn_operate = uicontrol(operate_panel,'Style','pushbutton');
btn_operate.String = 'Operate';
btn_operate.Callback = @f_operate;
set(btn_operate,'Position',[10 105 100 25])

btn_read_rpm = uicontrol(operate_panel,'Style','togglebutton');
btn_read_rpm.String = 'Start/Stop motor';
btn_read_rpm.Callback = @f_read_rpm;
set(btn_read_rpm,'Position',[10 75 100 25])

btn_reset = uicontrol(operate_panel,'Style','pushbutton');
btn_reset.String = 'Reset';
btn_reset.Callback = @f_reset;
set(btn_reset,'Position',[10 45 100 25])

btn_trim_data = uicontrol(operate_panel,'Style','pushbutton');
btn_trim_data.String = 'Trim Data';
btn_trim_data.Callback = @f_trim_data;
set(btn_trim_data,'Position',[10 15 100 25])
f_reset_plots()

function closereq(~, ~)
    global program_running port 
    close all
    program_running=false;
    port_exists = exist (port);
    if port_exists
        fclose(port);
    end
    
end